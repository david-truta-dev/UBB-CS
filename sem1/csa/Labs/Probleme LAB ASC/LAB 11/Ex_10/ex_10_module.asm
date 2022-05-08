bits 32 
global check_subsequence
extern first_string, current_string 

segment data use32 class=data
    
segment code use32 class=code
  check_subsequence:
    mov ecx, 0 ; index for parsing the current_string
    mov esi, 0
    
    parse_current_string:
        mov edx, 0 ; index for parsing the first_string
        mov al, [current_string + ecx]
        cmp al, 0
        jz end_of_parsing
        
        parse_first_string:
            mov al, [current_string + ecx + edx]
            mov bl, [first_string + edx]
            
            cmp bl, 0
            je is_local_subseq
            
            cmp al, bl
            jnz is_not_local_subseq
            
            inc edx
            jmp parse_first_string
        
        is_local_subseq:
            mov esi, 1
            jmp end_of_parsing
            
        is_not_local_subseq:
            inc ecx
            jmp parse_current_string
            
    end_of_parsing:
        mov eax, esi
        ret