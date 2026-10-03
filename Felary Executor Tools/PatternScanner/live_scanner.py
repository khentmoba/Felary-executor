#!/usr/bin/env python3
"""Felary Executor — LIVE pattern scanner (Hyperion-aware workflow).

Why live, not offline: Roblox encrypts .text pages on disk (entropy ~8.0).
Patterns only match DECRYPTED pages in a RUNNING process, so this tool
attaches read-only (no writes, no injection) like the ESP external does.

Usage:
    1. Launch Roblox Player (any game / even the homepage) so code pages decrypt.
    2. pip install pefile capstone
    3. python live_scanner.py [--pid PID] [patterns.json]

    Run as Administrator if OpenProcess fails.

What it does per entry in patterns.json: same as scanner.py
(code_pattern / string_ref / imul_const), but against live memory.
Only committed, readable regions inside RobloxPlayerBeta.exe are scanned.

Output is REBASE-ready:  Print = REBASE(0x1DEC8F0);
Verify every hit before pasting — see OFFSETS.md playbook.
"""
import ctypes
import json
import struct
import sys
from ctypes import wintypes

k32 = ctypes.WinDLL("kernel32", use_last_error=True)
psapi = ctypes.WinDLL("psapi", use_last_error=True)

k32.OpenProcess.restype = wintypes.HANDLE
k32.OpenProcess.argtypes = [wintypes.DWORD, wintypes.BOOL, wintypes.DWORD]
k32.ReadProcessMemory.restype = wintypes.BOOL
k32.ReadProcessMemory.argtypes = [wintypes.HANDLE, wintypes.LPCVOID, wintypes.LPVOID,
                                    ctypes.c_size_t, ctypes.POINTER(ctypes.c_size_t)]
k32.VirtualQueryEx.restype = ctypes.c_size_t
k32.VirtualQueryEx.argtypes = [wintypes.HANDLE, wintypes.LPCVOID, wintypes.LPVOID, ctypes.c_size_t]
psapi.EnumProcessModules.restype = wintypes.BOOL
psapi.EnumProcessModules.argtypes = [wintypes.HANDLE, ctypes.c_void_p, wintypes.DWORD, ctypes.POINTER(wintypes.DWORD)]
psapi.GetModuleFileNameExW.restype = wintypes.DWORD
psapi.GetModuleFileNameExW.argtypes = [wintypes.HANDLE, wintypes.HMODULE, wintypes.LPWSTR, wintypes.DWORD]
psapi.GetModuleInformation.restype = wintypes.BOOL
psapi.GetModuleInformation.argtypes = [wintypes.HANDLE, wintypes.HMODULE, wintypes.LPVOID, wintypes.DWORD]

PROCESS_VM_READ = 0x0010
PROCESS_QUERY_INFORMATION = 0x0400
TH32CS_SNAPPROCESS = 0x2
TH32CS_SNAPMODULE = 0x8
MEM_COMMIT = 0x1000
PAGE_NOACCESS = 0x01
PAGE_GUARD = 0x100


class PROCESSENTRY32(ctypes.Structure):
    _fields_ = [("dwSize", wintypes.DWORD),
                ("cntUsage", wintypes.DWORD),
                ("th32ProcessID", wintypes.DWORD),
                ("th32DefaultHeapID", ctypes.c_ulonglong),
                ("th32ModuleID", wintypes.DWORD),
                ("cntThreads", wintypes.DWORD),
                ("th32ParentProcessID", wintypes.DWORD),
                ("pcPriClassBase", wintypes.LONG),
                ("dwFlags", wintypes.DWORD),
                ("szExeFile", wintypes.WCHAR * 260)]


class MEMORY_BASIC_INFORMATION(ctypes.Structure):
    _fields_ = [("BaseAddress", ctypes.c_void_p),
                ("AllocationBase", ctypes.c_void_p),
                ("AllocationProtect", wintypes.DWORD),
                ("RegionSize", ctypes.c_size_t),
                ("State", wintypes.DWORD),
                ("Protect", wintypes.DWORD),
                ("Type", wintypes.DWORD)]


def find_pid(name):
    snap = k32.CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
    if snap == -1:
        return None
    pe = PROCESSENTRY32()
    pe.dwSize = ctypes.sizeof(PROCESSENTRY32)
    pid = None
    if k32.Process32FirstW(snap, ctypes.byref(pe)):
        while True:
            if pe.szExeFile.lower() == name.lower():
                pid = pe.th32ProcessID
                break
            if not k32.Process32NextW(snap, ctypes.byref(pe)):
                break
    k32.CloseHandle(snap)
    return pid


