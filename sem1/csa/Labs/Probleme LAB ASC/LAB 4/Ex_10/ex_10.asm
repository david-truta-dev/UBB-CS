bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Replace the bits 0-3 of the byte B by the bits 8-11 of the word A.

segment data use32 class=data
    b db -1
    a dw 100100000000b
    
segment code use32 class=code
    start:
        mov ax, [a]
        shr ax, 8
        and ax, 1111b
        
        and byte [b], 11110000b
        or byte [b], al
        
        ; b has the value F9h
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
