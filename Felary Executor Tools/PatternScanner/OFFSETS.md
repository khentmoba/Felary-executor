# Felary Executor — Offset Playbook

Target client: **version-02c37bc51a384b8f** (live as of 03/10/2026).
Tool: `Felary Executor Tools/PatternScanner/` (`live_scanner.py` = live process,
`scanner.py` = offline file, `patterns.json` = pattern DB).

## Status per offset

| Offset | Status | Evidence / next step |
|---|---|---|
| `DataModel::Children` 0x78 | ✅ verified | unchanged old→new dump |
| `DataModel::GameLoaded` 0x5d0 | ✅ verified | old dump = 0x638 = YuB-X value, new = 0x5d0 |
| `DataModel::ScriptContext` 0x440 | ✅ verified | unchanged |
| `FakeDataModelToDataModel` 0x1F8 | ✅ verified | old = 0x1D0 = YuB-X value |
| `FakeDataModelPointer` 0x8B54980 | ✅ verified | old = 0x78FF228 = YuB-X value |
| `RequireBypass` 0x9E1 | ⚠️ carried over | dumper reports 0x0 (unresolved) in both eras — needs runtime probing |
| `ScriptContextToResume` 0x7F8 | ⚠️ carried over | no public-dump coverage — verify with resume (below) |
| `Luau_Execute` | 🔍 pattern CONFIRMED | Ducks + RbxStu sigs agree: **1 hit, same address** on live Sep-23 client. Re-run on target client, expect 1 hit |
| `Print` | ❌ pattern dead, **stubbed out** | 0 hits live. Was only error logging → replaced with `OutputDebugStringA` (`DebugLog`). No longer blocks anything |
| `Luau_Execute` / `LuaO_NilObject` / `LuaH_DummyNode` | ➖ unused | never called in Module code — no action needed |
| `GetLuaStateForInstance` | ❌ open | RbxStu `getGlobalState` Studio sig: 0 hits on Player. Needs Player-side RE (see §3) |
| `ScriptContextResume` | ❌ open | `"$Script"` string exists (1 hit) but has **0 LEA xrefs** — old WeAreDevs trick is dead. RbxStu Studio `resume` sig: 0 hits. Needs Player-side RE (see §3) |
| `OpcodeLookupTable` | ❌ open, **plus logic risk** | 0 register-form `imul *,*,227` sites live. The `×227` multiplier itself may be per-build — even with the right table address, `BytecodeEncoder`'s formula must be re-validated against the new client's decode routine (see §3) |

## 1. How to (re-)run the dump

1. Launch Roblox Player once — it self-updates to the current version
   (this is how `Versions/version-02c37bc51a384b8f/` arrived on 04/10).
2. Join any game (or sit at homepage) so engine/VM code pages decrypt.
3. As admin: `python live_scanner.py` (auto-finds `RobloxPlayerBeta.exe`).
4. Read-only: `PROCESS_VM_READ` only. No writes, no injection.
5. Every hit must pass the validation rules (§2) before going into `Roblox/Offsets.hpp`.
6. Flip `kOffsetsVerified` only when **all blockers** (GetLuaState, table, RequireBypass) are confirmed.

## 2. Validation rules (learned the hard way)

- **Never trust disk bytes.** `.text` on disk is Hyperion-encrypted (entropy ≈ 8.0,
  disassembly is garbage). Offline `scanner.py` is only good for strings/data.
  Code patterns MUST run live.
- **Ciphertext gives false positives.** Never-executed pages stay encrypted in
  memory too — a pattern can "hit" inside ciphertext. Every hit must disassemble
  to sane code AND sit in a real function (CC padding / prologue before it).
  Example: 3 of 4 early `imul 227` hits were garbage/encrypted regions.
- **Decode the ModRM.** `69 ?? E3 00 00 00` is NOT enough — a memory-form imul
  with disp8 `0xE3` followed by zeros matches by coincidence
  (`imul esi,[rbx-0x1d],0` bit us). `live_scanner.py` now requires mod==0b11
  (register form) for `imul_const`.
- **Studio sigs do NOT transfer to Player.** All RbxStu Studio patterns tested:
  0 hits on live Player (different build/inlining). Roles transfer, bytes don't.
- **Single-hit + cross-confirm = strong.** `Luau_Execute` via two independent
  sigs landing on the same address is the bar for "confirmed".

## 3. Open RE work (concrete leads, no hand-waving)