def module_base(handle, exe_name):
    # first module of a process is the exe itself
    hmods = (wintypes.HMODULE * 1024)()
    needed = wintypes.DWORD()
    if not psapi.EnumProcessModules(handle, hmods, ctypes.sizeof(hmods), ctypes.byref(needed)):
        return None
    count = needed.value // ctypes.sizeof(wintypes.HMODULE)
    buf = ctypes.create_unicode_buffer(260)
    for i in range(count):
        if psapi.GetModuleFileNameExW(handle, hmods[i], buf, 260):
            if buf.value.lower().endswith(exe_name.lower()):
                mi_base = ctypes.c_void_p()
                mi_size = ctypes.c_size_t()
                # MODULEINFO {lpBaseOfDll, SizeOfImage, EntryPoint}
                class MODINFO(ctypes.Structure):
                    _fields_ = [("base", ctypes.c_void_p), ("size", wintypes.DWORD), ("entry", ctypes.c_void_p)]
                mi = MODINFO()
                if psapi.GetModuleInformation(handle, hmods[i], ctypes.byref(mi), ctypes.sizeof(mi)):
                    return mi.base, mi.size
    return None


def read_mem(handle, addr, size):
    buf = ctypes.create_string_buffer(size)
    got = ctypes.c_size_t()
    if not k32.ReadProcessMemory(handle, ctypes.c_void_p(addr), buf, size, ctypes.byref(got)):
        return None
    return buf.raw[:got.value]


def parse_pattern(pat):
    by, mk = bytearray(), bytearray()
    for tok in pat.split():
        if tok in ("?", "??"):
            by.append(0)
            mk.append(0)
        else:
            by.append(int(tok, 16))
            mk.append(1)
    return bytes(by), bytes(mk)


def aob_scan(buf, pat, mask):
    """buf: bytes. Returns file-relative offsets. C-speed first-byte filter."""
    n = len(pat)
    out = []
    if n == 0 or len(buf) < n:
        return out
    if mask[0]:
        first = bytes([pat[0]])
        start = 0
        while True:
            i = buf.find(first, start)
            if i < 0 or i + n > len(buf):
                break
            if all((not mask[j]) or buf[i + j] == pat[j] for j in range(n)):
                out.append(i)
            start = i + 1
    else:
        for i in range(len(buf) - n + 1):
            if all((not mask[j]) or buf[i + j] == pat[j] for j in range(n)):
                out.append(i)
    return out


class LiveImage:
    def __init__(self, pid, exe_name="RobloxPlayerBeta.exe"):
        self.handle = k32.OpenProcess(PROCESS_VM_READ | PROCESS_QUERY_INFORMATION, False, pid)
        if not self.handle:
            raise RuntimeError(f"OpenProcess({pid}) failed — run as admin, err {ctypes.get_last_error()}")
        mod = module_base(self.handle, exe_name)
        if not mod:
            raise RuntimeError("could not find exe module")
        self.base, self.size = mod
        print(f"[*] PID {pid}  exe base 0x{self.base:X}  size 0x{self.size:X}")

    def regions(self):
        out = []
        addr = self.base
        end = self.base + self.size
        mbi = MEMORY_BASIC_INFORMATION()
        sz = ctypes.sizeof(mbi)
        while addr < end:
            if k32.VirtualQueryEx(self.handle, addr, ctypes.byref(mbi), sz) != sz:
                break
            rbase = mbi.BaseAddress or 0
            if mbi.State == MEM_COMMIT and not (mbi.Protect & PAGE_GUARD) \
                    and not (mbi.Protect & PAGE_NOACCESS):
                rs, re = max(rbase, self.base), min(rbase + mbi.RegionSize, end)
                if re > rs:
                    out.append((rs, re - rs))
            if mbi.RegionSize == 0:
                break
            addr = rbase + mbi.RegionSize
        return out

    def scan_pattern(self, pat, mask):
        hits = []
        for base, size in self.regions():
            # chunk huge regions to bound single RPM size
            off = 0
            while off < size:
                chunk = min(size - off, 32 * 1024 * 1024)
                data = read_mem(self.handle, base + off, chunk)
                if data is None:
                    break
                # overlap windows so matches crossing chunk edges aren't lost
                for h in aob_scan(data, pat, mask):
                    hits.append(base + off + h - self.base)  # as RVA offset
                off += chunk
        return hits

    def find_string(self, text):
        needle = text.encode("ascii") + b"\x00"
        hits = []
        for base, size in self.regions():
            off = 0
            while off < size:
                chunk = min(size - off, 32 * 1024 * 1024)
                data = read_mem(self.handle, base + off, chunk)
                if data is None:
                    break
                s = 0
                while True:
                    i = data.find(needle, s)
                    if i < 0:
                        break
                    hits.append(base + off + i - self.base)
                    s = i + 1
                off += chunk
        return hits

    def find_lea_xrefs(self, target_rva):
        """LEA RIP-relative in any committed region resolving to target_rva.
        C-speed 0x8D search; Python only verifies candidates."""
        exe_base = self.base
        out = []
        for base, size in self.regions():
            off = 0
            while off < size:
                chunk = min(size - off, 32 * 1024 * 1024)
                data = read_mem(self.handle, base + off, chunk)
                if data is None:
                    break
                s = 0
                while True:
                    i = data.find(b"\x8d", s)
                    if i < 0 or i + 7 > len(data):
                        break
                    prev = data[i - 1] if i > 0 else 0
                    if 0x40 <= prev <= 0x4F and (data[i + 1] & 0xC7) == 0x05:
                        disp = struct.unpack("<i", data[i + 2:i + 6])[0]
                        if base + off + i - 1 + 7 + disp - exe_base == target_rva:
                            out.append(base + off + i - 1 - exe_base)
                    elif (data[i + 1] & 0xC7) == 0x05:
                        disp = struct.unpack("<i", data[i + 2:i + 6])[0]
                        if base + off + i + 6 + disp - exe_base == target_rva:
                            out.append(base + off + i - exe_base)
                    s = i + 1
                off += chunk
        return out


