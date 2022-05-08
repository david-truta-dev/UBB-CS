bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 3
    b db 5
    c db 1
    d dw 2

; our code starts here
segment code use32 class=code
    start:
        ; 15. (a*2)+2*(b-3)-d-2*c
        
        ; (a*2)
        mov al, [a]
		mov cl, 2
        mul cl
        
        ; 2*(b-3)
        mov bl, al
        mov al, [b]
        sub al, 3
        mul cl
        
        ; (a*2)+2*(b-3)-2*c
        add bl, al
        mov al, [c]
        mul cl
        sub bl, al
        
        ; substraction of d
        ; the final result is 6 in bx
        mov bh, 0
        sub bx, [d]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program