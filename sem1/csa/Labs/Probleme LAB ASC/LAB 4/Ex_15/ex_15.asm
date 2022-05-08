bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               
import exit msvcrt.dll    

; Given the words A and B, compute the doubleword C as follows:
; the bits 0-2 of C have the value 0
; the bits 3-5 of C have the value 1
; the bits 6-9 of C are the same as the bits 11-14 of A
; the bits 10-15 of C are the same as the bits 1-6 of B
; the bits 16-31 of C have the value 1
segment data use32 class=data
   c resd 1
   a dw 0xA800
   b dw 0110010b
  
segment code use32 class=code
    start:
        and byte [c], 000b ; the bits 0-2 of C have the value 0
        or byte [c], 111000b ; the bits 3-5 of C have the value 1
        
        mov ax, [a]
        shr ax, 11
        and ax, 1111b
        shl ax, 6
        or word [c], ax ; the bits 6-9 of C are the same as the bits 11-14 of A
        
        mov ax, [b]
        shr ax, 1
        and ax, 111111b
        shl ax, 10
        or word [c], ax ; the bits 10-15 of C are the same as the bits 1-6 of B
        
        mov word [c + 2], -1 ; the bits 16-31 of C have the value 1

        ; c has the representaiton 78 65 FF FFh (in memory according to little-endian repres.)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
