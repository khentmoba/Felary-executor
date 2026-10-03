# Felary Executor — Injector (INJECTOR.md)

## Safety rules (read first, no exceptions)

- **Alt accounts only. Never your main.** Injection violates Roblox's ToS.
- **HWID bans are real.** A detected inject can blacklist the machine, not
  just the account. A spoofer is strongly advised before any live test.
- **Stage 1 is for delivery validation, not stealth.** Hyperion sees
  `LoadLibrary` plainly. Expect flagging; keep sessions short and observe.
- The parked DLL (`kOffsetsVerified = false`) performs **no writes and no
  calls into Roblox code** — only `OutputDebugString`. Injecting it is the
  safe first test: success = handshake message, no crash.

## Layout

- `Felary Executor Injector/` — C++ console injector, Release x64 builds to
  `Felary-Injector.exe` (in the solution as `Felary Executor Injector`).
- `Felary Executor Interface/` — the UI. Its Inject button runs
  `Felary-Injector.exe` from the same folder (no downloads — the old
  `YOUR DOWNLOAD LINK HERE` placeholder is removed as a supply-chain risk).
- Deploy folder layout for testing:
  `FelaryExecutor.exe` (UI) + `Felary-Injector.exe` + `FelaryExecutor.dll`.

## Stage 1 — LoadLibrary (done)

`injector.cpp`: biggest-`RobloxPlayerBeta.exe` → `OpenProcess` → write DLL
path → `CreateRemoteThread(LoadLibraryW)` → report remote base.

Expected outcomes and what they mean:

| Result | Meaning | Next |
|---|---|---|
| `injected: remote module base ...` + DebugView shows `FelaryExecutor: ... STALE` | Delivery works, DLL parked safely | Offsets/track work continues; re-test after flip |
| `CreateRemoteThread failed` | Hyperion blocking thread creation | Normal on current builds → Stage 2 |
| Client closes/crashes on inject | Hyperion integrity/integrity-callback fired | Record version + behavior → Stage 2/3 design |
| `OpenProcess failed` | Permissions or handle stripping | Run as admin; if persists → Stage 2 |

## Stage 2 — Manual map (planned)

Map the DLL without the loader (no PEB module entry, headers erased,
imports/sections mapped by hand, entry via hijacked thread/APC instead of
`CreateRemoteThread`). Removes the loudest signals, still not a bypass.

## Stage 3 — Hyperion bypass (research)

Handle stripping, VEH/integrity callbacks, hypervisor-backed checks. This is
the long pole and breaks every client update. Do NOT start it until Stage 1
delivery + offsets are green — a bypass for a non-working DLL is worthless.

## First inject test (parked DLL)

1. Fresh alt account, Roblox Player running (any game).
2. Copy the three binaries into one folder. Start DebugView (or x64dbg) to
   see `OutputDebugString`.
3. Run `Felary-Injector.exe` as admin. Expect the `STALE` message and a
   still-alive client. Record the outcome in `CHANGELOG`-style notes.
