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

    
    
    
    
    a db 2,1,-3,3,-4,2,6
    len_a equ $-a
    
    b db 4,5,7,6,2,1
    len_b equ $-b
    
    r resb len_b
    
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
    ;Two byte strings A and B are given. 
    ;Obtain the string R by concatenating the elements of B in reverse order and the negative elements of A.
    ;A: 2, 1, -3, 3, -4, 2, 6
    ;B: 4, 5, 7, 6, 2, 1
    ;R: 1, 2, 6, 7, 5, 4, -3, -4
        
    mov esi, b + len_b - 1
    mov edi, r
    
    mov ecx, len_b ; store the length of the string b
    jecxz fin ; skip if ecx is 0
    
    first_loop:
        mov al, [esi]
        mov [edi], al
        
        inc edi
        dec esi
    loop first_loop
    
    fin:
    
    mov esi, a 
    mov ecx, len_a
    jecxz fin2
    
    second_loop:
        mov al, [esi]
        
        cmp al, 0
        jnl skip
        
        mov [edi], al
        inc edi
        
        skip:
        
        inc esi
    loop second_loop
    
    fin2:
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
