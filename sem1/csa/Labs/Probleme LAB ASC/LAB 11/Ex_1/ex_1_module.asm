bits 32
extern a, string_permutated, final_string
global circular_permutation
segment data use32 class=data

    
segment code use32 class=code
    circular_permutation:
    mov ecx, 0
    mov esi, 0
    while_number:
        cmp ecx, 4
        je fin_of_while
    
    
        mov al, [a + ecx]
        cmp al,0
        je fin_of_while
        
        mov bl, al
        
        and al, 1111b ; al - right digit
        and bl, 11110000b ; bl - left digit
        shr bl, 4
        
        cmp ecx, 0
        jne go_forward
        
        mov dl, al ; this is the digit which should dissapear
        cmp bl, 10
        jb is_digit
        
        sub bl, 10
        add bl, 'A'
        jmp concat
        
        is_digit:
        add bl, '0'
        
        concat:
        mov [string_permutated + esi], bl
        
        inc esi
        inc ecx
        jmp while_number
        
        go_forward:
            cmp al, 10
            jb is_digit_1
        
            sub al, 10
            add al, 'A'
            jmp concat_1
        
            is_digit_1:
            add al, '0'
        
            concat_1:
                mov [string_permutated + esi], al
                inc esi
            
            cmp bl, 10
            jb is_digit_2
        
            sub bl, 10
            add bl, 'A'
            jmp concat_2
        
            is_digit_2:
            add bl, '0'
            
            concat_2:
                mov [string_permutated + esi], bl
                inc esi
                inc ecx
                jmp while_number
        
        
    fin_of_while:
            cmp dl, 10
            jb is_digit_3
        
            sub dl, 10
            add dl, 'A'
            jmp concat_3
        
            is_digit_3:
            add dl, '0'
        
            concat_3:
        mov [string_permutated + esi], dl
        mov ecx, esi
        
        revert_string:
            mov al, [string_permutated + ecx]
            
            mov edx, esi
            sub edx, ecx
            
            mov [final_string + edx], al
            
            loop revert_string
        
        mov al, [string_permutated]
        mov [final_string + esi], al
        
        ret
    
    
    
        
    