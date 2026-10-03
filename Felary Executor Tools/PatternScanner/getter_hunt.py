#!/usr/bin/env python3
"""Score functions reading [reg+0xAC0] for getter shape (small, returns load)."""
import struct
import sys

sys.path.insert(0, ".")
exec(open("live_scanner.py").read().split("def main")[0])
from capstone import Cs, CS_ARCH_X86, CS_MODE_64

img = LiveImage(int(sys.argv[1]) if len(sys.argv) > 1 else 22196)
md = Cs(CS_ARCH_X86, CS_MODE_64)

sites = []
for base, size in img.regions():
    off = 0
    while off < size:
        chunk = min(size - off, 32 * 1024 * 1024)
        data = read_mem(img.handle, base + off, chunk)
        if data is None:
            break
        s = 0
        while True:
            i = data.find(bytes([0xC0, 0x0A, 0x00, 0x00]), s)
            if i < 0 or i + 4 > len(data):
                break
            if i >= 3 and data[i - 3] in (0x48, 0x4C) and data[i - 2] == 0x8B \
                    and (data[i - 1] & 0xC0) == 0x80:
                sites.append(base + off + i - 3 - img.base)
            s = i + 1
        off += chunk
print(len(sites), "sites")


def func_start(rva):
    cur = img.base + rva
    for _ in range(60):
        d = read_mem(img.handle, cur - 16, 16)
        if not d:
            break
        j = 15
        while j >= 0 and d[j] in (0xCC, 0x00, 0x90):
            j -= 1
        if j == 15:
            break
        cur -= (15 - j)
    return cur - img.base


for site in sites:
    f = func_start(site)
    d = read_mem(img.handle, img.base + f, 160)
    if not d:
        continue
    insns = list(md.disasm(d, img.base + f))[:25]
    # getter shape: first insn is our mov, function returns soon, few calls
    first_ok = insns and insns[0].address - img.base == site
    calls = sum(1 for i in insns if i.mnemonic == "call")
    length = insns[-1].address - img.base - f if insns else 999
    ret = any(i.mnemonic == "ret" for i in insns[:12])
    if first_ok and calls == 0 and ret and length < 0x60:
        print("GETTER-LIKE func=0x%X site=0x%X len=0x%X" % (f, site, length))
        for i in insns[:12]:
            print("    {:08X}: {} {}".format(i.address - img.base, i.mnemonic, i.op_str))
