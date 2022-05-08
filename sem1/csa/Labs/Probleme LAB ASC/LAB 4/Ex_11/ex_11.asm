bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Given the byte A and the word B, compute the byte C as follows:
; the bits 0-3 are the same as the bits 2-5 of A
; the bits 4-7 are the same as the bits 6-9 of B.
segment data use32 class=data
    c resb 1
    a db 11100110b
    b dw 1111010101110b
segment code use32 class=code
    start:
        mov al, [a]
        shr al, 2
        and al, 1111b
        or byte [c], al ; the bits 0-3 are the same as the bits 2-5 of A
        
        mov ax, [b]
        shr ax, 6
        and ax, 1111b
        shl ax, 4
        or byte [c], al ; the bits 4-7 are the same as the bits 6-9 of B.
        
        ; c has the value A9h
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
