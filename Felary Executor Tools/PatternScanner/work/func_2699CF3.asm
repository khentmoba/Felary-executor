func 0x2699CF3 (pid 22196, base 0x7FF684EB0000)
  02699CF3: mov qword ptr [rsp + 0x60], rbx
  02699CF8: movups xmmword ptr [rbx], xmm0
  02699CFB: movups xmm0, xmmword ptr [rcx]
  02699CFE: movups xmmword ptr [rdi], xmm0
  02699D01: mov qword ptr [r12 + 0x70], rax
  02699D06: mov rax, qword ptr [r12 + 0x58]
  02699D0B: mov qword ptr [rax + 0x20], r15
  02699D0F: mov eax, 0xc8
  02699D14: inc word ptr [r12 + 0x38]
  02699D1A: cmp word ptr [r12 + 0x38], ax
  02699D20: jb 0x7ff687549d2a
  02699D22: mov rcx, r12
  02699D25: call 0x7ff687502140
  02699D2A: mov r8, qword ptr [r12 + 0x58]
  02699D2F: lea r15, [r12 + 0x58]
  02699D34: mov rdx, qword ptr [r12 + 0x50]
  02699D39: mov byte ptr [rbp + 0x668], 0
  02699D40: cmp r8, rdx
  02699D43: je 0x7ff687549d68
  02699D45: mov rax, qword ptr [r8 + 8]
  02699D49: mov rcx, qword ptr [rax]
  02699D4C: cmp byte ptr [rcx + 6], 0
  02699D50: je 0x7ff687549d68
  02699D52: add rcx, 0x20
  02699D56: cmp qword ptr [rcx], rcx
  02699D59: je 0x7ff687549d68
  02699D5B: inc word ptr [r12 + 0x3a]
  02699D61: mov byte ptr [rbp + 0x668], 1
  02699D68: sub r8, rdx
  02699D6B: mov rax, rdi
  02699D6E: sub rax, qword ptr [r12 + 0x78]
  02699D73: cmp dword ptr [rdi + 0xc], 8
  02699D77: mov qword ptr [rsp + 0x78], rax
  02699D7C: mov qword ptr [rbp - 0x70], r8
  02699D80: je 0x7ff687549d8d
  02699D82: mov rdx, rdi
  02699D85: mov rcx, r12
  02699D88: call 0x7ff687512950
  02699D8D: mov rax, qword ptr [r15]
  02699D90: mov rsi, qword ptr [rdi]
  02699D93: mov qword ptr [rbp - 0x68], rsi
  02699D97: cmp rax, qword ptr [r12 + 0x48]
  02699D9C: jne 0x7ff68754a00b
  02699DA2: movsxd rax, dword ptr [r12 + 0x1c]
  02699DA7: cmp eax, 0x57e4
  02699DAC: jge 0x7ff68754dad9
  02699DB2: lea ecx, [rax + rax]
  02699DB5: cmp eax, 0x4e20
  02699DBA: jl 0x7ff687549dc3
  02699DBC: mov edx, 0x57e4
  02699DC1: jmp 0x7ff687549dcd
  02699DC3: mov edx, 0x4e20
  02699DC8: cmp ecx, edx
  02699DCA: cmovl edx, ecx
  02699DCD: movzx ecx, byte ptr [r12]
  02699DD2: mov r13, qword ptr [r12 + 0x50]
  02699DD7: mov byte ptr [rbp + 0x670], cl
  02699DDD: movabs rcx, 0x555555555555555
  02699DE7: movsxd r15, edx
  02699DEA: mov dword ptr [rsp + 0x58], edx
  02699DEE: cmp r15, rcx
  02699DF1: ja 0x7ff68754daee
  02699DF7: mov rdi, qword ptr [r12 + 0x68]
  02699DFC: lea rsi, [rax + rax*2]
  02699E00: lea rbx, [r15 + r15*2]
  02699E04: mov qword ptr [rsp + 0x70], rax
  02699E09: shl rbx, 4
  02699E0D: lea rcx, [rip - 0x2699e14]
  02699E14: shl rsi, 4
  02699E18: mov rdx, 0xffffffffffffffff
  02699E1F: lea rax, [rbx - 1]
  02699E23: cmp rax, 0x400
  02699E29: jae 0x7ff687549e36
  02699E2B: movsx r14d, byte ptr [rbx + rcx + 0x7da8c10]
  02699E34: jmp 0x7ff687549e39
  02699E36: mov r14d, edx
  02699E39: lea rax, [rsi - 1]
  02699E3D: cmp rax, 0x400
  02699E43: jae 0x7ff687549e50
  02699E45: movsx r12d, byte ptr [rsi + rcx + 0x7da8c10]
  02699E4E: jmp 0x7ff687549e53
  02699E50: mov r12d, edx
  02699E53: mov rax, qword ptr [rdi + 0x680]
  02699E5A: test rax, rax
  02699E5D: je 0x7ff687549e74
  02699E5F: test r13, r13
  02699E62: je 0x7ff687549e74
  02699E64: mov rcx, qword ptr [rbp + 0x660]
  02699E6B: mov rdx, r13
  02699E6E: call qword ptr [rip + 0x3af2ec4]
  02699E74: test r14d, r14d
  02699E77: jns 0x7ff687549ebc
  02699E79: mov rcx, qword ptr [rdi + 0x30]
  02699E7D: mov r9, rbx
  02699E80: mov rax, qword ptr [rdi + 0x28]
  02699E84: test r12d, r12d
  02699E87: jns 0x7ff687549eaf
  02699E89: mov r8, rsi
  02699E8C: mov rdx, r13
  02699E8F: call qword ptr [rip + 0x3af2ea3]
  02699E95: mov r14, rax
  02699E98: test rax, rax
  02699E9B: jne 0x7ff687549f35
  02699EA1: test rbx, rbx
  02699EA4: jne 0x7ff68754d588
  02699EAA: jmp 0x7ff687549f35
  02699EAF: xor r8d, r8d
  02699EB2: xor edx, edx
  02699EB4: call qword ptr [rip + 0x3af2e7e]
  02699EBA: jmp 0x7ff687549ecb
  02699EBC: mov rcx, qword ptr [rbp + 0x660]
  02699EC3: mov edx, r14d
  02699EC6: call 0x7ff687530640
  02699ECB: mov r14, rax
  02699ECE: test rax, rax
  02699ED1: jne 0x7ff687549edc
  02699ED3: test rbx, rbx
  02699ED6: jne 0x7ff68754d588
  02699EDC: test rsi, rsi
  02699EDF: je 0x7ff687549f02
  02699EE1: test rbx, rbx
  02699EE4: je 0x7ff687549f02
  02699EE6: cmp rsi, rbx
  02699EE9: mov rdx, r13
  02699EEC: mov rcx, r14
  02699EEF: cmovb r15, qword ptr [rsp + 0x70]
  02699EF5: lea r8, [r15 + r15*2]
  02699EF9: shl r8, 4
  02699EFD: call 0x7ff68aa48aa0
  02699F02: test r12d, r12d
  02699F05: js 0x7ff687549f1e
  02699F07: mov edx, r12d
  02699F0A: mov r8, r13
  02699F0D: mov r12, qword ptr [rbp + 0x660]
  02699F14: mov rcx, r12
  02699F17: call 0x7ff68752ff80
  02699F1C: jmp 0x7ff687549f3c
  02699F1E: mov rcx, qword ptr [rdi + 0x30]
  02699F22: xor r9d, r9d
  02699F25: mov rax, qword ptr [rdi + 0x28]
  02699F29: mov r8, rsi
  02699F2C: mov rdx, r13
  02699F2F: call qword ptr [rip + 0x3af2e03]
  02699F35: mov r12, qword ptr [rbp + 0x660]
  02699F3C: movzx edx, byte ptr [rbp + 0x670]
  02699F43: mov rax, rbx
  02699F46: sub rax, rsi
  02699F49: add qword ptr [rdi + 0x18], rax
  02699F4D: mov rax, rbx
  02699F50: sub rax, rsi
  02699F53: add qword ptr [rdi + rdx*8 + 0x2db0], rax
  02699F5B: mov rax, qword ptr [rdi + 0x698]
  02699F62: test rax, rax
  02699F65: je 0x7ff687549f8b
  02699F67: xor ecx, ecx
  02699F69: mov r9, rbx
  02699F6C: mov dword ptr [rsp + 0x30], ecx
  02699F70: mov r8, rsi
  02699F73: mov dword ptr [rsp + 0x28], 0x11
  02699F7B: mov rcx, r12
  02699F7E: mov byte ptr [rsp + 0x20], dl
  02699F82: mov rdx, r14
  02699F85: call qword ptr [rip + 0x3af2dad]
  02699F8B: movsxd r8, dword ptr [rsp + 0x58]
  02699F90: lea r15, [r12 + 0x58]
  02699F95: mov qword ptr [r12 + 0x50], r14
  02699F9A: movabs rax, 0x2aaaaaaaaaaaaaab
  02699FA4: mov dword ptr [r12 + 0x1c], r8d
  02699FA9: mov rcx, qword ptr [r15]
  02699FAC: sub rcx, r13
  02699FAF: imul rcx
  02699FB2: lea rcx, [r8 + r8*2]
  02699FB6: sar rdx, 3
  02699FBA: mov rax, rdx
  02699FBD: shl rcx, 4
  02699FC1: shr rax, 0x3f
  02699FC5: add rcx, -0x30
  02699FC9: add rdx, rax
  02699FCC: lea rdx, [rdx + rdx*2]
  02699FD0: shl rdx, 4
  02699FD4: add rdx, r14
  02699FD7: mov qword ptr [r15], rdx
  02699FDA: add rcx, qword ptr [r12 + 0x50]
  02699FDF: mov qword ptr [r12 + 0x48], rcx
  02699FE4: cmp dword ptr [r12 + 0x1c], 0x4e20
  02699FED: jg 0x7ff68754d8c0
  02699FF3: mov rbx, qword ptr [rsp + 0x60]
  02699FF8: lea rdi, [rdx + 0x30]
  02699FFC: mov rsi, qword ptr [rbp - 0x68]
  0269A000: mov r14, qword ptr [rbp - 0x78]
  0269A004: mov r13, qword ptr [rsp + 0x48]
  0269A009: jmp 0x7ff68754a00f
  0269A00B: lea rdi, [rax + 0x30]
  0269A00F: mov rax, rdi
  0269A012: mov qword ptr [rsp + 0x70], rdi
  0269A017: mov rcx, r15
  0269A01A: mov qword ptr [rcx], rax
  0269A01D: lea rax, [r14 + r13]
  0269A021: mov qword ptr [rdi + 8], rax
  0269A025: cmp byte ptr [rsi + 6], 0
  0269A029: je 0x7ff68754a033
  0269A02B: xor r13d, r13d
  0269A02E: mov eax, r13d
  0269A031: jmp 0x7ff68754a05b
  0269A033: cmp byte ptr [rip + 0x570f05e], 0
  0269A03A: je 0x7ff68754a054
  0269A03C: mov rax, qword ptr [rsi + 0x18]
  0269A040: cmp qword ptr [rax + 0xc0], 0
  0269A048: je 0x7ff68754a054
  0269A04A: mov rcx, rsi
  0269A04D: call 0x7ff6874ef8e0
  0269A052: jmp 0x7ff68754a058
  0269A054: mov rax, qword ptr [rsi + 0x18]
  0269A058: xor r13d, r13d
  0269A05B: mov qword ptr [rdi + 0x18], rax
  0269A05F: mov qword ptr [rdi], rbx
  0269A062: movzx eax, byte ptr [rsi + 5]
  0269A066: shl rax, 4
  0269A06A: add rax, qword ptr [r12 + 0x70]
  0269A06F: mov qword ptr [rdi + 0x10], rax
  0269A073: mov qword ptr [rdi + 0x20], r13
  0269A077: mov dword ptr [rdi + 0x2c], r13d
  0269A07B: mov dword ptr [rdi + 0x28], 3
  0269A082: mov qword ptr [r12 + 0x60], rbx
  0269A087: movzx edx, byte ptr [rsi + 5]
  0269A08B: mov rax, qword ptr [r12 + 0x80]
  0269A093: mov ecx, edx
  0269A095: sub rax, qword ptr [r12 + 0x70]
  0269A09A: shl ecx, 4
  0269A09D: cmp rax, rcx
  0269A0A0: jg 0x7ff68754a3dc
  0269A0A6: lea r8, [r12 + 0x18]
  0269A0AB: mov eax, r8d
  0269A0AE: xor eax, dword ptr [r8]
  0269A0B1: cmp edx, eax
  0269A0B3: jg 0x7ff68754a0c0
  0269A0B5: mov r12d, r8d
  0269A0B8: xor r12d, dword ptr [r8]
  0269A0BB: add r12d, r12d
  0269A0BE: jmp 0x7ff68754a0c9
  0269A0C0: mov r12, r8
  0269A0C3: xor r12d, dword ptr [r8]
  0269A0C6: add r12d, edx
  0269A0C9: cmp r12d, 0x4000000
  0269A0D0: jg 0x7ff68754d8e5
  0269A0D6: mov r9, qword ptr [rbp + 0x660]
  0269A0DD: lea eax, [r12 + 5]
  0269A0E2: mov dword ptr [rsp + 0x58], eax
  0269A0E6: movsxd rdi, r12d
  0269A0E9: add rdi, 5
  0269A0ED: movzx eax, byte ptr [r9]
  0269A0F1: mov rbx, qword ptr [r9 + 0x78]
  0269A0F5: mov byte ptr [rbp + 0x670], al
  0269A0FB: movabs rax, 0xfffffffffffffff
  0269A105: cmp rdi, rax
  0269A108: ja 0x7ff68754dae7
  0269A10E: movsxd rax, dword ptr [r8]
  0269A111: mov rsi, rdi
  0269A114: mov r14, qword ptr [r9 + 0x68]
  0269A118: mov rdx, 0xffffffffffffffff
  0269A11F: shl rsi, 4
  0269A123: movsxd rcx, r8d
  0269A126: xor rcx, rax
  0269A129: mov r15, rcx
  0269A12C: mov qword ptr [rsp + 0x48], rcx
  0269A131: lea rax, [rsi - 1]
  0269A135: shl r15, 4
  0269A139: lea rcx, [rip - 0x269a140]
  0269A140: cmp rax, 0x400
  0269A146: jae 0x7ff68754a153
  0269A148: movsx r13d, byte ptr [rsi + rcx + 0x7da8c10]
  0269A151: jmp 0x7ff68754a156
  0269A153: mov r13d, edx
  0269A156: lea rax, [r15 - 1]
  0269A15A: cmp rax, 0x400
  0269A160: jae 0x7ff68754a171
  0269A162: movsx ecx, byte ptr [r15 + rcx + 0x7da8c10]
  0269A16B: mov dword ptr [rsp + 0x68], ecx
  0269A16F: jmp 0x7ff68754a175
  0269A171: mov dword ptr [rsp + 0x68], edx
  0269A175: mov rax, qword ptr [r14 + 0x680]
  0269A17C: test rax, rax
  0269A17F: je 0x7ff68754a199
  0269A181: test rbx, rbx
  0269A184: je 0x7ff68754a199
  0269A186: mov rdx, rbx
  0269A189: mov rcx, r9
  0269A18C: call qword ptr [rip + 0x3af2ba6]
  0269A192: mov r9, qword ptr [rbp + 0x660]
  0269A199: test r13d, r13d
  0269A19C: jns 0x7ff68754a1e6
  0269A19E: mov r13d, dword ptr [rsp + 0x68]
  0269A1A3: mov r9, rsi
  0269A1A6: mov rcx, qword ptr [r14 + 0x30]
  0269A1AA: mov rax, qword ptr [r14 + 0x28]
  0269A1AE: test r13d, r13d
  0269A1B1: jns 0x7ff68754a1d9
  0269A1B3: mov r8, r15
  0269A1B6: mov rdx, rbx
  0269A1B9: call qword ptr [rip + 0x3af2b79]
  0269A1BF: mov r13, rax
  0269A1C2: test rax, rax
  0269A1C5: jne 0x7ff68754a263
  0269A1CB: test rsi, rsi
  0269A1CE: jne 0x7ff68754d588
  0269A1D4: jmp 0x7ff68754a263
  0269A1D9: xor r8d, r8d
  0269A1DC: xor edx, edx
  0269A1DE: call qword ptr [rip + 0x3af2b54]
  0269A1E4: jmp 0x7ff68754a1f6
  0269A1E6: mov edx, r13d
  0269A1E9: mov rcx, r9
  0269A1EC: call 0x7ff687530640
  0269A1F1: mov r13d, dword ptr [rsp + 0x68]
  0269A1F6: mov qword ptr [rsp + 0x60], rax
  0269A1FB: test rax, rax
  0269A1FE: jne 0x7ff68754a209
  0269A200: test rsi, rsi
  0269A203: jne 0x7ff68754d588
  0269A209: test r15, r15
  0269A20C: je 0x7ff68754a22e
  0269A20E: test rsi, rsi
  0269A211: je 0x7ff68754a22e
  0269A213: cmp r15, rsi
  0269A216: mov r8, rdi
  0269A219: mov rdx, rbx
  0269A21C: mov rcx, rax
  0269A21F: cmovb r8, qword ptr [rsp + 0x48]
  0269A225: shl r8, 4
  0269A229: call 0x7ff68aa48aa0
  0269A22E: test r13d, r13d
  0269A231: js 0x7ff68754a247
  0269A233: mov rcx, qword ptr [rbp + 0x660]
  0269A23A: mov r8, rbx
  0269A23D: mov edx, r13d
  0269A240: call 0x7ff68752ff80
  0269A245: jmp 0x7ff68754a25e
  0269A247: mov rcx, qword ptr [r14 + 0x30]
  0269A24B: xor r9d, r9d
  0269A24E: mov rax, qword ptr [r14 + 0x28]
  0269A252: mov r8, r15
  0269A255: mov rdx, rbx
  0269A258: call qword ptr [rip + 0x3af2ada]
  0269A25E: mov r13, qword ptr [rsp + 0x60]
  0269A263: movzx edx, byte ptr [rbp + 0x670]
  0269A26A: mov rax, rsi
  0269A26D: sub rax, r15
  0269A270: add qword ptr [r14 + 0x18], rax
  0269A274: mov rax, rsi
  0269A277: sub rax, r15
  0269A27A: add qword ptr [r14 + rdx*8 + 0x2db0], rax
  0269A282: mov rax, qword ptr [r14 + 0x698]
  0269A289: xor r14d, r14d
  0269A28C: test rax, rax
  0269A28F: je 0x7ff68754a2b8
  0269A291: mov rcx, qword ptr [rbp + 0x660]
  0269A298: mov r9, rsi
  0269A29B: mov dword ptr [rsp + 0x30], r14d
  0269A2A0: mov r8, r15
  0269A2A3: mov dword ptr [rsp + 0x28], 0x11
  0269A2AB: mov byte ptr [rsp + 0x20], dl
  0269A2AF: mov rdx, r13
  0269A2B2: call qword ptr [rip + 0x3af2a80]
  0269A2B8: mov rax, qword ptr [rbp + 0x660]
  0269A2BF: lea r8, [rax + 0x18]
  0269A2C3: mov qword ptr [rax + 0x78], r13
  0269A2C7: movsxd rdx, dword ptr [r8]
  0269A2CA: movsxd rax, r8d
  0269A2CD: xor rdx, rax
  0269A2D0: cmp rdx, rdi
  0269A2D3: jge 0x7ff68754a2fd
  0269A2D5: mov rcx, rdx
  0269A2D8: shl rcx, 4
  0269A2DC: add rcx, 0xc
  0269A2E0: add rcx, r13
  0269A2E3: sub rdi, rdx
  0269A2E6: nop word ptr [rax + rax]
  0269A2F0: mov dword ptr [rcx], r14d
  0269A2F3: lea rcx, [rcx + 0x10]
  0269A2F7: sub rdi, 1
  0269A2FB: jne 0x7ff68754a2f0
  0269A2FD: mov eax, r8d
  0269A300: xor eax, dword ptr [rsp + 0x58]
  0269A304: mov dword ptr [r8], eax
  0269A307: movsxd rax, r12d
  0269A30A: mov r12, qword ptr [rbp + 0x660]
  0269A311: shl rax, 4
  0269A315: add rax, r13
  0269A318: mov qword ptr [r12 + 0x80], rax
  0269A320: mov rax, qword ptr [r12 + 0x70]
  0269A325: sub rax, rbx
  0269A328: and rax, 0xfffffffffffffff0
  0269A32C: add rax, qword ptr [r12 + 0x78]
  0269A331: mov qword ptr [r12 + 0x70], rax
  0269A336: mov rcx, qword ptr [r12 + 0x20]
  0269A33B: test rcx, rcx
  0269A33E: je 0x7ff68754a35d
  0269A340: mov rax, qword ptr [rcx + 8]
  0269A344: sub rax, rbx
  0269A347: and rax, 0xfffffffffffffff0
  0269A34B: add rax, qword ptr [r12 + 0x78]
  0269A350: mov qword ptr [rcx + 8], rax
  0269A354: mov rcx, qword ptr [rcx + 0x20]
  0269A358: test rcx, rcx
  0269A35B: jne 0x7ff68754a340
  0269A35D: mov rcx, qword ptr [r12 + 0x50]
  0269A362: lea r15, [r12 + 0x58]
  0269A367: cmp rcx, qword ptr [r15]
  0269A36A: ja 0x7ff68754a3b3
  0269A36C: nop dword ptr [rax]
  0269A370: mov rax, qword ptr [rcx + 0x10]
  0269A374: sub rax, rbx
  0269A377: and rax, 0xfffffffffffffff0
  0269A37B: add rax, qword ptr [r12 + 0x78]
  0269A380: mov qword ptr [rcx + 0x10], rax
  0269A384: mov rax, qword ptr [rcx]
  0269A387: sub rax, rbx
  0269A38A: and rax, 0xfffffffffffffff0
  0269A38E: add rax, qword ptr [r12 + 0x78]
  0269A393: mov qword ptr [rcx], rax
  0269A396: mov rax, qword ptr [rcx + 8]
  0269A39A: sub rax, rbx
  0269A39D: and rax, 0xfffffffffffffff0
  0269A3A1: add rax, qword ptr [r12 + 0x78]
  0269A3A6: mov qword ptr [rcx + 8], rax
  0269A3AA: add rcx, 0x30
  0269A3AE: cmp rcx, qword ptr [r15]
  0269A3B1: jbe 0x7ff68754a370
  0269A3B3: mov rcx, qword ptr [r12 + 0x60]
  0269A3B8: mov rdi, qword ptr [rsp + 0x70]
  0269A3BD: sub rcx, rbx
  0269A3C0: mov rbx, qword ptr [r12 + 0x78]
  0269A3C5: and rcx, 0xfffffffffffffff0
  0269A3C9: mov rsi, qword ptr [rbp - 0x68]
  0269A3CD: add rbx, rcx
  0269A3D0: mov r14, qword ptr [rbp - 0x78]
  0269A3D4: xor r13d, r13d
  0269A3D7: mov qword ptr [r12 + 0x60], rbx
  0269A3DC: cmp byte ptr [rsi + 6], 0
  0269A3E0: jne 0x7ff68754a4ad
  0269A3E6: mov rdx, qword ptr [rsi + 0x18]
  0269A3EA: mov rax, qword ptr [r12 + 0x70]
  0269A3EF: movzx ecx, byte ptr [rdx + 5]
  0269A3F3: shl rcx, 4
  0269A3F7: add rcx, rbx
  0269A3FA: cmp rax, rcx
  0269A3FD: jae 0x7ff68754a40d
  0269A3FF: nop 
  0269A400: mov dword ptr [rax + 0xc], r13d
  0269A404: add rax, 0x10
  0269A408: cmp rax, rcx
  0269A40B: jb 0x7ff68754a400
  0269A40D: cmp byte ptr [rdx + 4], 0
  0269A411: jne 0x7ff68754a417
  0269A413: mov rax, qword ptr [rdi + 0x10]
  0269A417: mov qword ptr [r12 + 0x70], rax
  0269A41C: mov rax, qword ptr [rdx + 0x50]
  0269A420: mov qword ptr [rdi + 0x20], rax
  0269A424: cmp qword ptr [rdx + 0x68], 0
  0269A429: je 0x7ff68754a439
  0269A42B: cmp qword ptr [rdx + 0x60], 0
  0269A430: je 0x7ff68754a439
  0269A432: mov dword ptr [rdi + 0x2c], 4
  0269A439: mov rax, qword ptr [r15]
  0269A43C: or dword ptr [rax + 0x2c], 1
  0269A440: movzx edi, byte ptr [r12 + 6]
  0269A446: mov byte ptr [r12 + 6], 1
  0269A44C: test byte ptr [r12 + 2], 4
  0269A452: je 0x7ff68754a464
  0269A454: lea r8, [r12 + 0x10]
  0269A459: mov rdx, r12
  0269A45C: mov rcx, r12
  0269A45F: call 0x7ff687517680
  0269A464: cmp byte ptr [rip + 0x570ec6d], 0
  0269A46B: je 0x7ff68754a47b
  0269A46D: mov rbx, qword ptr [r15]
  0269A470: sub rbx, qword ptr [r12 + 0x50]
  0269A475: sub rbx, 0x30
  0269A479: jmp 0x7ff68754a47e
  0269A47B: mov rbx, r13
  0269A47E: mov rcx, r12
  0269A481: call 0x7ff687531d50
  0269A486: cmp byte ptr [rip + 0x570ec4b], 0
  0269A48D: je 0x7ff68754a49a
  0269A48F: mov rdx, rbx
  0269A492: mov rcx, r12
  0269A495: call 0x7ff6875047e0
  0269A49A: test dil, dil
  0269A49D: jne 0x7ff68754a530
  0269A4A3: mov byte ptr [r12 + 6], dil
  0269A4A8: jmp 0x7ff68754a530
  0269A4AD: mov rax, qword ptr [rsi + 0x28]
  0269A4B1: mov rcx, r12
  0269A4B4: call qword ptr [rip + 0x3af287e]
  0269A4BA: test eax, eax
  0269A4BC: js 0x7ff68754a530
  0269A4BE: mov rcx, qword ptr [r15]
  0269A4C1: mov r8d, 3
  0269A4C7: mov r10, qword ptr [r12 + 0x70]
  0269A4CC: cdqe 
  0269A4CE: mov r9, r10
  0269A4D1: shl rax, 4
  0269A4D5: mov rdx, qword ptr [rcx + 8]
  0269A4D9: lea r11, [rcx - 0x30]
  0269A4DD: sub r9, rax
  0269A4E0: cmp r9, r10
  0269A4E3: jae 0x7ff68754a4ff
  0269A4E5: mov rcx, r9
  0269A4E8: mov rax, rdx
  0269A4EB: add r9, 0x10
  0269A4EF: add rdx, 0x10
  0269A4F3: movups xmm0, xmmword ptr [rcx]
  0269A4F6: movups xmmword ptr [rax], xmm0
  0269A4F9: sub r8d, 1
  0269A4FD: jne 0x7ff68754a4e0
  0269A4FF: test r8d, r8d
  0269A502: jle 0x7ff68754a520
  0269A504: nop dword ptr [rax]
  0269A508: nop dword ptr [rax + rax]
  0269A510: mov dword ptr [rdx + 0xc], r13d
  0269A514: dec r8d
  0269A517: add rdx, 0x10
  0269A51B: test r8d, r8d
  0269A51E: jg 0x7ff68754a510
  0269A520: mov qword ptr [r15], r11
  0269A523: mov rax, qword ptr [r11]
  0269A526: mov qword ptr [r12 + 0x60], rax
  0269A52B: mov qword ptr [r12 + 0x70], rdx
  0269A530: movzx eax, byte ptr [r12 + 3]
  0269A536: cmp al, 1
  0269A538: je 0x7ff68754a546
  0269A53A: cmp al, 6
  0269A53C: je 0x7ff68754a546
  0269A53E: cmp al, 0x7f
  0269A540: je 0x7ff68754a546
  0269A542: xor al, al
  0269A544: jmp 0x7ff68754a548
  0269A546: mov al, 1
  0269A548: cmp byte ptr [rbp + 0x668], 0
  0269A54F: je 0x7ff68754a57e
  0269A551: mov ecx, 0xffff
  0269A556: add word ptr [r12 + 0x3a], cx
  0269A55C: test al, al
  0269A55E: je 0x7ff68754a582
  0269A560: mov rcx, qword ptr [rsp + 0x78]
  0269A565: mov rax, qword ptr [r12 + 0x50]
  0269A56A: add rcx, 0x30
  0269A56E: mov rdx, qword ptr [rbp - 0x70]
  0269A572: add rcx, qword ptr [r12 + 0x78]
  0269A577: mov qword ptr [rdx + rax + 0x10], rcx
  0269A57C: jmp 0x7ff68754a595
  0269A57E: test al, al
  0269A580: jne 0x7ff68754a595
  0269A582: mov rcx, qword ptr [rsp + 0x78]
  0269A587: add rcx, 0x30
  0269A58B: add rcx, qword ptr [r12 + 0x78]
  0269A590: mov qword ptr [r12 + 0x70], rcx
  0269A595: mov eax, 0xffff
  0269A59A: add word ptr [r12 + 0x38], ax
  0269A5A0: mov rcx, qword ptr [r12 + 0x68]
  0269A5A5: mov rax, qword ptr [rcx + 0x10]
  0269A5A9: cmp qword ptr [rcx + 0x18], rax
  0269A5AD: jb 0x7ff68754a5b9
  0269A5AF: mov dl, 1
  0269A5B1: mov rcx, r12
  0269A5B4: call 0x7ff6875170b0
  0269A5B9: mov r13, qword ptr [r12 + 0x60]
  0269A5BE: mov rcx, qword ptr [r15]
  0269A5C1: lea rdx, [r14 + r13]
  0269A5C5: mov qword ptr [rsp + 0x48], r13
  0269A5CA: mov rax, qword ptr [rcx + 0x10]
  0269A5CE: mov qword ptr [r12 + 0x70], rax
  0269A5D3: cmp dword ptr [rdx + 0xc], 0
  0269A5D7: je 0x7ff68754d913
  0269A5DD: movsxd rax, dword ptr [rsp + 0x6c]
  0269A5E2: lea r14, [r12 + 0x58]
  0269A5E7: mov r15, qword ptr [rsp + 0x50]
  0269A5EC: sar rax, 0x10
  0269A5F0: lea r15, [r15 + rax*4]
  0269A5F4: jmp 0x7ff687540356
  0269A5F9: test r10, r10
  0269A5FC: je 0x7ff68754a62a
  0269A5FE: movzx r9d, byte ptr [r10 + 3]
  0269A603: test r9b, 0x10
  0269A607: jne 0x7ff68754a62a
  0269A609: cmp byte ptr [rip + 0x570e3e0], 0
  0269A610: je 0x7ff68754a667
  0269A612: test byte ptr [r10 + 7], 2
  0269A617: je 0x7ff68754a667
  0269A619: mov rcx, qword ptr [r10 + 0x20]
  0269A61D: sub rcx, 0x50
  0269A621: test rcx, rcx
  0269A624: jne 0x7ff68754b150
  0269A62A: cmp dword ptr [rdi + 0xc], 7
  0269A62E: jne 0x7ff68754d972
  0269A634: movups xmm0, xmmword ptr [rdi]
  0269A637: movsxd rax, dword ptr [rsp + 0x6c]
  0269A63C: lea r14, [r12 + 0x58]
  0269A641: sar rax, 0x10
  0269A645: movups xmmword ptr [rdi + 0x10], xmm0
  0269A649: mov qword ptr [rdi + 0x20], rsi
  0269A64D: mov dword ptr [rdi + 0x28], 0x80
  0269A654: mov dword ptr [rdi + 0x2c], 2
  0269A65B: lea r15, [r15 + rax*4]
  0269A65F: mov dword ptr [rdi + 0xc], esi
  0269A662: jmp 0x7ff687540356
  0269A667: mov rax, qword ptr [r12 + 0x68]
  0269A66C: movzx ecx, byte ptr [r10 + 4]
  0269A671: mov r8, qword ptr [rax + 0x428]
  0269A678: mov eax, 1
  0269A67D: shl eax, cl
  0269A67F: dec eax
  0269A681: movsxd rcx, eax
  0269A684: mov eax, dword ptr [r8 + 0x10]
  0269A688: lea rdx, [r8 + 0x10]
  0269A68C: add eax, edx
  0269A68E: cdqe 
  0269A690: and rcx, rax
  0269A693: shl rcx, 5
  0269A697: add rcx, qword ptr [r10 + 0x18]
  0269A69B: nop dword ptr [rax + rax]
  0269A6A0: movsxd rdx, dword ptr [rcx + 0x1c]
  0269A6A4: mov eax, edx
  0269A6A6: and eax, 0xf
  0269A6A9: cmp al, 6
  0269A6AB: jne 0x7ff68754a6b3
  0269A6AD: cmp qword ptr [rcx + 0x10], r8
  0269A6B1: je 0x7ff68754a6ce
  0269A6B3: test edx, 0xfffffff0
  0269A6B9: je 0x7ff68754a6cb
  0269A6BB: mov rax, rdx
  0269A6BE: sar rax, 4
  0269A6C2: shl rax, 5
  0269A6C6: add rcx, rax
  0269A6C9: jmp 0x7ff68754a6a0
  0269A6CB: mov rcx, rbx
  0269A6CE: cmp dword ptr [rcx + 0xc], 0
  0269A6D2: jne 0x7ff68754a621
  0269A6D8: or r9b, 0x10
  0269A6DC: mov byte ptr [r10 + 3], r9b
  0269A6E0: jmp 0x7ff68754a62a
  0269A6E5: cmp eax, 8
  0269A6E8: je 0x7ff68754b150
  0269A6EE: cmp eax, 7
  0269A6F1: jne 0x7ff68754a6fc
  0269A6F3: mov rax, qword ptr [rdi]
  0269A6F6: mov r10, qword ptr [rax + 0x28]
  0269A6FA: jmp 0x7ff68754a712
  0269A6FC: cmp eax, 9
  0269A6FF: jne 0x7ff68754b128
  0269A705: mov rcx, qword ptr [rdi]
  0269A708: add rcx, 8
  0269A70C: mov r10, qword ptr [rcx]
  0269A70F: add r10, rcx
  0269A712: test r10, r10
  0269A715: je 0x7ff68754b128
  0269A71B: movzx r9d, byte ptr [r10 + 3]
  0269A720: test r9b, 0x20
  0269A724: jne 0x7ff68754b0f9
  0269A72A: cmp byte ptr [rip + 0x570e2bf], 0
  0269A731: je 0x7ff68754a83c
  0269A737: test byte ptr [r10 + 7], 2
  0269A73C: je 0x7ff68754a83c
  0269A742: mov rdx, qword ptr [r10 + 0x20]
  0269A746: lea rsi, [rip + 0x3e6d58b]
  0269A74D: sub rdx, 0x60
  0269A751: test rdx, rdx
  0269A754: je 0x7ff68754b100
  0269A75A: movups xmm0, xmmword ptr [rdi]
  0269A75D: lea rbx, [rdi + 0x10]
  0269A761: lea rax, [rdi + 0x20]
  0269A765: mov qword ptr [rsp + 0x60], rbx
  0269A76A: movups xmmword ptr [rbx], xmm0
  0269A76D: movups xmm0, xmmword ptr [rdx]
  0269A770: movups xmmword ptr [rdi], xmm0
  0269A773: mov qword ptr [r12 + 0x70], rax
  0269A778: mov rax, qword ptr [r12 + 0x58]
  0269A77D: mov qword ptr [rax + 0x20], r15
  0269A781: mov eax, 0xc8
  0269A786: inc word ptr [r12 + 0x38]
  0269A78C: cmp word ptr [r12 + 0x38], ax
  0269A792: jb 0x7ff68754a79c
  0269A794: mov rcx, r12
  0269A797: call 0x7ff687502140
  0269A79C: mov r8, qword ptr [r12 + 0x58]
  0269A7A1: lea r15, [r12 + 0x58]
  0269A7A6: mov rdx, qword ptr [r12 + 0x50]
  0269A7AB: mov byte ptr [rbp + 0x668], 0
  0269A7B2: cmp r8, rdx
  0269A7B5: je 0x7ff68754a7da
  0269A7B7: mov rax, qword ptr [r8 + 8]
  0269A7BB: mov rcx, qword ptr [rax]
  0269A7BE: cmp byte ptr [rcx + 6], 0
  0269A7C2: je 0x7ff68754a7da
  0269A7C4: add rcx, 0x20
  0269A7C8: cmp qword ptr [rcx], rcx
  0269A7CB: je 0x7ff68754a7da
  0269A7CD: inc word ptr [r12 + 0x3a]
  0269A7D3: mov byte ptr [rbp + 0x668], 1
  0269A7DA: sub r8, rdx
  0269A7DD: mov rax, rdi
  0269A7E0: sub rax, qword ptr [r12 + 0x78]
  0269A7E5: cmp dword ptr [rdi + 0xc], 8
  0269A7E9: mov qword ptr [rsp + 0x78], rax
  0269A7EE: mov qword ptr [rbp - 0x70], r8
  0269A7F2: je 0x7ff68754a7ff
  0269A7F4: mov rdx, rdi
  0269A7F7: mov rcx, r12
  0269A7FA: call 0x7ff687512950
  0269A7FF: mov rax, qword ptr [r15]
  0269A802: mov rsi, qword ptr [rdi]
  0269A805: mov qword ptr [rbp - 0x68], rsi
  0269A809: cmp rax, qword ptr [r12 + 0x48]
  0269A80E: jne 0x7ff68754ab0d
  0269A814: movsxd rax, dword ptr [r12 + 0x1c]
  0269A819: cmp eax, 0x57e4
  0269A81E: jge 0x7ff68754dad9
  0269A824: lea ecx, [rax + rax]
  0269A827: cmp eax, 0x4e20
  0269A82C: jl 0x7ff68754a8c5
  0269A832: mov edx, 0x57e4
  0269A837: jmp 0x7ff68754a8cf
  0269A83C: mov rax, qword ptr [r12 + 0x68]
  0269A841: movzx ecx, byte ptr [r10 + 4]
  0269A846: mov r8, qword ptr [rax + 0x430]
  0269A84D: mov eax, 1
  0269A852: shl eax, cl
  0269A854: dec eax
  0269A856: movsxd rdx, eax
  0269A859: mov eax, dword ptr [r8 + 0x10]
  0269A85D: add eax, 0x10
  0269A860: add eax, r8d
  0269A863: cdqe 
  0269A865: and rdx, rax
  0269A868: shl rdx, 5
  0269A86C: add rdx, qword ptr [r10 + 0x18]
  0269A870: movsxd rcx, dword ptr [rdx + 0x1c]
  0269A874: mov eax, ecx
  0269A876: and eax, 0xf
  0269A879: cmp al, 6
  0269A87B: jne 0x7ff68754a883
  0269A87D: cmp qword ptr [rdx + 0x10], r8
  0269A881: je 0x7ff68754a89b
  0269A883: test ecx, 0xfffffff0
  0269A889: je 0x7ff68754a8a4
  0269A88B: mov rax, rcx
  0269A88E: sar rax, 4
  0269A892: shl rax, 5
  0269A896: add rdx, rax
  0269A899: jmp 0x7ff68754a870
  0269A89B: lea rsi, [rip + 0x3e6d436]
  0269A8A2: jmp 0x7ff68754a8ae
  0269A8A4: lea rsi, [rip + 0x3e6d42d]
  0269A8AB: mov rdx, rsi
  0269A8AE: cmp dword ptr [rdx + 0xc], 0
  0269A8B2: jne 0x7ff68754a751
  0269A8B8: or r9b, 0x20
  0269A8BC: mov byte ptr [r10 + 3], r9b
  0269A8C0: jmp 0x7ff68754b100
  0269A8C5: mov edx, 0x4e20
  0269A8CA: cmp ecx, edx
  0269A8CC: cmovl edx, ecx
  0269A8CF: movzx ecx, byte ptr [r12]
  0269A8D4: mov r13, qword ptr [r12 + 0x50]
  0269A8D9: mov byte ptr [rbp + 0x670], cl
  0269A8DF: movabs rcx, 0x555555555555555
  0269A8E9: movsxd r15, edx
  0269A8EC: mov dword ptr [rsp + 0x58], edx
  0269A8F0: cmp r15, rcx
  0269A8F3: ja 0x7ff68754daee
  0269A8F9: mov rdi, qword ptr [r12 + 0x68]
  0269A8FE: lea rsi, [rax + rax*2]
  0269A902: lea rbx, [r15 + r15*2]
  0269A906: mov qword ptr [rsp + 0x70], rax
  0269A90B: shl rbx, 4
  0269A90F: lea rcx, [rip - 0x269a916]
  0269A916: shl rsi, 4
  0269A91A: mov rdx, 0xffffffffffffffff
  0269A921: lea rax, [rbx - 1]
  0269A925: cmp rax, 0x400
  0269A92B: jae 0x7ff68754a938
  0269A92D: movsx r14d, byte ptr [rbx + rcx + 0x7da8c10]
  0269A936: jmp 0x7ff68754a93b
  0269A938: mov r14d, edx
  0269A93B: lea rax, [rsi - 1]
  0269A93F: cmp rax, 0x400
  0269A945: jae 0x7ff68754a952
  0269A947: movsx r12d, byte ptr [rsi + rcx + 0x7da8c10]
  0269A950: jmp 0x7ff68754a955
  0269A952: mov r12d, edx
  0269A955: mov rax, qword ptr [rdi + 0x680]
  0269A95C: test rax, rax
  0269A95F: je 0x7ff68754a976
  0269A961: test r13, r13
  0269A964: je 0x7ff68754a976
  0269A966: mov rcx, qword ptr [rbp + 0x660]
  0269A96D: mov rdx, r13
  0269A970: call qword ptr [rip + 0x3af23c2]
  0269A976: test r14d, r14d
  0269A979: jns 0x7ff68754a9be
  0269A97B: mov rcx, qword ptr [rdi + 0x30]
  0269A97F: mov r9, rbx
  0269A982: mov rax, qword ptr [rdi + 0x28]
  0269A986: test r12d, r12d
  0269A989: jns 0x7ff68754a9b1
  0269A98B: mov r8, rsi
  0269A98E: mov rdx, r13
  0269A991: call qword ptr [rip + 0x3af23a1]
  0269A997: mov r14, rax
  0269A99A: test rax, rax
  0269A99D: jne 0x7ff68754aa37
  0269A9A3: test rbx, rbx
  0269A9A6: jne 0x7ff68754d588
  0269A9AC: jmp 0x7ff68754aa37
  0269A9B1: xor r8d, r8d
  0269A9B4: xor edx, edx
  0269A9B6: call qword ptr [rip + 0x3af237c]
  0269A9BC: jmp 0x7ff68754a9cd
  0269A9BE: mov rcx, qword ptr [rbp + 0x660]
  0269A9C5: mov edx, r14d
  0269A9C8: call 0x7ff687530640
  0269A9CD: mov r14, rax
  0269A9D0: test rax, rax
  0269A9D3: jne 0x7ff68754a9de
  0269A9D5: test rbx, rbx
  0269A9D8: jne 0x7ff68754d588
  0269A9DE: test rsi, rsi
  0269A9E1: je 0x7ff68754aa04
  0269A9E3: test rbx, rbx
  0269A9E6: je 0x7ff68754aa04
  0269A9E8: cmp rsi, rbx
  0269A9EB: mov rdx, r13
  0269A9EE: mov rcx, r14
  0269A9F1: cmovb r15, qword ptr [rsp + 0x70]
  0269A9F7: lea r8, [r15 + r15*2]
  0269A9FB: shl r8, 4
  0269A9FF: call 0x7ff68aa48aa0
  0269AA04: test r12d, r12d
  0269AA07: js 0x7ff68754aa20
  0269AA09: mov edx, r12d
  0269AA0C: mov r8, r13
  0269AA0F: mov r12, qword ptr [rbp + 0x660]
  0269AA16: mov rcx, r12
  0269AA19: call 0x7ff68752ff80
  0269AA1E: jmp 0x7ff68754aa3e
  0269AA20: mov rcx, qword ptr [rdi + 0x30]
  0269AA24: xor r9d, r9d
  0269AA27: mov rax, qword ptr [rdi + 0x28]
  0269AA2B: mov r8, rsi
  0269AA2E: mov rdx, r13
  0269AA31: call qword ptr [rip + 0x3af2301]
  0269AA37: mov r12, qword ptr [rbp + 0x660]
  0269AA3E: movzx edx, byte ptr [rbp + 0x670]
  0269AA45: mov rax, rbx
  0269AA48: sub rax, rsi
  0269AA4B: add qword ptr [rdi + 0x18], rax
  0269AA4F: mov rax, rbx
  0269AA52: sub rax, rsi
  0269AA55: add qword ptr [rdi + rdx*8 + 0x2db0], rax
  0269AA5D: mov rax, qword ptr [rdi + 0x698]
  0269AA64: test rax, rax
  0269AA67: je 0x7ff68754aa8d
  0269AA69: xor ecx, ecx
  0269AA6B: mov r9, rbx
  0269AA6E: mov dword ptr [rsp + 0x30], ecx
  0269AA72: mov r8, rsi
  0269AA75: mov dword ptr [rsp + 0x28], 0x11
  0269AA7D: mov rcx, r12
  0269AA80: mov byte ptr [rsp + 0x20], dl
  0269AA84: mov rdx, r14
  0269AA87: call qword ptr [rip + 0x3af22ab]
  0269AA8D: movsxd r8, dword ptr [rsp + 0x58]
  0269AA92: lea r15, [r12 + 0x58]
  0269AA97: mov qword ptr [r12 + 0x50], r14
  0269AA9C: movabs rax, 0x2aaaaaaaaaaaaaab
  0269AAA6: mov dword ptr [r12 + 0x1c], r8d
  0269AAAB: mov rcx, qword ptr [r15]
  0269AAAE: sub rcx, r13
  0269AAB1: imul rcx
  0269AAB4: lea rcx, [r8 + r8*2]
  0269AAB8: sar rdx, 3
  0269AABC: mov rax, rdx
  0269AABF: shl rcx, 4
  0269AAC3: shr rax, 0x3f
  0269AAC7: add rcx, -0x30
  0269AACB: add rdx, rax
  0269AACE: lea rdx, [rdx + rdx*2]
  0269AAD2: shl rdx, 4
  0269AAD6: add rdx, r14
  0269AAD9: mov qword ptr [r15], rdx
  0269AADC: add rcx, qword ptr [r12 + 0x50]
  0269AAE1: mov qword ptr [r12 + 0x48], rcx
  0269AAE6: cmp dword ptr [r12 + 0x1c], 0x4e20
  0269AAEF: jg 0x7ff68754d9a3
  0269AAF5: mov rbx, qword ptr [rsp + 0x60]
  0269AAFA: lea rdi, [rdx + 0x30]
  0269AAFE: mov rsi, qword ptr [rbp - 0x68]
  0269AB02: mov r14, qword ptr [rbp - 0x78]
  0269AB06: mov r13, qword ptr [rsp + 0x48]
  0269AB0B: jmp 0x7ff68754ab11
