#!/usr/bin/env python3
"""Dump a live function body to work/func_<rva>.asm for study.
Usage: python disasm_rva.py <pid> <rva_hex> [max_insns]
Walks back over padding to the nearest plausible start, disassembles forward
until `ret` run / int3 padding / cap. CALL TARGETS ARE VALIDATED: targets
outside the exe image are flagged (ciphertext warning).
"""
import sys

sys.path.insert(0, ".")
exec(open("live_scanner.py").read().split("def main")[0])
from capstone import Cs, CS_ARCH_X86, CS_MODE_64

pid = int(sys.argv[1])
rva = int(sys.argv[2], 16)
cap = int(sys.argv[3]) if len(sys.argv) > 3 else 600

img = LiveImage(pid)
md = Cs(CS_ARCH_X86, CS_MODE_64)
size = img.size
base = img.base

cur = base + rva
for _ in range(400):
    d = read_mem(img.handle, cur - 64, 64)
    if not d:
        break
    j = 63
    while j >= 0 and d[j] in (0xCC, 0x00, 0x90):
        j -= 1
    if j == 63:
        break
    cur -= (63 - j)
    if cur <= base + rva - 0x3000:
        break
f = cur - base

out = []
# page-wise reads: one uncommitted page must not kill the whole body
d = b""
need = cap * 16
chunk = 0x1000
addr = base + f
while len(d) < need:
    part = read_mem(img.handle, addr + len(d), min(chunk, need - len(d)))
    if not part:
        break
    d += part
n = 0
for ins in md.disasm(d, base + f):
    line = "  {:08X}: {} {}".format(ins.address - base, ins.mnemonic, ins.op_str)
    if ins.mnemonic == "call" and ins.op_str.startswith("0x"):
        t = int(ins.op_str, 16) - base
        if not (0 <= t < size):
            line += "   <-- OUT OF IMAGE (cold/encrypted?)"
    elif ins.mnemonic == "ret":
        out.append(line)
        n += 1
        break
    out.append(line)
    n += 1
    if n >= cap:
        break

path = "work/func_%X.asm" % rva
open(path, "w").write("func 0x%X (pid %d, base 0x%X)\n" % (f, pid, base) + "\n".join(out) + "\n")
print("wrote %s (%d insns)" % (path, n))
