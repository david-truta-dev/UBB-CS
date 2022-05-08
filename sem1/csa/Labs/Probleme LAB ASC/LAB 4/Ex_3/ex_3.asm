bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is 


; Given the words A and B, compute the doubleword C as follows:
; the bits 0-2 of C are the same as the bits 12-14 of A
; the bits 3-8 of C are the same as the bits 0-5 of B
; the bits 9-15 of C are the same as the bits 3-9 of A
; the bits 16-31 of C are the same as the bits of A
segment data use32 class=data

        c resd 1
        a dw 101001001001000b
        b dw 01010b
        
segment code use32 class=code
    start:
        mov bx, [a]
        
        mov ax, [a]
        shr ax, 12
        and ax, 111b
        mov [c], ax ; the bits 0-2 of C are the same as the bits 12-14 of A
        
        mov ax, [b]
        and ax, 11111b
        shl ax, 3
        or [c], ax ; the bits 3-8 of C are the same as the bits 0-5 of B
        
        mov ax, [a]
        shr ax, 3
        and ax, 1111111b
        shl ax, 9
        or [c], ax
        
        mov [c + 2], bx
            
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
