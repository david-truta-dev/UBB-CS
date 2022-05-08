bits 32
global concatenate_string
extern concat_string_final
segment data use32 class=data
    
segment code use32 class=code
    concatenate_string:
        mov esi, [esp + 4] ; string1
        mov ecx, 0
        
        while_byte_esi_differ_from_0:
        
            mov dl, byte [esi + ecx]
            cmp dl, 0
            je fin_of_while
            
            mov byte [concat_string_final + ebx], dl
            inc ecx
            inc ebx
            jmp while_byte_esi_differ_from_0
            
        fin_of_while:  
        ret