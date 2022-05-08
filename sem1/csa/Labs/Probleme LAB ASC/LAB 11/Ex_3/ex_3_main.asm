bits 32
global start        


extern exit, calc_decimal_concat, printf, scanf                
import exit msvcrt.dll   

import printf msvcrt.dll
import scanf msvcrt.dll


;I did only for decimal concat bcs for the other is the same but conditions are negated
segment data use32 class=data
    format_string db "%s",0
    string_1 resb 101
    string_2 resb 101
    

segment code use32 class=code
    start:
        push dword string_1
        push dword format_string
        call [scanf]
        add esp, 4 * 2
        
        push dword string_2
        push dword format_string
        call [scanf]
        add esp, 4 * 2
        
        push string_1
        push string_2
        call calc_decimal_concat
        add esp, 4 * 2
        
        push eax
        push format_string
        call [printf]
        add esp, 4 * 2
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
