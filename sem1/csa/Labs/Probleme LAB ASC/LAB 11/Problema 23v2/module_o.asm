bits 32 
segment data use32 class=data
segment code use32 public code
global convert
    convert:
        mov ebx,[esp+4]
        mov edi,[esp+8]
        mov esi,[esp+12]
        
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
        ret
