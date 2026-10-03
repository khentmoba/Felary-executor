func 0x26520A2 (pid 22196, base 0x7FF684EB0000)
  026520A2: int3 
  026520A3: int3 
  026520A4: int3 
  026520A5: int3 
  026520A6: int3 
  026520A7: int3 
  026520A8: int3 
  026520A9: int3 
  026520AA: int3 
  026520AB: int3 
  026520AC: int3 
  026520AD: int3 
  026520AE: int3 
  026520AF: int3 
  026520B0: sub rsp, 0x58
  026520B4: mov r8d, edx
  026520B7: mov rdx, rcx
  026520BA: lea rcx, [rsp + 0x20]
  026520BF: call 0x7ff687501f20
  026520C4: lea rdx, [rip + 0x56fac25]
  026520CB: lea rcx, [rsp + 0x20]
  026520D0: call 0x7ff68aa48950
  026520D5: int3 
  026520D6: int3 
  026520D7: int3 
  026520D8: int3 
  026520D9: int3 
  026520DA: int3 
  026520DB: int3 
  026520DC: int3 
  026520DD: int3 
  026520DE: int3 
  026520DF: int3 
  026520E0: mov qword ptr [rsp + 8], rbx
  026520E5: push rdi
  026520E6: sub rsp, 0x20
  026520EA: mov rbx, rdx
  026520ED: lea rax, [rip + 0x3c64bd4]
  026520F4: mov qword ptr [rcx], rax
  026520F7: lea rdx, [rcx + 8]
  026520FB: mov rdi, rcx
  026520FE: xorps xmm0, xmm0
  02652101: movups xmmword ptr [rdx], xmm0
  02652104: lea rcx, [rbx + 8]
  02652108: call 0x7ff68aa472c0
  0265210D: lea rax, [rip + 0x469cc5c]
  02652114: mov qword ptr [rdi], rax
  02652117: mov rax, qword ptr [rbx + 0x18]
  0265211B: mov qword ptr [rdi + 0x18], rax
  0265211F: mov eax, dword ptr [rbx + 0x20]
  02652122: mov rbx, qword ptr [rsp + 0x30]
  02652127: mov dword ptr [rdi + 0x20], eax
  0265212A: mov rax, rdi
  0265212D: add rsp, 0x20
  02652131: pop rdi
  02652132: ret 
