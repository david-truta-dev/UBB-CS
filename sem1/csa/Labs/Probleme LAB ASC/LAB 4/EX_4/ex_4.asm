bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll   


;Given the byte A, obtain the integer number n represented on the bits 2-4 of A. Then obtain the byte B by rotating A n positions to the right. Compute the doubleword C as follows:
;the bits 0-7 of C have the value 1
;the bits 8-15 of C have the value 0
;the bits 16-23 of C are the same as the bits of B
;the bits 24-31 of C are the same as the bits of A

segment data use32 class=data
    c resd 1
    a db 10100101b ; A5h
    n resb 1 
    b resb 1 ; 5 pos rotated a to right will be: D2
    
; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        shr al, 2
        and al, 111b
        mov [n], al
        
        mov cl, [n]
        mov al, [a]
        ror al, cl
        mov [b], al
        
        mov byte [c], 11111111b
        mov byte [c + 1], 0
        mov al, [b]
        mov [c + 2], al
        mov al, [a]
        mov [c + 3], al
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
