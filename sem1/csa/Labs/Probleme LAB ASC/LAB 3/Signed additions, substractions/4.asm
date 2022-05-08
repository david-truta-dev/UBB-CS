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
    ; a - byte, b - word, c - double word, d - qword - Signed representation
    a db 22 
    b dw 10645 
    c dd 21 
    d dq 21174 

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; (b+b)-c-a-d
        ; result = 73 = 49h 
        
        ;(b+b)
        mov ax, [b]
        cwde
        mov bx, ax
        mov ax, [b]
        cwde
        add ax, bx
        mov bx, ax
        ;(b+b)-c
        sub eax, [c]
        mov ebx, eax
        ;(b+b)-c-a
        mov al, [a]
        cbw
        cwde
        sub ebx, eax
        mov eax, ebx
        ;(b+b)-c-a-d
        cdq
        sub eax, dword[d]
        sbb edx, dword[d+4]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the programf