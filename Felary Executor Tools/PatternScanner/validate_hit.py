#!/usr/bin/env python3
"""Validate the state_hunt HIT: dump T and G structs."""
import struct
import sys

sys.path.insert(0, ".")
exec(open("live_scanner.py").read().split("def main")[0])


def rd64(img, a):
    d = read_mem(img.handle, a, 8)
    return struct.unpack("<Q", d)[0] if d and len(d) == 8 else 0


img = LiveImage(int(sys.argv[1]) if len(sys.argv) > 1 else 22196)
SC = 0x28856DE6080
T, G = 0x28860961200, 0x288697E2280
print("SC+0xAC0 still:", hex(rd64(img, SC + 0xAC0)))
print("--- T qwords ---")
for i in range(16):
    v = rd64(img, T + i * 8)
    tag = "HEAP" if 0x20000000000 <= v < 0x2A000000000 else ""
    print("  T+0x%X = 0x%X %s" % (i * 8, v, tag))
print("--- G size probe ---")
for off in [0x58, 0x500, 0x1000, 0x2000, 0x4000, 0x4500, 0x5000]:
    print("  G+0x%X readable:" % off, read_mem(img.handle, G + off, 8) is not None)
