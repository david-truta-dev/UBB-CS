bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        


extern exit               
import exit msvcrt.dll   

; Given the words A and B, compute the doubleword C as follows:
; the bits 0-4 of C are the same as the bits 11-15 of A
; the bits 5-11 of C have the value 1
; the bits 12-15 of C are the same as the bits 8-11 of B
; the bits 16-31 of C are the same as the bits of A
segment data use32 class=data
    ; a has 16 bits
    c resd 1
    a dw 0101010000000000b
    b dw 0000010110000000b
    
; our code starts here
segment code use32 class=code
    start:
        mov ax, [a] ; the bits 16-31 of C are the same as the bits of A
        shr word [a], 11
        and byte [a], 00011111b
        mov bl, [a]
        mov byte [c], bl
        or word [c], 111111100000b
        shr word [b], 8 
        and word [b], 1111b
        shl word [b], 12
        mov bx, word [b]
        or word [c], bx
        mov word [c + 2], ax
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
