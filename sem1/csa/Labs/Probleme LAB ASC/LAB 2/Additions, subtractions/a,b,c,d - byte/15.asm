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
    a db 1
    b db 2
    c db 3
    d db 1

; our code starts here
segment code use32 class=code
    start:
        ; 15. a-b-d+2+c+(10-b)
        
        ; a-b-d+2+c
        mov al, [a]
        sub al, [b]
        sub al, [d]
        add al, 2
        add al, [c]
        
        ; (10-b)
        mov bl, 10
        sub bl, [b]
        
        ; the final result is 11 = Bh in al
        add al, bl
         
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
