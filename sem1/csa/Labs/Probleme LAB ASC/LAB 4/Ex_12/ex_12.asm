bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Given the words A and B, compute the doubleword C as follows:


segment data use32 class=data
    c resd 1
    a dw 0110101101b
    b dw 01101011101010b
    
segment code use32 class=code
    start:
        mov byte [c], 0 ; the bits 0-6 of C have the value 0
        
        mov ax, [a]
        and ax, 111b
        shl ax, 7
        or word [c], ax ; the bits 7-9 of C are the same as the bits 0-2 of A
        
        mov ax, [b]
        shr ax, 8
        and ax, 111111b
        shl ax, 10
        or word [c], ax ; the bits 10-15 of C are the same as the bits 8-13 of B
        
        mov word [c + 2], -1 ; the bits 16-31 of C have the value 1
       
       ; c has the representaiton 80 6A FF FFh (in memory according to little-endian repres.)
       
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