- **GetLuaStateForInstance.** Role: ScriptContext → `lua_State` (+ sets
  RequireBypass byte at +0x9E1 — verify that offset here too: the function
  writes a boolean early; the write target's displacement IS RequireBypass).
  Approach: attach x64dbg to a *test* client, break on RenderStepped-side script
  activity, backtrace to the state-fetch; or string-hunt for ScriptContext
  error paths near state access. One solid Player sig replaces all of this.
- **ScriptContextResume.** YuB-X calls it for yielding (`Yielding.cpp`) —
  needed for async (Http), not for the first `print` test. Approach: find via
  `resumeDelayedThreads`-style waiters, or break on coroutine resume in x64dbg
  while a yielding script runs in Studio (no Hyperion there) and port the sig.
- **OpcodeLookupTable + encoder formula.** Find the client's bytecode *decode*
  (lvmload path): it multiplies/shuffles with the same table. Extract the real
  multiplier + table layout, then fix `BytecodeEncoder::encode` to match —
  address AND formula. Until then, no script compiles to valid bytecode.
- **RequireBypass / ScriptContextToResume.** Confirm at runtime: with the DLL
  parked-but-injected (reads are safe — struct offsets are verified), dump the
  ScriptContext/ExtraSpace region and compare against expectations before
  flipping `kOffsetsVerified`.

## 4. Ghidra pipeline (new)

- Ghidra 12.1.3 headless works with JDK 21 (Android Studio JBR).
  Project: `Felary Executor Tools/Ghidra/work/felary` (gitignored),
  scripts in `Ghidra/scripts/` (committed). You can also open the same
  project in Ghidra GUI — program `/dumped.exe`.
- `dumped.exe`: full decrypted dump of the TARGET client via the sebastian
  `NtFlushInstructionCache` trick (`tools-sebastian/`, built with MSVC +
  `NOMINMAX` fix). 50 MB of 102 MB hot pages decrypted, 0 dead pages.
- `.py` Ghidra scripts do NOT run headless (needs PyGhidra); use `.java`.
  `DecompileAt.java` hits a decompiler-classpath issue headless — parked
  until candidates exist (capstone already covers disassembly needs).
- Confirmed on target: `Luau_Execute = REBASE(0x2681D50)`,
  `luaD_throw = REBASE(0x26520B0)`. The `06 -> 05` byte means a Luau
  struct field moved — relevant when syncing vendored Luau structs.
- RbxStu landmark sweep on target: only `luaD_throw` transfers; all other
  Studio sigs (pushvalue, newthread, step, H_new, freeblock, settable,
  gettable, luau_load, LuaVM_Load, ExtraSpace_init, scriptStart,
  getGlobalState, resume, task_defer, getDataModel) score 0 on Player.
- String-chasing exhausted: `"$Script"`/job-name strings have no LEA xrefs
  (direct or two-hop via .data descriptors); `"Heartbeat"` xrefs lead to
  generic job/thunk code, not scheduler core.

## 5. The +0x7F8 resume chain (live, target client)

- Byte-hunt for `LEA reg,[reg+0x7F8]` across live memory: **6 hits**, all in
  real decrypted code. `ScriptContextToResume = 0x7F8` is corroborated as a
  live ScriptContext/ExtraSpace offset (holds a thread vector: sites walk
  `[x+0x10]-[x+8]>>3` = vector size, plus a destructor chain walking
  `+0x7F8/+0x7F0/+0x7D0...` = ScriptContext teardown).
- Chain: `0x386FF4D`-func (`lea rcx,[rbx+0x7F8]` + thread fields
  `[rsi+0x98/0xA0]` + status byte + `inc [rbx+0x7F0]`) calls iterator
  `0x38719C9` (walks the thread vector, calls per entry) which calls
  per-thread worker `0x38721E40` — the resume candidate.
- BLOCKED at homepage: `0x38721E40` lives in the unnamed data section
  (`0x8B93000` on disk) and is not committed live — the page only decrypts
  when threads actually wait. Its caller has no direct callers (scheduler
  dispatches via pointers).
- `RequireBypass` 0x9E1: ZERO byte accesses (mov/test/movzx forms) in all
  live memory — offset moved or client never touches it. Must re-derive.
- NEXT: re-run the full suite with a game loaded (yielded threads exist →
  resume chain decrypts). Just join any game and say `scan now`.

## 6. History

- YuB-X era (`version-ad5d3e2906444472`): all values confirmed against theo's
  archived dump for that version — old dump matches YuB-X hardcodes exactly.
- `454150d`: struct offsets updated to `version-02c37bc51a384b8f`, exploit
  thread parked behind `kOffsetsVerified`.
- This doc: live scanner built, `Luau_Execute` pattern confirmed live (Sep-23
  client), Print stubbed, Studio-sig avenue closed, imul matcher fixed.
