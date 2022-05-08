bits 32
global convert_in_base_8, number_in_base_8, length_of_number
segment data use32 class=data
    number_in_base_8 resb 50
    length_of_number resb 1
segment code use32 class=code
    convert_in_base_8:
        mov eax, [esp + 4]
        mov esi, number_in_base_8
        mov dl, 8
        
        while_ah_bigger_than_0:
            cmp ah, 0
            jz fin_of_while
        
            div dl
            ;ah = number / 8, al = number % 8
            mov byte [esi], al
            inc esi
            mov al, ah
            mov ah, 0
            add byte [length_of_number], 1
            
            jmp while_ah_bigger_than_0
            
        fin_of_while:
        ret