def func_start_live(img, rva, limit=0x5000):
    base = img.base + rva
    lo = max(img.base, base - limit)
    # walk back over CC/00/90 padding (single reads, small)
    cur = base
    while cur > lo:
        data = read_mem(img.handle, cur - 16, 16)
        if data is None:
            break
        j = 15
        while j >= 0 and cur - (15 - j) > lo and data[j] in (0xCC, 0x00, 0x90):
            j -= 1
        stepped = 15 - j
        if stepped == 0:
            break
        cur -= stepped
    return cur - img.base


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    pid = None
    for a in sys.argv[1:]:
        if a.startswith("--pid="):
            pid = int(a.split("=", 1)[1])
    exe_file = args[0] if args else "patterns.json"
    if pid is None:
        pid = find_pid("RobloxPlayerBeta.exe")
    if pid is None:
        sys.exit("RobloxPlayerBeta.exe not running — launch Roblox first.")
    with open(exe_file if exe_file.endswith(".json") else "patterns.json", encoding="utf-8") as f:
        db = json.load(f)

    img = LiveImage(pid)
    for entry in db["patterns"]:
        name, kind = entry["name"], entry["type"]
        print(f"\n=== {name} [{kind}] ({entry.get('status', '?')}) ===")
        if kind == "code_pattern":
            pat, mask = parse_pattern(entry["pattern"])
            hits = img.scan_pattern(pat, mask)
            print(f"  {len(hits)} hit(s)")
            for h in hits[:entry.get("show", 5)]:
                print(f"    {name} = REBASE(0x{h:X});")
        elif kind == "string_ref":
            strs = img.find_string(entry["string"])
            print(f"  string {entry['string']!r}: {len(strs)} hit(s)")
            for rva in strs[:5]:
                print(f"    @0x{rva:X}")
                for x in img.find_lea_xrefs(rva)[:entry.get("show", 10)]:
                    print(f"      xref @ 0x{x:X} -> func 0x{func_start_live(img, x):X}")
        elif kind == "imul_const":
            # imul r32, r32, imm32  =>  69 /r imm32 with mod==0b11 (register).
            # Memory-form imuls are skipped: their disp bytes cause false
            # positives (a disp8 0xE3 followed by zeros looks like imm 227).
            imm = struct.pack("<I", entry["const"])
            hits = []
            for base, size in img.regions():
                off = 0
                while off < size:
                    chunk = min(size - off, 32 * 1024 * 1024)
                    data = read_mem(img.handle, base + off, chunk)
                    if data is None:
                        break
                    s = 0
                    while True:
                        i = data.find(b"\x69", s)
                        if i < 0 or i + 6 > len(data):
                            break
                        if (data[i + 1] & 0xC0) == 0xC0 and data[i + 2:i + 6] == imm:
                            hits.append(base + off + i - img.base)
                        s = i + 1
                    off += chunk
            print(f"  imul *,*,0x{entry['const']:X}: {len(hits)} hit(s)")
            for h in hits[:entry.get("show", 20)]:
                print(f"    @ 0x{h:X}")


if __name__ == "__main__":
    main()
