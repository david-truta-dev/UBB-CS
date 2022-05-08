bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Given the words A and B, compute the doubleword C:
; the bits 0-4 of C have the value 1
; the bits 5-11 of C are the same as the bits 0-6 of A
; the bits 16-31 of C have the value 0000000001100101b
; the bits 12-15 of C are the same as the bits 8-11 of B
segment data use32 class=data
    c resd 1
    a dw 1001101b
    b dw 001101010101b
    
    
segment code use32 class=code
    start:
        or byte [c], 11111b ; the bits 0-4 of C have the value 1
        
        mov ax, [a]
        and ax, 1111111b
        shl ax, 5
        or word [c], ax ; the bits 5-11 of C are the same as the bits 0-6 of A
        
        mov word [c + 2], 0000000001100101b ; the bits 16-31 of C have the value 0000000001100101b
        
        
        mov ax, [b]
        shr ax, 8
        and ax, 1111b
        shl ax, 12
        or word [c], ax ; the bits 12-15 of C are the same as the bits 8-11 of B
        
        ; c has the representaiton BF 39 65 00h (in memory according to little-endian repres.)
        
        
       
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
