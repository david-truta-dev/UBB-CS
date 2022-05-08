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
    ;a db '2', '1', '-3', '0'
    ;b db '4', '5', '7', '6', '2', '1'
    a db 2, 1, -3, 0
    la equ $-a
    b db 4, 5, 7, 6, 2, 1
    lb equ $-b
    r resb lb+la

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;Two byte strings A and B are given. 
        ;Obtain the string R by concatenating the elements of B in reverse order and the elements of A in reverse order.
        ;Example:
        ;A: 2, 1, -3, 0
        ;B: 4, 5, 7, 6, 2, 1
        ;R: 1, 2, 6, 7, 5, 4, 0, -3, 1, 2
        ; ...
        
        
        mov ebx, lb
        sub ebx, 1
        mov esi, 0
        
        mov ecx, lb
        jecxz End_b
        loop_b:
            mov al, [b+ebx]
            mov [r+esi], al
            inc esi
            dec ebx
        loop loop_b
        End_b:
        
        
        mov ebx, la
        sub ebx, 1
        mov esi, 0
        
        mov ecx, la
        jecxz End_a
        loop_a:
            mov al, [a+ebx]
            mov [r+esi+lb], al
            inc esi
            dec ebx
        loop loop_a
        End_a:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
