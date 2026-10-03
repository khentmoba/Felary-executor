#!/usr/bin/env python3
"""Hunt the ScriptContext -> lua_State pointer via VMValue decode formulas.

Background: the state pointer is stored obfuscated in ScriptContext/ExtraSpace
(xgladius: `state = stored ^ addr` in their era). YuB-X's Encryptions.hpp shows
the five VMValue forms. This tool tries ALL of them at every offset and keeps
candidates that decode to stable, readable heap pointers with lua_State shape.

Usage: python xor_hunt.py <pid>   (ScriptContext auto-found via child walk)
"""
import struct
import sys
import time

sys.path.insert(0, ".")
exec(open("live_scanner.py").read().split("def main")[0])

HEAP_LO, HEAP_HI = 0x20000000000, 0x2A000000000


def rd64(img, a):
    d = read_mem(img.handle, a, 8)
    return struct.unpack("<Q", d)[0] if d and len(d) == 8 else 0


def find_sc(img):
    def rd32(a):
        d = read_mem(img.handle, a, 4)
        return struct.unpack("<I", d)[0] if d and len(d) == 4 else 0

    def rstr(addr):
        if not addr:
            return ""
        ln = rd32(addr + 0x18)
        if 16 <= ln < 200:
            addr = rd64(img, addr)
        if not addr:
            return ""
        d = read_mem(img.handle, addr, 32)
        return d.split(b"\x00")[0].decode(errors="replace") if d else ""

    fdm = rd64(img, img.base + 0x8B54980)
    dm = rd64(img, fdm + 0x1F8) if fdm else 0
    if not dm:
        return 0
    vec = rd64(img, dm + 0x78)
    begin, end = rd64(img, vec), rd64(img, vec + 8)
    n = (end - begin) // 16
    for i in range(min(n, 20000)):
        child = rd64(img, begin + i * 16)
        if not child:
            continue
        cd = rd64(img, child + 0x18)
        if cd and rstr(rd64(img, cd + 8)) == "ScriptContext":
            return child
    return 0


def decode(form, stored, addr):
    m = (1 << 64) - 1
    if form == "plain":
        return stored
    if form == "sub_self":  # VMValue1: stored = value + this
        return (stored - addr) & m
    if form == "self_sub":  # VMValue2: value = this - stored
        return (addr - stored) & m
    if form == "xor":  # VMValue3
        return stored ^ addr
    if form == "add":  # VMValue4: stored = value - this
        return (stored + addr) & m
    raise ValueError(form)


def plausible_state(img, t):
    """lua_State shape (vendored layout; client may drift slightly)."""
    if not (HEAP_LO <= t < HEAP_HI):
        return None
    g = rd64(img, t + 0x20)  # global
    stack = rd64(img, t + 0x48)
    top = rd64(img, t + 0x38)
    if not (HEAP_LO <= g < HEAP_HI):
        return None
    if not (HEAP_LO <= stack < HEAP_HI):
        return None
    if not (HEAP_LO <= top < HEAP_HI):
        return None
    if top < stack or top - stack > 0x100000:
        return None
    # global_State is huge (0x4500+); its tail must be committed
    tail = read_mem(img.handle, g + 0x4400, 8)
    if tail is None:
        return None
    tt = read_mem(img.handle, t, 1)
    score = 0
    if tt == b"\x08":  # LUA_TTHREAD (if tag is plaintext)
        score += 10
    mt = rd64(img, g + 0x58)  # global->mainthread
    if mt == t:
        score += 10
    return score


def main():
    pid = int(sys.argv[1]) if len(sys.argv) > 1 else None
    if pid is None:
        from live_scanner import find_pid  # noqa
        pid = find_pid("RobloxPlayerBeta.exe")
    img = LiveImage(pid)
    sc = find_sc(img)
    print("SC:", hex(sc) if sc else None)
    if not sc:
        return
    forms = ["plain", "sub_self", "self_sub", "xor", "add"]
    snap1 = {}
    for off in range(0x0, 0xA00, 8):
        addr = sc + off
        stored = rd64(img, addr)
        for f in forms:
            snap1[(off, f)] = decode(f, stored, addr)
    print("snapshot 1 done, waiting 30s for stability check (keep playing)...")
    time.sleep(30)
    survivors = []
    for (off, f), v1 in snap1.items():
        addr = sc + off
        v2 = decode(f, rd64(img, addr), addr)
        if v1 != v2 or v1 == 0:
            continue
        score = plausible_state(img, v1)
        if score is not None:
            survivors.append((score, off, f, v1))
    survivors.sort(reverse=True)
    print("%d survivors:" % len(survivors))
    for score, off, f, v in survivors[:20]:
        print("  score=%d off=0x%X form=%-9s -> 0x%X" % (score, off, f, v))


if __name__ == "__main__":
    main()
