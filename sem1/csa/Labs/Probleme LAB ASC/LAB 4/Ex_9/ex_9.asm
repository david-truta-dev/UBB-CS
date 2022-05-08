bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Given the word A and the byte B, compute the doubleword C as follows:
; the bits 0-3 of C are the same as the bits 6-9 of A
; the bits 4-5 of C have the value 1
; the bits 6-7 of C are the same as the bits 1-2 of B
; the bits 8-23 of C are the same as the bits of A
; the bits 24-31 of C are the same as the bits of B

segment data use32 class=data
    c resd 1
    a dw 100010010110b
    b db 110b
    
segment code use32 class=code
    start:
        
        mov ax, [a]
        shr ax, 6
        and al, 1111b
        mov byte [c], al ; the bits 0-3 of C are the same as the bits 6-9 of A
        
        or byte [c], 110000b ; the bits 4-5 of C have the value 1
        
        mov al, [b]
        shr al, 1
        and al, 11b
        shl al, 6
        or byte [c], al ; the bits 6-7 of C are the same as the bits 1-2 of B
        
        mov ax, [a]
        mov word [c + 1], ax ; the bits 8-23 of C are the same as the bits of A
        
        mov al, [b]
        mov byte [c + 3], al ; the bits 24-31 of C are the same as the bits of B
        
        ; c has the representaiton F2 96 08 06h (in memory according to little-endian repres.)
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
