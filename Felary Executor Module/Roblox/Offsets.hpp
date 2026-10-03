#pragma once

#include <cstdint>
#include <Windows.h>

struct lua_State;
struct YieldState;
struct YieldingLuaThread;

#define REBASE(Address) (Address + reinterpret_cast<uintptr_t>(GetModuleHandleA(nullptr)))

// ============================================================
// Felary Executor — offset table
// Target client: version-02c37bc51a384b8f (live as of 03/10/2026)
// Struct offsets verified against RbxDumperV2 2.2.4 dump
// (https://offsets.imtheo.lol/version-02c37bc51a384b8f/offsets.hpp,
//  dumped 29/09/2026; old-version dump for version-ad5d3e2906444472
//  used to confirm exactly what drifted).
//
// Status key:
//   [OK]      verified against the current dump
//   [STALE]   from version-ad5d3e2906444472 — MUST be re-dumped
//             from the live client before injecting (will crash)
//   [UNVERIF] not covered by the public dumper — carried over,
//             needs manual verification
// ============================================================

namespace Offsets
{
    // Flip to true only when EVERY address in this file is re-dumped for
    // the target client. dllmain parks the exploit thread while false.
    inline constexpr bool kOffsetsVerified = false;

    // [STALE] function addresses from version-ad5d3e2906444472.
    // Do NOT inject until these are re-dumped for the target client.
    const uintptr_t Print = REBASE(0x1DEC8F0);
    const uintptr_t OpcodeLookupTable = REBASE(0x5F42790);
    const uintptr_t ScriptContextResume = REBASE(0x1D67A90);
    const uintptr_t GetLuaStateForInstance = REBASE(0x1C95DD0);

    namespace Luau
    {
        // [OK-target] confirmed live on version-02c37bc51a384b8f (1 hit,
        // function head changed 80 79 06 00 -> 80 79 05 00). Unused in code.
        const uintptr_t Luau_Execute = REBASE(0x2681D50);
        // [STALE] see above. Both unused in code — no action needed.
        const uintptr_t LuaO_NilObject = REBASE(0x6688740);
        const uintptr_t LuaH_DummyNode = REBASE(0x66885E8);
    }

    namespace DataModel
    {
        const uintptr_t Children = 0x78;                 // [OK] unchanged (Instance::ChildrenStart)
        const uintptr_t GameLoaded = 0x5d0;              // [OK] was 0x638
        const uintptr_t ScriptContext = 0x440;           // [OK] unchanged
        const uintptr_t FakeDataModelToDataModel = 0x1F8; // [OK] was 0x1D0

        const uintptr_t FakeDataModelPointer = REBASE(0x8B54980); // [OK] was 0x78FF228
    }

    namespace ExtraSpace
    {
        // [UNVERIF] dumper reports ScriptContext::RequireBypass as 0x0
        // (unresolved) in both old and new dumps — carried over.
        const uintptr_t RequireBypass = 0x9E1;
        // [UNVERIF] no public-dump equivalent — carried over.
        const uintptr_t ScriptContextToResume = 0x7F8;
    }
}

namespace Roblox
{
    inline auto Print = (uintptr_t(*)(int, const char*, ...))Offsets::Print;
    inline auto Luau_Execute = (void(__fastcall*)(lua_State*))Offsets::Luau::Luau_Execute;
    inline auto GetLuaStateForInstance = (lua_State*(__fastcall*)(uint64_t, uint64_t*, uint64_t*))Offsets::GetLuaStateForInstance;
    inline auto ScriptContextResume = (uint64_t(__fastcall*)(uint64_t, YieldState*, YieldingLuaThread**, uint32_t, uint8_t, uint64_t))Offsets::ScriptContextResume;
}

// Dont forget to update Encryptions and Structs
