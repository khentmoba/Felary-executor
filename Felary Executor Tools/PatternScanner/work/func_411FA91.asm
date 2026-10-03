func 0x411FA91 (pid 22196, base 0x7FF684EB0000)
  0411FA91: nop 
  0411FA92: lea rcx, [rbx + 0x7f8]
  0411FA99: lea r9, [rip - 0x3931060]
  0411FAA0: mov edx, 0x10
  0411FAA5: lea r8d, [rdx - 5]
  0411FAA9: call 0x7ff68aa27290
  0411FAAE: nop 
  0411FAAF: lea rcx, [rbx + 0x7f0]
  0411FAB6: call 0x7ff684eb7c60
  0411FABB: mov rcx, qword ptr [rbx + 0x7e0]
  0411FAC2: test rcx, rcx
  0411FAC5: je 0x7ff688fcfacc
  0411FAC7: call 0x7ff68569d6f0
  0411FACC: lea rcx, [rbx + 0x7d0]
  0411FAD3: call 0x7ff6856b7870
  0411FAD8: lea rcx, [rbx + 0x7c8]
  0411FADF: call 0x7ff6856b7870
  0411FAE4: lea rcx, [rbx + 0x7a8]
  0411FAEB: call 0x7ff6856ba110
  0411FAF0: lea rcx, [rbx + 0x788]
  0411FAF7: call 0x7ff6856b7870
  0411FAFC: lea rdi, [rbx + 0x740]
  0411FB03: mov rcx, qword ptr [rdi + 0x38]
  0411FB07: test rcx, rcx
  0411FB0A: je 0x7ff688fcfb23
  0411FB0C: mov rax, qword ptr [rcx]
  0411FB0F: cmp rcx, rdi
  0411FB12: setne dl
  0411FB15: mov rax, qword ptr [rax + 0x20]
  0411FB19: call qword ptr [rip + 0x206d219]
  0411FB1F: mov qword ptr [rdi + 0x38], rbp
  0411FB23: lea rdi, [rbx + 0x700]
  0411FB2A: mov rcx, qword ptr [rdi + 0x38]
  0411FB2E: test rcx, rcx
  0411FB31: je 0x7ff688fcfb4a
  0411FB33: mov rax, qword ptr [rcx]
  0411FB36: cmp rcx, rdi
  0411FB39: setne dl
  0411FB3C: mov rax, qword ptr [rax + 0x20]
  0411FB40: call qword ptr [rip + 0x206d1f2]
  0411FB46: mov qword ptr [rdi + 0x38], rbp
  0411FB4A: lea rcx, [rbx + 0x6f8]
  0411FB51: call 0x7ff6856b7870
  0411FB56: lea rcx, [rbx + 0x6f0]
  0411FB5D: call 0x7ff6856b7870
  0411FB62: lea rcx, [rbx + 0x6e8]
  0411FB69: call 0x7ff6856b7870
  0411FB6E: lea rcx, [rbx + 0x6e0]
  0411FB75: call 0x7ff6856b7870
  0411FB7A: mov rcx, qword ptr [rbx + 0x6c8]
  0411FB81: test rcx, rcx
  0411FB84: je 0x7ff688fcfbbd
  0411FB86: mov rdi, qword ptr [rbx + 0x6b8]
  0411FB8D: mov rdx, qword ptr [rbx + 0x6c0]
  0411FB94: nop dword ptr [rax]
  0411FB98: nop dword ptr [rax + rax]
  0411FBA0: lea rax, [rdx + 1]
  0411FBA4: xor edx, edx
  0411FBA6: div rdi
  0411FBA9: sub rcx, 1
  0411FBAD: jne 0x7ff688fcfba0
  0411FBAF: mov qword ptr [rbx + 0x6c8], rcx
  0411FBB6: mov qword ptr [rbx + 0x6c0], rdx
  0411FBBD: mov rcx, qword ptr [rbx + 0x6b0]
  0411FBC4: test rcx, rcx
  0411FBC7: je 0x7ff688fcfbcf
  0411FBC9: call 0x7ff689838ee0
  0411FBCE: nop 
  0411FBCF: lea rcx, [rbx + 0x698]
  0411FBD6: call 0x7ff6856b7040
  0411FBDB: mov rdi, qword ptr [rbx + 0x688]
  0411FBE2: test rdi, rdi
  0411FBE5: je 0x7ff688fcfbf9
  0411FBE7: mov rcx, rdi
  0411FBEA: call 0x7ff688fe2030
  0411FBEF: nop 
  0411FBF0: mov rcx, rdi
  0411FBF3: call 0x7ff689838ee0
  0411FBF8: nop 
  0411FBF9: lea rcx, [rbx + 0x670]
  0411FC00: call 0x7ff685fc3040
  0411FC05: lea rcx, [rbx + 0x650]
  0411FC0C: call 0x7ff6856b8cd0
  0411FC11: nop 
  0411FC12: mov rcx, qword ptr [rbx + 0x610]
  0411FC19: call 0x7ff689838ee0
  0411FC1E: nop 
  0411FC1F: mov rcx, qword ptr [rbx + 0x600]
  0411FC26: test rcx, rcx
  0411FC29: je 0x7ff688fcfc39
  0411FC2B: mov rax, qword ptr [rbx + 0x5f8]
  0411FC32: call qword ptr [rip + 0x206d100]
  0411FC38: nop 
  0411FC39: lea rcx, [rbx + 0x5b8]
  0411FC40: call 0x7ff6856b5bd0
  0411FC45: lea rcx, [rbx + 0x5b0]
  0411FC4C: call 0x7ff684eb7c60
  0411FC51: lea rcx, [rbx + 0x590]
  0411FC58: call 0x7ff6856ba110
  0411FC5D: mov rcx, qword ptr [rbx + 0x548]
  0411FC64: test rcx, rcx
  0411FC67: je 0x7ff688fcfc7a
  0411FC69: mov rax, qword ptr [rcx]
  0411FC6C: mov edx, 1
  0411FC71: mov rax, qword ptr [rax]
  0411FC74: call qword ptr [rip + 0x206d0be]
  0411FC7A: mov rcx, qword ptr [rbx + 0x4f0]
  0411FC81: test rcx, rcx
  0411FC84: je 0x7ff688fcfc8b
  0411FC86: call 0x7ff68569d6f0
  0411FC8B: lea rcx, [rbx + 0x4e0]
  0411FC92: call 0x7ff6856b7870
  0411FC97: lea rcx, [rbx + 0x4d8]
  0411FC9E: call 0x7ff6856b7870
  0411FCA3: lea rcx, [rbx + 0x4d0]
  0411FCAA: call 0x7ff6856b7870
  0411FCAF: lea rcx, [rbx + 0x4c8]
  0411FCB6: call 0x7ff6856b7870
  0411FCBB: lea rcx, [rbx + 0x4c0]
  0411FCC2: call 0x7ff6856b7870
  0411FCC7: lea rcx, [rbx + 0x4b8]
  0411FCCE: call 0x7ff6856b7870
  0411FCD3: lea rcx, [rbx + 0x4b0]
  0411FCDA: call 0x7ff6856b7870
  0411FCDF: lea rcx, [rbx + 0x4a8]
  0411FCE6: call 0x7ff6856b7870
  0411FCEB: lea rcx, [rbx + 0x4a0]
  0411FCF2: call 0x7ff6856b7870
  0411FCF7: lea rcx, [rbx + 0x498]
  0411FCFE: call 0x7ff6856b7870
  0411FD03: lea rcx, [rbx + 0x490]
  0411FD0A: call 0x7ff6856b7870
  0411FD0F: lea rcx, [rbx + 0x488]
  0411FD16: call 0x7ff6856b7870
  0411FD1B: lea rcx, [rbx + 0x460]
  0411FD22: call 0x7ff6856b7110
  0411FD27: lea rcx, [rbx + 0x450]
  0411FD2E: call 0x7ff688fd0b90
  0411FD33: lea rcx, [rbx + 0x440]
  0411FD3A: call 0x7ff684eb7c60
  0411FD3F: lea rcx, [rbx + 0x438]
  0411FD46: call 0x7ff6856b7870
  0411FD4B: lea rcx, [rbx + 0x430]
  0411FD52: call 0x7ff6856b7870
  0411FD57: lea rcx, [rbx + 0x428]
  0411FD5E: call 0x7ff6856b7870
  0411FD63: lea rcx, [rbx + 0x420]
  0411FD6A: call 0x7ff6856b7870
  0411FD6F: lea rcx, [rbx + 0x418]
  0411FD76: call 0x7ff6856b7870
  0411FD7B: lea rcx, [rbx + 0x410]
  0411FD82: call 0x7ff6856b7870
  0411FD87: lea rcx, [rbx + 0x408]
  0411FD8E: call 0x7ff6856b7870
  0411FD93: lea rcx, [rbx + 0x400]
  0411FD9A: call 0x7ff6856b7870
  0411FD9F: lea rcx, [rbx + 0x3f8]
  0411FDA6: call 0x7ff6856b7870
  0411FDAB: lea rcx, [rbx + 0x3f0]
  0411FDB2: call 0x7ff6856b7870
  0411FDB7: lea rcx, [rbx + 0x3e8]
  0411FDBE: call 0x7ff6856b7870
  0411FDC3: lea rcx, [rbx + 0x3e0]
  0411FDCA: call 0x7ff6856b7870
  0411FDCF: lea rcx, [rbx + 0x3d8]
  0411FDD6: call 0x7ff6856b7870
  0411FDDB: lea rcx, [rbx + 0x3d0]
  0411FDE2: call 0x7ff6856b7870
  0411FDE7: lea rcx, [rbx + 0x3c8]
  0411FDEE: call 0x7ff6856b7870
  0411FDF3: lea rcx, [rbx + 0x3c0]
  0411FDFA: call 0x7ff6856b7870
  0411FDFF: lea rcx, [rbx + 0x3b8]
  0411FE06: call 0x7ff6856b7870
  0411FE0B: lea rcx, [rbx + 0x3b0]
  0411FE12: call 0x7ff6856b7870
  0411FE17: lea rcx, [rbx + 0x3a8]
  0411FE1E: call 0x7ff688fd0a80
  0411FE23: lea rcx, [rbx + 0x2d8]
  0411FE2A: call 0x7ff688fd74f0
  0411FE2F: lea rcx, [rbx + 0x1f0]
  0411FE36: call 0x7ff6877806e0
  0411FE3B: lea rax, [rip + 0x2bd765e]
  0411FE42: mov qword ptr [rbx + 8], rax
  0411FE46: mov rcx, qword ptr [rbx + 0x28]
  0411FE4A: call 0x7ff689839050
  0411FE4F: nop 
  0411FE50: lea rcx, [rbx + 0x10]
  0411FE54: call 0x7ff684eb7c60
  0411FE59: lock dec dword ptr [rip + 0x49f2090]
  0411FE60: mov rbx, qword ptr [rsp + 0x48]
  0411FE65: mov rbp, qword ptr [rsp + 0x50]
  0411FE6A: mov rsi, qword ptr [rsp + 0x58]
  0411FE6F: add rsp, 0x20
  0411FE73: pop r15
  0411FE75: pop r14
  0411FE77: pop rdi
  0411FE78: ret 
