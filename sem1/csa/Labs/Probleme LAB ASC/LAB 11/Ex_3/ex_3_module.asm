bits 32 
global calc_decimal_concat

segment data use32 class=data
    digit_concat_result resb 101
    char_concat_result resb 101
segment code use32 class=code
    calc_decimal_concat:
        mov esi, [esp + 4] ; first string in esi
        mov edi, [esp + 8] ; second string in edi
        
        mov ecx, 0
        mov edx, 0
        parse_second_string:
            mov al, [edi + ecx]
            cmp al, 0
            je second_string_parsed
            
            cmp al, '0'
                jb not_digit_1
                
            cmp al, '9'
                ja not_digit_1
            
            mov [digit_concat_result + edx], al
            inc edx
            
            not_digit_1: 
                inc ecx
                jmp parse_second_string
        
        second_string_parsed:
        
        mov ecx, 0
        parse_first_string:
            mov al, [esi + ecx]
            cmp al, 0
            je first_string_parsed
            
            cmp al, '0'
                jb not_digit
                
            cmp al, '9'
                ja not_digit
            
            mov [digit_concat_result + edx], al
            inc edx
            
            not_digit: 
                inc ecx
                jmp parse_first_string
        
        first_string_parsed:
        
        mov eax, digit_concat_result
        ret