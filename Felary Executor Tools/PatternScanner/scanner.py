#!/usr/bin/env python3
"""Felary Executor — offline pattern scanner (for DECRYPTED dumps).

Use on dumped.exe from the sebastian decryptor workflow, NOT on the stock
RobloxPlayerBeta.exe (its .text is Hyperion-encrypted on disk).
For live processes use live_scanner.py instead.

Usage:
    pip install pefile capstone
    python scanner.py <dumped.exe> [patterns.json]
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


class Image:
    def __init__(self, path):
        self.pe = pefile.PE(path, fast_load=False)
        self.secs = {}
        for s in self.pe.sections:
            name = s.Name.decode(errors="ignore").strip("\x00")
            self.secs[name] = s

    def raw(self, sec):
        return self.secs[sec].get_data()

    def rva_of(self, sec, file_off):
        s = self.secs[sec]
        return s.VirtualAddress + (file_off - s.PointerToRawData)

    def scan_section(self, sec, pat, mask):
        return [self.rva_of(sec, o) for o in aob_scan(self.raw(sec), pat, mask)]

    def find_string(self, text, sections=(".rdata", ".data", ".text")):
        needle = text.encode("ascii") + b"\x00"
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
                hits.append((sec, self.rva_of(sec, i)))
                start = i + 1
        return hits

    def find_lea_xrefs(self, target_rva, secs=(".text",)):
        out = []
        for sec in secs:
            if sec not in self.secs:
                continue
            buf = self.raw(sec)
            base = self.secs[sec].VirtualAddress
            s = 0
            needle = b"\x8d"
            while True:
                i = buf.find(needle, s)
                if i < 0 or i + 7 > len(buf):
                    break
                prev = buf[i - 1] if i > 0 else 0
                if 0x40 <= prev <= 0x4F and (buf[i + 1] & 0xC7) == 0x05:
                    disp = struct.unpack("<i", buf[i + 2:i + 6])[0]
                    if base + i - 1 + 7 + disp == target_rva:
                        out.append(base + i - 1)
                elif (buf[i + 1] & 0xC7) == 0x05:
                    disp = struct.unpack("<i", buf[i + 2:i + 6])[0]
                    if base + i + 6 + disp == target_rva:
                        out.append(base + i)
                s = i + 1
        return out

    def imul_const(self, const):
        # register-form only (mod==0b11); memory forms false-positive
        imm = struct.pack("<I", const)
        out = []
        for sec, s in self.secs.items():
            if not (s.Characteristics & 0x20000000):  # IMAGE_SCN_MEM_EXECUTE
                continue
            buf = s.get_data()
            base = s.VirtualAddress
            st = 0
            while True:
                i = buf.find(b"\x69", st)
                if i < 0 or i + 6 > len(buf):
                    break
                if (buf[i + 1] & 0xC0) == 0xC0 and buf[i + 2:i + 6] == imm:
                    out.append(base + i)
                st = i + 1
        return out

    @staticmethod
    def func_start(buf, base, rva, limit=0x5000):
        off = rva - base
        start = max(0, off - limit)
        i = off
        while i > start and buf[i - 1] in (0xCC, 0x00, 0x90):
            i -= 1
        return base + i


def main():
    if len(sys.argv) < 2:
        sys.exit("usage: scanner.py <dumped.exe> [patterns.json]")
    exe = sys.argv[1]
    patfile = sys.argv[2] if len(sys.argv) > 2 else "patterns.json"
    with open(patfile, encoding="utf-8") as f:
        db = json.load(f)

    img = Image(exe)
    print("[*] {}  sections: {}".format(exe, len(img.secs)))

    for entry in db["patterns"]:
        name, kind = entry["name"], entry["type"]
        print("\n=== {} [{}] ({}) ===".format(name, kind, entry.get("status", "?")))
        if kind == "code_pattern":
            pat, mask = parse_pattern(entry["pattern"])
            total = []
            for sec in entry.get("sections", [".text"]):
                if sec not in img.secs:
                    continue
                total += img.scan_section(sec, pat, mask)
            print("  {} hit(s)".format(len(total)))
            for h in total[:entry.get("show", 5)]:
                print("    {} = REBASE(0x{:X});".format(name, h))
        elif kind == "string_ref":
            strs = img.find_string(entry["string"])
            print("  string {!r}: {} hit(s)".format(entry["string"], len(strs)))
            buf = img.raw(".text") if ".text" in img.secs else b""
            tbase = img.secs[".text"].VirtualAddress if ".text" in img.secs else 0
            for sec, rva in strs[:5]:
                print("    @{}+0x{:X}".format(sec, rva))
                for x in img.find_lea_xrefs(rva)[:entry.get("show", 10)]:
                    print("      xref @ 0x{:X} -> func 0x{:X}".format(
                        x, Image.func_start(buf, tbase, x)))
        elif kind == "imul_const":
            hits = img.imul_const(entry["const"])
            print("  imul *,*,0x{:X}: {} hit(s)".format(entry["const"], len(hits)))
            for h in hits[:entry.get("show", 20)]:
                print("    @ 0x{:X}".format(h))


if __name__ == "__main__":
    main()
