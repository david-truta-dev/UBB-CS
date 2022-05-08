bits 32 

global start        

extern exit, convert_in_base_8, number_in_base_8, length_of_number, printf           
import exit msvcrt.dll   
import printf msvcrt.dll   
segment data use32 class=data
   format_print_decimal db "%d", 0
   format_new_line db 10, 0
segment code use32 class=code
    start:
        mov ebx, 0 
        mov bl, 32
        while_al_smaller_than_127:
        
            cmp bl, 127
            jz fin_of_while
            
            push ebx
            call convert_in_base_8
            add esp, 4 * 1
            
            mov esi, number_in_base_8
            
            mov ecx, 0
            mov cl, [length_of_number]
            dec cl
            
            while_we_have_digits:
                
                push number_in_base_8
                push format_print_decimal
                add esp, 4 * 2 
                
                mov eax, 0
                mov al, [number_in_base_8 + ecx]
                
                push eax
                push format_print_decimal
                call [printf]
                add esp, 4 * 2 
                
                loop while_we_have_digits
                
                
            push format_new_line
            call [printf]
            
            inc bl
            jmp while_al_smaller_than_127
        
        fin_of_while:
        push    dword 0      
        call    [exit]      
