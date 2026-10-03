func 0x1593DFA (pid 22196, base 0x7FF684EB0000)
  01593DFA: add byte ptr [rax], al
  01593DFC: lea rcx, [r14 + 0x7f8]
  01593E03: mov qword ptr [rsp + 0x40], rcx
  01593E08: mov dword ptr [rsp + 0x60], 0
  01593E10: lea rdx, [rsp + 0x60]
  01593E15: call 0x7ff6857d8200
  01593E1A: nop 
  01593E1B: lea rcx, [r14 + 0x838]
  01593E22: mov qword ptr [rsp + 0x40], rcx
  01593E27: mov dword ptr [rsp + 0x64], 0
  01593E2F: lea rdx, [rsp + 0x64]
  01593E34: call 0x7ff6857d8200
  01593E39: nop 
  01593E3A: lea rcx, [r14 + 0x878]
  01593E41: mov qword ptr [rsp + 0x40], rcx
  01593E46: xor edx, edx
  01593E48: call 0x7ff68645d760
  01593E4D: nop 
  01593E4E: mov qword ptr [r14 + 0x890], r12
  01593E55: mov qword ptr [r14 + 0x898], r12
  01593E5C: mov qword ptr [r14 + 0x8a0], r12
  01593E63: mov qword ptr [r14 + 0x8a8], r12
  01593E6A: mov qword ptr [r14 + 0x8b0], r12
  01593E71: mov qword ptr [r14 + 0x8b8], r12
  01593E78: mov byte ptr [r14 + 0x8c0], 1
  01593E80: mov ecx, 0x58
  01593E85: call 0x7ff689839610
  01593E8A: mov rcx, rax
  01593E8D: test rax, rax
  01593E90: je 0x7ff686444413
  01593E96: add rax, 8
  01593E9A: mov qword ptr [rcx + 0x10], r12
  01593E9E: mov qword ptr [rcx], r12
  01593EA1: mov qword ptr [rax], rax
  01593EA4: mov qword ptr [rax + 8], rax
  01593EA8: mov qword ptr [rcx + 0x18], r12
  01593EAC: mov qword ptr [rcx + 0x20], r12
  01593EB0: mov qword ptr [rcx + 0x28], r12
  01593EB4: mov qword ptr [rcx + 0x30], r12
  01593EB8: mov qword ptr [rcx + 0x38], r12
  01593EBC: xor eax, eax
  01593EBE: mov dword ptr [rcx + 0x40], eax
  01593EC1: mov qword ptr [rcx + 0x48], r12
  01593EC5: mov qword ptr [rcx + 0x50], r12
  01593EC9: mov qword ptr [r14 + 0x8d0], rcx
  01593ED0: mov dword ptr [r14 + 0x8e0], 0xffffffff
  01593EDB: lea rcx, [r14 + 0x8e8]
  01593EE2: call 0x7ff68983d810
  01593EE7: xorps xmm0, xmm0
  01593EEA: xor eax, eax
  01593EEC: movups xmmword ptr [r14 + 0x8f0], xmm0
  01593EF4: mov dword ptr [r14 + 0x900], eax
  01593EFB: lea rbx, [r14 + 0x908]
  01593F02: mov qword ptr [rsp + 0x40], rbx
  01593F07: mov qword ptr [rbx], r12
  01593F0A: mov qword ptr [rbx + 8], r12
  01593F0E: lea ecx, [rax + 0x28]
  01593F11: call 0x7ff68569d690
  01593F16: mov qword ptr [rax], rax
  01593F19: mov qword ptr [rax + 8], rax
  01593F1D: mov qword ptr [rax + 0x10], rax
  01593F21: mov word ptr [rax + 0x18], 0x101
  01593F27: mov qword ptr [rbx], rax
  01593F2A: lea rcx, [rbx + 0x10]
  01593F2E: mov qword ptr [rbp - 0x80], rcx
  01593F32: mov qword ptr [rcx], r12
  01593F35: mov qword ptr [rcx + 8], r12
  01593F39: mov qword ptr [rcx + 0x10], r12
  01593F3D: mov qword ptr [rcx + 0x18], r12
  01593F41: mov qword ptr [rcx + 0x20], r12
  01593F45: call 0x7ff685bb4140
  01593F4A: nop 
  01593F4B: lea rcx, [rbx + 0x38]
  01593F4F: mov qword ptr [rbp - 0x80], rcx
  01593F53: mov dword ptr [rsp + 0x68], 0
  01593F5B: lea rdx, [rsp + 0x68]
  01593F60: call 0x7ff6857d8200
  01593F65: nop 
  01593F66: mov ecx, dword ptr [rip + 0x6cf831c]
  01593F6C: call 0x7ff689838a10
  01593F71: mov esi, eax
  01593F73: mov dword ptr [rsp + 0x6c], eax
  01593F77: mov ecx, 0xf48
  01593F7C: call 0x7ff689839610
  01593F81: test rax, rax
  01593F84: je 0x7ff6864443f9
  01593F8A: mov qword ptr [rsp + 0x40], rax
  01593F8F: mov r8d, dword ptr [r13]
  01593F93: mov rdx, r14
  01593F96: mov rcx, rax
  01593F99: call 0x7ff6864e7e20
  01593F9E: nop 
  01593F9F: mov qword ptr [r14 + 0x8c8], rax
  01593FA6: mov ecx, 0x50
  01593FAB: call 0x7ff689839610
  01593FB0: test rax, rax
  01593FB3: je 0x7ff6864443df
  01593FB9: mov qword ptr [rsp + 0x40], rax
  01593FBE: mov rdx, r14
  01593FC1: mov rcx, rax
  01593FC4: call 0x7ff68643df80
  01593FC9: nop 
  01593FCA: mov qword ptr [r14 + 0x8d8], rax
  01593FD1: mov rcx, r14
  01593FD4: cmp byte ptr [rip + 0x6cfa02d], 0
  01593FDB: jne 0x7ff686443fed
  01593FDD: mov eax, 3
  01593FE2: cmp byte ptr [rip + 0x6cf8b4f], 0
  01593FE9: cmovne r15d, eax
  01593FED: mov edx, r15d
  01593FF0: call 0x7ff6864431b0
  01593FF5: mov rcx, qword ptr [r14 + 0x2e8]
  01593FFC: movzx r8d, byte ptr [rcx + 0x1b6]
  01594004: and r8b, 1
  01594008: mov dl, 1
  0159400A: call 0x7ff6864b49a0
  0159400F: mov rdx, r14
  01594012: mov rcx, qword ptr [r14 + 0x2e8]
  01594019: call 0x7ff6864ae0c0
  0159401E: mov rdx, qword ptr [r14 + 0x2e8]
  01594025: mov rcx, qword ptr [r14 + 0x8d8]
  0159402C: call 0x7ff68643e650
  01594031: mov qword ptr [rbp + 0x38], r12
  01594035: mov qword ptr [rbp + 0x48], r12
  01594039: mov qword ptr [rbp + 0x50], 0xf
  01594041: mov byte ptr [rbp + 0x38], 0
  01594045: mov r8d, 0xb
  0159404B: lea rdx, [rip + 0x5942396]
  01594052: lea rcx, [rbp + 0x38]
  01594056: call 0x7ff6856b8180
  0159405B: nop 
  0159405C: lea r8, [rbp + 0x38]
  01594060: lea rdx, [rbp - 0x70]
  01594064: lea rcx, [r14 + 0x258]
  0159406B: call 0x7ff6864e3d60
  01594070: nop 
  01594071: mov rax, qword ptr [rbp + 0x50]
  01594075: cmp rax, 0x10
  01594079: jb 0x7ff6864440a8
  0159407B: inc rax
  0159407E: mov rcx, qword ptr [rbp + 0x38]
  01594082: mov rdx, rcx
  01594085: cmp rax, 0x1000
  0159408B: jb 0x7ff6864440a2
  0159408D: mov rcx, qword ptr [rcx - 8]
  01594091: sub rdx, rcx
  01594094: lea rax, [rdx - 8]
  01594098: cmp rax, 0x1f
  0159409C: ja 0x7ff6864443a5
  015940A2: call 0x7ff689838ee0
  015940A7: nop 
  015940A8: mov qword ptr [rbp + 0x48], r12
  015940AC: mov qword ptr [rbp + 0x50], 0xf
  015940B4: mov byte ptr [rbp + 0x38], 0
  015940B8: mov ecx, dword ptr [rip + 0x6d6634a]
  015940BE: call 0x7ff689838a10
  015940C3: mov ebx, eax
  015940C5: mov dword ptr [rsp + 0x70], eax
  015940C9: mov ecx, 0x18
  015940CE: call 0x7ff689839610
  015940D3: mov r15, rax
  015940D6: test rax, rax
  015940D9: je 0x7ff6864443c5
  015940DF: mov qword ptr [rbp - 0x50], rax
  015940E3: movzx r12d, byte ptr [r13 + 8]
  015940E8: xor r13d, r13d
  015940EB: mov qword ptr [rax], r13
  015940EE: mov ecx, dword ptr [rip + 0x6d66314]
  015940F4: call 0x7ff689838a10
  015940F9: mov edi, eax
  015940FB: mov dword ptr [rbp - 0x80], eax
  015940FE: inc dword ptr [rip + 0x6c62340]
  01594104: lea edx, [r13 + 0x10]
  01594108: mov ecx, 0x140
  0159410D: mov rax, qword ptr [rip + 0x68143ac]
  01594114: call qword ptr [rip + 0x4bf8c1e]
  0159411A: mov qword ptr [rsp + 0x40], rax
  0159411F: mov qword ptr [rsp + 0x40], rax
  01594124: test rax, rax
  01594127: je 0x7ff686444141
  01594129: mov ecx, 0xfff0
  0159412E: and word ptr [rax + 0x110], cx
  01594135: mov dword ptr [rax + 0x130], 0x38d1b717
  0159413F: jmp 0x7ff686444144
  01594141: mov rax, r13
  01594144: mov qword ptr [r15 + 8], rax
  01594148: inc dword ptr [rip + 0x6c622f6]
  0159414E: mov edx, 0x10
  01594153: lea ecx, [rdx - 8]
  01594156: mov rax, qword ptr [rip + 0x6814363]
  0159415D: call qword ptr [rip + 0x4bf8bd5]
  01594163: mov qword ptr [rsp + 0x40], rax
  01594168: lea rcx, [rip + 0x583aa31]
  0159416F: mov qword ptr [rax], rcx
  01594172: mov qword ptr [r15 + 0x10], rax
  01594176: test r12b, r12b
  01594179: je 0x7ff6864441cb
  0159417B: inc dword ptr [rip + 0x6c622c3]
  01594181: mov edx, 0x80
  01594186: mov ecx, 0x80080
  0159418B: mov rax, qword ptr [rip + 0x681432e]
  01594192: call qword ptr [rip + 0x4bf8ba0]
  01594198: mov r13, rax
  0159419B: mov qword ptr [rsp + 0x40], rax
  015941A0: xor edx, edx
  015941A2: mov r8d, 0x80080
  015941A8: mov rcx, rax
  015941AB: call 0x7ff68aa47ac0
  015941B0: mov dword ptr [rsp + 0x40], 0xffffffff
  015941B8: xor r12d, r12d
  015941BB: mov dword ptr [rsp + 0x44], r12d
  015941C0: mov rax, qword ptr [rsp + 0x40]
  015941C5: mov qword ptr [r13 + 8], rax
  015941C9: jmp 0x7ff6864441d1
  015941CB: xor r12d, r12d
  015941CE: mov r13d, r12d
  015941D1: mov rax, r15
  015941D4: mov qword ptr [rax], r13
  015941D7: mov ecx, edi
  015941D9: call 0x7ff689838a10
  015941DE: nop 
  015941DF: mov qword ptr [r14 + 0x3d0], r15
  015941E6: mov ecx, 0x18
  015941EB: call 0x7ff689839610
  015941F0: mov rcx, rax
  015941F3: test rax, rax
  015941F6: je 0x7ff6864443ab
  015941FC: mov rax, qword ptr [r14 + 0x3d0]
  01594203: lea rdx, [rip + 0x583a9ee]
  0159420A: mov qword ptr [rcx], rdx
  0159420D: mov dword ptr [rcx + 8], r12d
  01594211: mov qword ptr [rcx + 0x10], rax
  01594215: mov qword ptr [r14 + 0x3c8], rcx
  0159421C: mov rax, qword ptr [rip + 0x682a765]
  01594223: cmp al, 6
  01594225: jb 0x7ff68644427c
  01594227: shr rax, 8
  0159422B: cmp al, 3
  0159422D: jb 0x7ff68644427c
  0159422F: lea rax, [rip + 0x5d9f532]
  01594236: mov qword ptr [rsp + 0x40], rax
  0159423B: mov rdx, qword ptr [rsp + 0x40]
  01594240: sub rdx, 0x45d3b0
  01594247: movups xmm0, xmmword ptr [rip + 0x682a73a]
  0159424E: movaps xmmword ptr [rbp - 0x50], xmm0
  01594252: mov qword ptr [rsp + 0x30], r12
  01594257: mov qword ptr [rsp + 0x28], r12
  0159425C: mov qword ptr [rsp + 0x20], r12
  01594261: xor r9d, r9d
  01594264: mov r8, qword ptr [r14 + 0x3c8]
  0159426B: lea rcx, [rbp - 0x50]
  0159426F: call 0x7ff6898550d0
  01594274: mov esi, dword ptr [rsp + 0x6c]
  01594278: mov ebx, dword ptr [rsp + 0x70]
  0159427C: movd xmm0, dword ptr [rip + 0x67fb3a4]
  01594284: cvtdq2ps xmm0, xmm0
  01594287: divss xmm0, dword ptr [rip + 0x5c87c1d]
  0159428F: movss dword ptr [rip + 0x67df3f1], xmm0
  01594297: mov byte ptr [rip + 0x6cb92e8], 1
  0159429E: mov ecx, ebx
  015942A0: call 0x7ff689838a10
  015942A5: nop 
  015942A6: cmp byte ptr [rip + 0x6cf927b], 0
  015942AD: je 0x7ff686444339
  015942B3: cmp byte ptr [rip + 0x6cfc1de], 0
  015942BA: je 0x7ff686444339
  015942BC: cmp byte ptr [rip + 0x6cfc295], 0
  015942C3: je 0x7ff686444339
  015942C5: cmp byte ptr [rip + 0x7150ad4], 0
  015942CC: je 0x7ff686444339
  015942CE: mov rax, qword ptr [r14 + 0x248]
  015942D5: inc dword ptr [rax + 0x28]
  015942D8: mov edi, dword ptr [rax + 0x28]
  015942DB: mov rbx, qword ptr [r14 + 0x248]
  015942E2: call 0x7ff687e8b890
  015942E7: mov qword ptr [rbp + 0x30], rax
  015942EB: mov qword ptr [rbp + 0x20], r12
  015942EF: mov qword ptr [rbp + 0x10], 0
  015942F7: mov qword ptr [rbp + 0x18], r12
  015942FB: mov qword ptr [rbp + 0x28], 0
  01594303: lea rdx, [rip + 0x5942136]
  0159430A: lea rcx, [rbp - 0x80]
  0159430E: call 0x7ff68645d950
  01594313: movaps xmm0, xmmword ptr [rbp - 0x80]
  01594317: movdqa xmmword ptr [rbp - 0x50], xmm0
  0159431C: lea r9, [rbp + 0x10]
  01594320: lea r8, [rbp - 0x50]
  01594324: mov edx, edi
  01594326: mov rcx, rbx
  01594329: call 0x7ff68645dab0
  0159432E: nop 
  0159432F: lea rcx, [rbp + 0x10]
  01594333: call 0x7ff6857f75d0
  01594338: nop 
  01594339: mov ecx, esi
  0159433B: call 0x7ff689838a10
  01594340: nop 
  01594341: mov rax, r14
  01594344: mov rcx, qword ptr [rbp + 0x58]
  01594348: xor rcx, rsp
  0159434B: call 0x7ff68aa271c0
  01594350: mov rbx, qword ptr [rsp + 0x1b0]
  01594358: add rsp, 0x160
  0159435F: pop r15
  01594361: pop r14
  01594363: pop r13
  01594365: pop r12
  01594367: pop rdi
  01594368: pop rsi
  01594369: pop rbp
  0159436A: ret 
