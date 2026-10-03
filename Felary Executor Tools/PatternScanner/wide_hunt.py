#!/usr/bin/env python3
"""Wide back-pointer hunt: any T decodes, any G-field, any mainthread offset.
Covers client layout drift. Run: python wide_hunt.py <pid>."""
import struct
import sys

sys.path.insert(0, ".")
exec(open("live_scanner.py").read().split("def main")[0])
from xor_hunt import find_sc, rd64  # noqa

HEAP_LO, HEAP_HI = 0x20000000000, 0x2A000000000


def rdmem(img, a, n):
    d = read_mem(img.handle, a, n)
    return d if d and len(d) == n else None


def main():
    img = LiveImage(int(sys.argv[1]) if len(sys.argv) > 1 else 22196)
    sc = find_sc(img)
    print("SC:", hex(sc))
    m = (1 << 64) - 1
    targets = {}
    for off in range(0x0, 0xC00, 8):
        addr = sc + off
        s = rd64(img, addr)
        for name, v in (("plain", s), ("sub", (s - addr) & m),
                        ("rsub", (addr - s) & m), ("xor", s ^ addr),
                        ("add", (s + addr) & m)):
            if HEAP_LO <= v < HEAP_HI and rdmem(img, v, 8):
                targets.setdefault(v, []).append((off, name))
    print(len(targets), "targets")
    for t, srcs in targets.items():
        tb = rdmem(img, t, 0x200)
        if not tb:
            continue
        for goff in range(0, 0x200, 8):
            g = struct.unpack("<Q", tb[goff:goff + 8])[0]
            if not (HEAP_LO <= g < HEAP_HI):
                continue
            gb = rdmem(img, g, 0x200)
            if not gb:
                continue
            for moff in range(0, 0x200, 8):
                if struct.unpack("<Q", gb[moff:moff + 8])[0] == t:
                    print("HIT T=0x%X G=0x%X (T+0x%X G+0x%X) srcs=%s" %
                          (t, g, goff, moff, srcs[:4]))
                    break
            else:
                continue
            break


if __name__ == "__main__":
    main()
