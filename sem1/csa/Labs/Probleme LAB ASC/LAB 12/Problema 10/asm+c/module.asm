bits 32
global _is_subsequence
extern _printf
segment data public data use32
segment code public code use32
_is_subsequence:
	push ebp
	mov ebp,esp  
    
    mov ebx,[ebp+12] ; address of current seq
    mov edi,[ebp+8] ; address of first seq
    
    xor ecx,ecx
    xor edx,edx
    current_loop:
    
    ;mov esi,[ebx+ecx] ;!!! THIS IS NOT AN ADDRESS
    lea esi,[ebx+ecx]

    mov edi,[ebp+8]
    cmp byte [esi],0
    je done_parsing
    
        first_seq:
            cmp byte [edi],0
            je found
            
            cmp byte [esi],0
            je done_parsing
            
            mov al,[esi]
            cmp al,[edi]
            jne cont_search
            
            inc esi
            inc edi
        jmp first_seq
        
    cont_search:
    inc ecx
    jmp current_loop
    
    found:
        mov edx,1
        
        
    done_parsing:
    mov eax,edx
    
    mov esp, ebp
    pop ebp
    ret
    