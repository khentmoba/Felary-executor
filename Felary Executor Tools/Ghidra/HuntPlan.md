# Post-analysis hunt plan (for when background analysis completes)

Run from `Ghidra/work` (project `felary`, program `dumped2.exe`).
Check completion: `analysis.log` shows `REPORT: Analysis complete`, and no
`java.exe` for this job remains.

## 0. Caveats

- Cold pages are still ciphertext: analysis created BOGUS functions/xrefs
  there. Trust only RVAs proven hot (live reads) — the list below.
- Ciphertext xrefs are noise. A target is real only if its bytes disassemble
  sanely (verify with `live_scanner.py`/`disasm_rva.py` against PID).

## 1. Walk UP from the pcall twins (find task layer)

```
-postScript FindCallers.java 0x2699CF3
-postScript FindCallers.java 0x269A765
```

For each caller: `DecompileAt.java <caller>`, identify it (task.spawn path?
pcall wrapper?). Then FindCallers on IT. Two levels up should reach
scheduler/task-dispatch code. Sibling calls at that level are resume/state
candidates — decompile and compare against YuB-X's call shapes
(`GetLuaStateForInstance`: 3 args; `ScriptContextResume`: 6 args).

## 2. Decompile the +0x7F8 chain (all hot, verified live)

```
-postScript DecompileAt.java 0x1593DFA   (init ctor)
-postScript DecompileAt.java 0x386FF4D   (queue-for-resume caller)
-postScript DecompileAt.java 0x38719C9   (waiting-thread iterator)
-postScript DecompileAt.java 0x411FA91   (teardown/dtor)
```

Read for: ExtraSpace field roles, the state pointer store, the exact
resume-call argument order (validates `ScriptContextToResume = 0x7F8` and
the 6-arg `ScriptContextResume` signature before we ever call it).

## 3. Opcode table

- Re-scan the analyzed image for `movzx *, byte [op + table]` + any
  multiplier (`imul *, *, imm32`, any imm — 227 is gone).
- Candidate: the `0x1E256E0`-area function (mask ops + table LEA at
  `+0x5104208` → `0x6F29A58`, proven a per-opcode FLAG table, not the
  shuffle map — still useful as a landmark for compiler-adjacent code).
- The shuffle DECODE must sit on the bytecode-load path (`luavm_load`
  neighborhood). Find `luau_load`-adjacent loaders via the pcall-twin
  callers (step 1) or via error-string xrefs.

## 4. RequireBypass (0x9E1, zero hits live)

- Only trust after analysis: search for byte accesses to `[reg+0x9E1]`.
- If still nothing, the offset moved: derive from the init/dtor field maps
  (step 2) — look for a boolean field the getter checks.

## 5. Confirm-before-paste rule

Every address goes through `live_scanner.py`/`disasm_rva.py` on the TARGET
client first: 1 hit, sane disassembly, plausible function. Then into
`Roblox/Offsets.hpp`, then flip `kOffsetsVerified` only when the full set
(state + resume + table + bypass) is green AND the first inject test passes.
