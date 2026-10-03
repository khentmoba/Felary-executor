// Felary-Injector (Stage 1: LoadLibrary delivery for testing only)
//
// Finds RobloxPlayerBeta.exe, injects FelaryExecutor.dll via CreateRemoteThread.
// This is NOT stealthy: Hyperion sees LoadLibrary plainly. Use ONLY on throwaway
// alt accounts to validate delivery + the parked-DLL handshake. Never your main,
// ideally with a spoofer (HWID bans are real).
//
// Usage: Felary-Injector.exe [path-to-dll]
//   default DLL: FelaryExecutor.dll next to this exe.
//
#include <windows.h>
#include <tlhelp32.h>
#include <psapi.h>

#include <cstdio>
#include <string>

#pragma comment(lib, "psapi.lib")

static DWORD FindBiggestRoblox() {
    DWORD best = 0;
    SIZE_T biggest = 0;
    HANDLE snap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if (snap == INVALID_HANDLE_VALUE) return 0;
    PROCESSENTRY32W pe{};
    pe.dwSize = sizeof(pe);
    if (Process32FirstW(snap, &pe)) {
        do {
            if (_wcsicmp(pe.szExeFile, L"RobloxPlayerBeta.exe") != 0) continue;
            HANDLE h = OpenProcess(PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, FALSE, pe.th32ProcessID);
            if (h) {
                PROCESS_MEMORY_COUNTERS pmc{};
                if (GetProcessMemoryInfo(h, &pmc, sizeof(pmc)) && pmc.WorkingSetSize > biggest) {
                    biggest = pmc.WorkingSetSize;
                    best = pe.th32ProcessID;
                }
                CloseHandle(h);
            } else if (!best) {
                best = pe.th32ProcessID;
            }
        } while (Process32NextW(snap, &pe));
    }
    CloseHandle(snap);
    return best;
}

static void EnableDebugPriv() {
    HANDLE tok = nullptr;
    if (!OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &tok)) return;
    TOKEN_PRIVILEGES tp{};
    tp.PrivilegeCount = 1;
    if (LookupPrivilegeValueW(nullptr, SE_DEBUG_NAME, &tp.Privileges[0].Luid)) {
        tp.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED;
        AdjustTokenPrivileges(tok, FALSE, &tp, sizeof(tp), nullptr, nullptr);
    }
    CloseHandle(tok);
}

int wmain(int argc, wchar_t** argv) {
    printf("[Felary-Injector] stage 1 (LoadLibrary, NOT stealthy -- alts only)\n");

    wchar_t dllPath[MAX_PATH]{};
    if (argc >= 2) {
        wcsncpy_s(dllPath, argv[1], _TRUNCATE);
    } else {
        GetModuleFileNameW(nullptr, dllPath, MAX_PATH);
        wchar_t* slash = wcsrchr(dllPath, L'\\');
        if (!slash) return 1;
        wcscpy_s(slash + 1, MAX_PATH - (slash + 1 - dllPath), L"FelaryExecutor.dll");
    }
    if (GetFileAttributesW(dllPath) == INVALID_FILE_ATTRIBUTES) {
        wprintf(L"[!] DLL not found: %s\n", dllPath);
        wprintf(L"    Build Felary Executor Module (Release x64) and copy FelaryExecutor.dll next to this exe,\n");
        wprintf(L"    or pass the path: Felary-Injector.exe C:\\path\\to\\FelaryExecutor.dll\n");
        return 1;
    }
    wprintf(L"[*] DLL: %s\n", dllPath);

    DWORD pid = FindBiggestRoblox();
    if (!pid) {
        printf("[!] RobloxPlayerBeta.exe not running -- launch Roblox first.\n");
        return 1;
    }
    printf("[*] target PID: %lu\n", pid);

    EnableDebugPriv();

    HANDLE hProc = OpenProcess(PROCESS_CREATE_THREAD | PROCESS_VM_OPERATION |
                               PROCESS_VM_WRITE | PROCESS_VM_READ |
                               PROCESS_QUERY_INFORMATION,
                               FALSE, pid);
    if (!hProc) {
        printf("[!] OpenProcess failed (%lu). Run as admin. Hyperion may be denying the handle.\n",
               GetLastError());
        return 1;
    }

    SIZE_T len = (wcslen(dllPath) + 1) * sizeof(wchar_t);
    LPVOID remote = VirtualAllocEx(hProc, nullptr, len, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE);
    if (!remote) {
        printf("[!] VirtualAllocEx failed (%lu).\n", GetLastError());
        CloseHandle(hProc);
        return 1;
    }
    if (!WriteProcessMemory(hProc, remote, dllPath, len, nullptr)) {
        printf("[!] WriteProcessMemory failed (%lu).\n", GetLastError());
        CloseHandle(hProc);
        return 1;
    }

    HMODULE k32 = GetModuleHandleW(L"kernel32.dll");
    auto loadlib = reinterpret_cast<LPTHREAD_START_ROUTINE>(GetProcAddress(k32, "LoadLibraryW"));
    HANDLE hThread = CreateRemoteThread(hProc, nullptr, 0, loadlib, remote, 0, nullptr);
    if (!hThread) {
        printf("[!] CreateRemoteThread failed (%lu). Hyperion is likely blocking thread creation.\n",
               GetLastError());
        printf("    This is expected on current Hyperion -- Stage 2 (manual map) is the next step.\n");
        CloseHandle(hProc);
        return 1;
    }

    printf("[*] remote thread started, waiting...\n");
    WaitForSingleObject(hThread, 10000);
    DWORD exitCode = 0;
    GetExitCodeThread(hThread, &exitCode);
    CloseHandle(hThread);
    VirtualFreeEx(hProc, remote, 0, MEM_RELEASE);
    CloseHandle(hProc);

    if (exitCode == 0 || exitCode == STILL_ACTIVE) {
        printf("[!] LoadLibrary in target returned NULL -- injection failed.\n");
        return 1;
    }
    printf("[+] injected: remote module base 0x%p\n", reinterpret_cast<void*>(exitCode));
    printf("[*] The parked DLL only calls OutputDebugString (no writes/calls).\n");
    printf("    Watch DebugView/x64dbg for 'FelaryExecutor: function offsets STALE'.\n");
    printf("    If Roblox crashes or closes: note what happened -- that data matters.\n");
    return 0;
}
