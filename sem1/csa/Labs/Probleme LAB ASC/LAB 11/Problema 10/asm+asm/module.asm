bits 32
global is_subsequence
extern printf
segment data use32 class=data

segment code use32 public code


is_subsequence:
    mov ebx,[esp+8] ; address of current seq
    mov edi,[esp+4] ; address of first seq
    
    xor ecx,ecx
    xor edx,edx
    current_loop:
    
    ;mov esi,[ebx+ecx] ;!!! THIS IS NOT AN ADDRESS
    lea esi,[ebx+ecx]

    mov edi,[esp+4]
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
    ret