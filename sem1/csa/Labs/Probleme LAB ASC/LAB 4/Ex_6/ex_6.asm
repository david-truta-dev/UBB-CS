bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll  

; Given the word A, obtain the integer number n represented on the bits 0-2 of A. Then obtain the word B by rotating A n positions to the right. Compute the doubleword C:
; the bits 8-15 of C have the value 0
; the bits 16-23 of C are the same as the bits of 2-9 of B
; the bits 24-31 of C are the same as the bits of 7-14 of A
; the bits 0-7 of C have the value 1
segment data use32 class=data
    c resd 1
    a dw 101010010000110b
    b resw 1 ; 0001100101010010 - 52 19h
    n resb 1
segment code use32 class=code
    start:
        mov al, [a]
        and al, 111b
        mov byte [n], al
        
        mov cl, [n]
        mov ax, [a]
        ror ax, cl
        mov word [b], ax ;obtain the word B
        
        mov byte [c + 1], 0 ; the bits 8-15 of C have the value 0
        
        mov ax, [b]
        shr ax, 2
        mov byte [c + 2], al ; the bits 16-23 of C are the same as the bits of 2-9 of B
        
        mov ax, [a]
        shr ax, 7
        mov byte [c + 3], al ; the bits 24-31 of C are the same as the bits of 7-14 of A
        
        
        mov byte [c], -1 ; the bits 0-7 of C have the value 1
        
        ; c has the representaiton FF 00 54 A9h (in memory according to little-endian repres.)
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
