# Felary Executor

A Roblox internal script executor — forked from [YuB-X-Public](https://github.com/itz-vuxqzo/YuB-X-Public) and developed independently.

## Status

🚧 **In development** — currently updating for the latest Roblox client.

- [x] Baseline build (Module.dll compiles with v145 toolset)
- [ ] Offsets updated for current client
- [ ] Injector + injection pipeline
- [ ] First live execution test
- [ ] Environment expansion (UNC coverage)
- [ ] UI rebrand + polish

## Structure

- `Felary Executor Module/` — C++ internal DLL (execution, scheduler, environment, TCP comms)
- `Felary Executor Interface/` — C# UI (script editor, talks to DLL over `127.0.0.1:6969`)

## Building

Requires Visual Studio with the **v145 toolset** + Windows SDK 10.0.

```powershell
& "C:/Program Files/Microsoft Visual Studio/18/Community/MSBuild/Current/Bin/amd64/MSBuild.exe" `
  "Felary Executor Module/Felary Executor Module.vcxproj" -p:Configuration=Release -p:Platform=x64 -m
```

Output: `Felary Executor Module/x64/Release/FelaryExecutor.dll`

## Base credit

Original source: [itz-vuxqzo/YuB-X-Public](https://github.com/itz-vuxqzo/YuB-X-Public) —
Teleport handler, stable execution queue, identity 8.
Upstream: `version-ad5d3e2906444472`.

## Warning

Educational project. Only test on throwaway alts — injecting into live Roblox violates the ToS and will get accounts banned.
