bits 32 
global start        

extern exit, scanf, printf, transform_to_binary         
import exit msvcrt.dll    
import scanf msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    decimal_format db "%d", 0
    hex_format db "The hex value of thin number is: %x, the binary value is: ", 0
    new_number dd 0
segment code use32 class=code
    start:
        read_numbers_until_0:
            push new_number
            push decimal_format
            call [scanf]
            add esp, 4 * 2
            
            cmp dword [new_number], 0
            je fin
            
            push dword [new_number]
            push hex_format
            call [printf]
            add esp, 4 * 2
            
            push dword [new_number]
            call transform_to_binary
            add esp, 4 * 1
            
            mov ecx, 0
            while_not_end:
               mov ebx, 0 
               mov bl, [eax + ecx]
               cmp bl, 2
               je read_numbers_until_0
               
               push ebx
               push decimal_format
               call [printf]
               
               jmp while_not_end
                
        fin:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
