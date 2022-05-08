bits 32 
segment data use32 class=data
segment code use32 public code
global _convert
    _convert:
        
        push ebp
        mov ebp, esp   
        pushad
        
        xor eax,eax
        xor ebx,ebx
        xor ecx,ecx
        xor edx,edx
        
        mov ebx,[ebp+16]
        mov edi,[ebp+12]
        mov esi,[ebp+8]
        
        start_loop:
        cmp [esi],byte 0
        jz fin
        lodsb
        sub eax, 61h
        mov edx, ebx
        add edx, eax
        mov al, [edx]
        stosb
        jmp start_loop
        fin:
        
        popad
        mov esp, ebp
        pop ebp
        
        ret
