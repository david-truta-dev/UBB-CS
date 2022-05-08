bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; A byte string S of length l is given. Obtain the string D of length l-1 so that the elements of D represent the difference between every two consecutive elements of S.
segment data use32 class=data
    s db 1, 2, 4, 6, 10, 20, 25
    len_s equ $ - s
    separator db -1
    d resb len_s - 1
    
segment code use32 class=code
    start:
        mov ecx, 0
        
        while_ecx_smaller_than_len_s_minus_1:
            cmp ecx, len_s - 1
            je fin
            
            mov al, [s + ecx + 1]
            sub al, [s + ecx]
            
            mov [d + ecx], al
            inc ecx
            jmp while_ecx_smaller_than_len_s_minus_1
            
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
