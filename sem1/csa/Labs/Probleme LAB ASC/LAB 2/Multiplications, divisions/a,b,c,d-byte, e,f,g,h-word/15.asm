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
    d db 6
    e dw 5
    f dw 1
; our code starts here
segment code use32 class=code
    start:
        ; 15. f*(e-2)/[3*(d-5)]
        
        ; f*(e-2)
        mov ax, [e]
        sub ax, 2
        mul byte [f]
        
        ; 3*(d-5)
        mov bx, ax
        mov ax, [d]
        sub ax, 5
        mov cx, 3
        mul cx
        
        ; f*(e-2)/[3*(d-5)]
        ; the final result is 1 in ax
        mov cx, ax
        mov ax, bx
        mov bx, cx
        div bl
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
