#!/usr/bin/env python3
"""List all stable plain heap pointers in ScriptContext + validate shape loosely."""
import struct
import sys

sys.path.insert(0, ".")
exec(open("live_scanner.py").read().split("def main")[0])
from xor_hunt import find_sc, rd64  # noqa

img = LiveImage(int(sys.argv[1]) if len(sys.argv) > 1 else 22196)
sc = find_sc(img)
print("SC:", hex(sc))

cands = {}
for off in range(0x0, 0xC00, 8):
    v = rd64(img, sc + off)
    if 0x20000000000 <= v < 0x2A000000000 and read_mem(img.handle, v, 8):
        cands.setdefault(v, []).append(off)
print(len(cands), "distinct plain heap targets")
for v, offs in sorted(cands.items(), key=lambda kv: len(kv[1]), reverse=True)[:25]:
    qs = [rd64(img, v + i * 8) for i in range(12)]
    heap = sum(1 for q in qs if 0x20000000000 <= q < 0x2A000000000)
    print("offsets", [hex(o) for o in offs[:6]], "->", hex(v), "heapq=%d/12" % heap)
