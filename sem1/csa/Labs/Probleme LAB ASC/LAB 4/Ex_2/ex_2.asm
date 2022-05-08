bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; Given the words A and B, compute the doubleword C as follows:
; the bits 0-3 of C are the same as the bits 5-8 of B
; the bits 4-8 of C are the same as the bits 0-4 of A
; the bits 9-15 of C are the same as the bits 6-12 of A
; the bits 16-31 of C are the same as the bits of B
segment data use32 class=data
    c resd 1
    a dw  100011010100b
    m db 0x11
    b dw  111100000b
    
    
segment code use32 class=code
    start:
        mov bx, word [b]
        
        shr word [b], 5
        and word [b], 1111b
        mov ax, [b]
        mov word [c], ax ; the bits 0-3 of C are the same as the bits 5-8 of B
        
        mov ax, [a]
        and ax, 11111b
        shl ax, 4
        or word [c], ax ; the bits 4-8 of C are the same as the bits 0-4 of A
        
        shr word [a], 6
        and word [a], 1111111b
        shl word [a], 9
        mov ax, word [a]
        or word [c], ax ; the bits 9-15 of C are the same as the bits 6-12 of A
         
        mov word [c + 2], bx ; the bits 16-31 of C are the same as the bits of B
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
