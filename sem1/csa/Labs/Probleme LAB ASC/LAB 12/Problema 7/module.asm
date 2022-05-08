bits 32
global _get_prefix
extern _printf
segment data public data use32
segment code public code use32


_get_prefix:
	push ebp
	mov ebp,esp  
    
    mov esi,[ebp+8] ; address of first string
    mov edx,[ebp+12] ; address of second string
    mov edi,[ebp+16] ; address of result string
    
    xor ebx,ebx
    start_comparing:
        lodsb       ; al=el of first string
        cmp al,[edx]    ; [edx] = el of second string
        jne go_on       ; found a difference
            mov ebx,1   ; mark that we have a prefix
            stosb   ; the elements are equal so we store them in result
        inc edx
    jmp start_comparing
    go_on:
        
    mov al,0
    stosb
    mov eax,ebx ;returns 1 if we have a prefix; else 0
    
    mov esp, ebp
    pop ebp
    ret
    