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
    ;#26
    ;A byte string S is given. Obtain the maximum of the elements found on the even positions and the minimum of the elements found on the odd positions of S.
    s db 1, 4, 2, 3, 8, 4, 9, 5
    len equ ($-s)
    two db 2
    max_poz_pare db 0
    min_poz_impare db 0xFF
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, 0
        mov ecx, len
        l:
            mov eax, esi
            div byte[two]
            cmp ah, 0
            jne odd
                mov bl, [max_poz_pare]
                cmp bl, [s+esi]
                jae skip
                    mov bl, [s+esi]
                    mov [max_poz_pare],bl
                    jmp skip
            odd:
                mov bl, [min_poz_impare]
                cmp bl, [s+esi]
                jbe skip
                    mov bl, [s+esi]
                    mov [min_poz_impare],bl
            skip:   
            inc esi
        loop l    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
