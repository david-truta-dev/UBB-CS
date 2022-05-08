bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll   

;Two byte strings S1 and S2 are given, having the same length. Obtain the string D in the following way: each element found on the even positions of D is the sum of the corresponding elements from S1 and S2, and each element found on the odd positions of D is the difference of the corresponding elements from S1 and S2
segment data use32 class=data
    s1 db 1, 2, 3, 4
    s2 db 5, 6, 7, 8
    common_len equ $ - s2
    d resb common_len
    
segment code use32 class=code
    start:
        mov ecx, 0 ; ecx - is a general index for parsing the s string
        
        while_ecx_smaller_than_common_len:
            cmp ecx, common_len
            je fin
            
            mov al, [s1 + ecx]
            
            test ecx, 1
            jz odd_position
            ; if it's not 0 the the position is even (the counting of elements start from 1)
                sub al, [s2 + ecx]
                jmp fin_of_while
            
            odd_position:
                add al, [s2 + ecx]
                
            fin_of_while:
                mov [d + ecx], al
                
                inc ecx
                jmp while_ecx_smaller_than_common_len
            
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
