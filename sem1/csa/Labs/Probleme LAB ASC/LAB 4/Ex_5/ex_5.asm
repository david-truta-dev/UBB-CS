bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               
import exit msvcrt.dll    

; Given the bytes A and B, compute the doubleword C as follows:
; the bits 16-31 of C have the value 1
; the bits 0-3 of C are the same as the bits 3-6 of B
; the bits 4-7 of C have the value 0
; the bits 8-10 of C have the value 110
; the bits 11-15 of C are the same as the bits 0-4 of A

segment data use32 class=data
    a db 00110b
    b db 1010000b
    c resd 1
segment code use32 class=code
    start:
        mov word [c + 2], -1 ; the bits 16-31 of C have the value 1
        
        mov al, [b]
        shr al, 3
        and al, 1111b
        mov byte [c], al ; the bits 0-3 of C are the same as the bits 3-6 of B
        
        and byte [c], 00001111b ; the bits 4-7 of C have the value 0
        
        or word [c], 11000000000b
        and byte [c + 1],   0xFE  ; the bits 8-10 of C have the value 110
        
        mov ax, 0
        mov al, [a]
        and al, 11111b
        shl ax, 11
        or byte [c + 1], ah ;the bits 11-15 of C are the same as the bits 0-4 of A
        
        ; c has the representaiton 0A 36 FF FFh (in memory according to little-endian repres.)
        
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
