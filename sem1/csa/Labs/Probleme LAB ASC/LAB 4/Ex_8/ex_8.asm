bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Given the words A and B, compute the byte C as follows:
; the bits 0-5 are the same as the bits 5-10 of A
; the bits 6-7 are the same as the bits 1-2 of B.

; Compute the doubleword D as follows:
; the bits 8-15 are the same as the bits of C
; the bits 0-7 are the same as the bits 8-15 of B
; the bits 24-31 are the same as the bits 0-7 of A
; the bits 16-23 are the same as the bits 8-15 of A.
segment data use32 class=data
   c resb 1
   d resd 1
   a dw 00100100000b
   b dw 0011100100000110b
segment code use32 class=code
    start:
        mov ax, [a]
        shr ax, 5
        and ax, 111111b
        mov [c], al ; the bits 0-5 are the same as the bits 5-10 of A
        
        mov ax, [b]
        shr ax, 1
        and ax, 11b
        shl ax, 6
        or [c], al ; the bits 6-7 are the same as the bits 1-2 of B.
        
        ; c has the value C9h

        
        mov al, [c]
        mov byte [d + 1], al ; the bits 8-15 are the same as the bits of C
        
        mov ax, [b]
        shr ax, 8
        mov byte [d], al ; the bits 0-7 are the same as the bits 8-15 of B
        
        mov al, [a]
        mov byte [d +3], al ; the bits 24-31 are the same as the bits 0-7 of A
        
        mov al, [a +1]
        mov byte [d +2], al ; the bits 16-23 are the same as the bits 8-15 of A.
        
        ; d has the representaiton 39 C9 01 20h (in memory according to little-endian repres.)
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
