bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf, calc_result               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

import printf msvcrt.dll
import scanf msvcrt.dll
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a resb 1
    b resb 1
    c resb 1
    result resb 12
    format_signed db "%d", 0
    message_a_format db "a=", 0
    message_b_format db "b=", 0
    message_c_format db "c=", 0
    
; our code starts here
segment code use32 class=code
    start:
        push message_a_format
        call [printf]
        add esp, 4 * 1
        
        push dword a
        push dword format_signed
        call [scanf]
        add esp, 4 * 2
        
        
        push message_b_format
        call [printf]
        add esp, 4 * 1
        
        push dword b
        push dword format_signed
        call [scanf]
        add esp, 4 * 2
        
        
        push message_c_format
        call [printf]
        add esp, 4 * 1
        
        push dword c
        push dword format_signed
        call [scanf]
        add esp, 4 * 2
        
        movsx eax, byte [a]
        movsx ebx, byte [b]
        movsx ecx, byte [c]
        
        push ecx 
        push ebx 
        push eax 
        call calc_result
        add esp, 4 * 3
        
        
        push eax
        push format_signed
        call [printf]
        add esp, 4 * 1
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
