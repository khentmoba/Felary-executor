#!/usr/bin/env python3
"""Felary Executor — offline pattern scanner.

Scans a RobloxPlayerBeta.exe on DISK (no process, no Hyperion interaction)
and resolves function/data addresses for Roblox/Offsets.hpp.

Usage:
    pip install pefile capstone
    python scanner.py <RobloxPlayerBeta.exe> [--json patterns.json]

What it does per entry in patterns.json:
  - code_pattern : AOB scan with '?' wildcards, reports RVAs in .text
  - string_ref   : find ASCII string in .rdata, then find LEA RIP-relative
                   xrefs in .text, then walk back to function starts
  - imul_const   : find `imul r32, r/m32, <const>` sites (opcode hunting)

Output is REBASE-ready:  Print = REBASE(0x1DEC8F0);
Verify every hit before pasting — see OFFSETS.md playbook.
"""
import json
import struct
import sys

try:
    import pefile
except ImportError:
    sys.exit("need pefile: pip install pefile capstone")


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
    n = len(pat)
    out = []
    # naive but fine (~100MB, few patterns)
    start = 0
    while True:
        idx = buf.find(pat[0:1], start) if mask[0] else -1
        if mask[0] == 0:
            # leading wildcard: brute force
            found = -1
            for i in range(start, len(buf) - n + 1):
                ok = True
                for j in range(n):
                    if mask[j] and buf[i + j] != pat[j]:
                        ok = False
                        break
                if ok:
                    found = i
                    break
            if found < 0:
                break
            out.append(found)
            start = found + 1
        else:
            i = buf.find(bytes([pat[0]]), start)
            if i < 0 or i + n > len(buf):
                break
            ok = all((not mask[j]) or buf[i + j] == pat[j] for j in range(n))
            if ok:
                out.append(i)
                start = i + 1
            else:
                start = i + 1
    return out


class Image:
    def __init__(self, path):
        self.pe = pefile.PE(path, fast_load=False)
        self.secs = {}
        for s in self.pe.sections:
            name = s.Name.decode(errors="ignore").strip("\x00")
            self.secs[name] = s

    def raw(self, sec):
        s = self.secs[sec]
        return s.get_data()

    def rva_of(self, sec, file_off):
        s = self.secs[sec]
        return s.VirtualAddress + (file_off - s.PointerToRawData)

    def scan_section(self, sec, pat, mask):
        return [self.rva_of(sec, o) for o in aob_scan(self.raw(sec), pat, mask)]

    def find_string(self, text, sections=(".rdata", ".data", ".text")):
        needle = text.encode("ascii")
        hits = []
        for sec in sections:
            if sec not in self.secs:
                continue
            buf = self.raw(sec)
            start = 0
            while True:
                i = buf.find(needle, start)
                if i < 0:
                    break
                # prefer NUL-terminated whole strings
                end = i + len(needle)
                if end < len(buf) and buf[end] == 0:
                    hits.append((sec, self.rva_of(sec, i)))
                start = i + 1
        return hits

    def find_lea_xrefs(self, target_rva, sec=".text"):
        """Find RIP-relative LEAs in sec that resolve to target_rva."""
        buf = self.raw(sec)
        base = self.secs[sec].VirtualAddress
        out = []
        i = 0
        n = len(buf)
        while i < n - 7:
            b = buf[i]
            # optional REX prefix
            if 0x40 <= b <= 0x4F:
                if buf[i + 1] == 0x8D and (buf[i + 2] & 0xC7) == 0x05:
                    disp = struct.unpack("<i", buf[i + 3:i + 7])[0]
                    rva = base + i
                    if rva + 7 + disp == target_rva:
                        out.append(rva)
                    i += 7
                    continue
            elif b == 0x8D and (buf[i + 1] & 0xC7) == 0x05:
                disp = struct.unpack("<i", buf[i + 2:i + 6])[0]
                rva = base + i
                if rva + 6 + disp == target_rva:
                    out.append(rva)
                i += 6
                continue
            i += 1
        return out

    @staticmethod
    def func_start(buf, base, rva, limit=0x5000):
        """Walk back over CC/00 padding to find function start."""
        off = rva - base
        start = max(0, off - limit)
        i = off
        while i > start and buf[i - 1] in (0xCC, 0x00, 0x90):
            i -= 1
        return base + i, off - i  # func_rva, distance walked


def main():
    if len(sys.argv) < 2:
        sys.exit("usage: scanner.py <RobloxPlayerBeta.exe> [patterns.json]")
    exe = sys.argv[1]
    patfile = sys.argv[2] if len(sys.argv) > 2 else "patterns.json"
    with open(patfile, encoding="utf-8") as f:
        db = json.load(f)

    img = Image(exe)
    print(f"[*] {exe}")
    print(f"[*] SizeOfImage: 0x{img.pe.OPTIONAL_HEADER.SizeOfImage:X}")

    for entry in db["patterns"]:
        name = entry["name"]
        kind = entry["type"]
        print(f"\n=== {name} [{kind}] ===")
        if kind == "code_pattern":
            pat, mask = parse_pattern(entry["pattern"])
            for sec in entry.get("sections", [".text"]):
                if sec not in img.secs:
                    continue
                hits = img.scan_section(sec, pat, mask)
                print(f"  [{sec}] {len(hits)} hit(s)")
                for h in hits[:entry.get("show", 5)]:
                    print(f"    {name} = REBASE(0x{h:X});")
                if len(hits) > entry.get("show", 5):
                    print(f"    ... and {len(hits) - entry.get('show', 5)} more")
        elif kind == "string_ref":
            strs = img.find_string(entry["string"])
            print(f"  string {entry['string']!r}: {len(strs)} hit(s)")
            for sec, rva in strs[:5]:
                print(f"    @{sec}+0x{rva:X}")
                xrefs = img.find_lea_xrefs(rva)
                print(f"      {len(xrefs)} LEA xref(s)")
                buf = img.raw(".text")
                tbase = img.secs[".text"].VirtualAddress
                for x in xrefs[:entry.get("show", 10)]:
                    fstart, dist = Image.func_start(buf, tbase, x)
                    tag = "  <-- far" if dist > 0x1000 else ""
                    print(f"      xref @ 0x{x:X} -> func 0x{fstart:X} (+0x{dist:X} back){tag}")
        elif kind == "imul_const":
            c = entry["const"]
            # imul r32, r/m32, imm32  =>  69 /r <imm32>
            imm = struct.pack("<I", c)
            buf = img.raw(".text")
            tbase = img.secs[".text"].VirtualAddress
            hits = []
            start = 0
            while True:
                i = buf.find(b"\x69", start)
                if i < 0 or i + 6 > len(buf):
                    break
                if buf[i + 2:i + 6] == imm:
                    hits.append(tbase + i)
                start = i + 1
            print(f"  imul *,*,0x{c:X}: {len(hits)} hit(s)")
            for h in hits[:entry.get("show", 20)]:
                print(f"    @ 0x{h:X}")


if __name__ == "__main__":
    main()
