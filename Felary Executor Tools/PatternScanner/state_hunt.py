#!/usr/bin/env python3
"""Find lua_State by mainthread back-pointer: for each heap qword G inside a
candidate target T, check G+{0x50,0x58,0x60} == T (RbxStu: global->mainthread).
Covers plain and self-XOR stored states. Run: python state_hunt.py <pid>."""
import struct
import sys

sys.path.insert(0, ".")
exec(open("live_scanner.py").read().split("def main")[0])
from xor_hunt import find_sc, rd64  # noqa

HEAP_LO, HEAP_HI = 0x20000000000, 0x2A000000000


def main():
    img = LiveImage(int(sys.argv[1]) if len(sys.argv) > 1 else 22196)
    sc = find_sc(img)
    print("SC:", hex(sc))
    # collect candidate targets: all 5 decodes, offsets 0..0xC00
    m = (1 << 64) - 1
    targets = {}
    for off in range(0x0, 0xC00, 8):
        addr = sc + off
        s = rd64(img, addr)
        for name, v in (("plain", s), ("sub", (s - addr) & m),
                        ("rsub", (addr - s) & m), ("xor", s ^ addr),
                        ("add", (s + addr) & m)):
            if HEAP_LO <= v < HEAP_HI and read_mem(img.handle, v, 8):
                targets.setdefault(v, []).append((off, name))
    print(len(targets), "readable heap decodes")
    for t, srcs in targets.items():
        # scan T's qwords for a G with back-pointer to T
        for goff in range(0, 0x200, 8):
            g = rd64(img, t + goff)
            if not (HEAP_LO <= g < HEAP_HI):
                continue
            for moff in (0x50, 0x58, 0x60, 0x48, 0x40):
                if rd64(img, g + moff) == t:
                    print("HIT T=0x%X via G=0x%X (T+0x%X, G+0x%X) srcs=%s" %
                          (t, g, goff, moff, srcs[:4]))
                    goff = 0x1000  # break outer
                    break
            if goff == 0x1000:
                break


if __name__ == "__main__":
    main()
