bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Two byte string S1 and S2 are given, having the same length. Obtain the string D by intercalating the elements of the two strings
segment data use32 class=data
    s1 db 1, 3, 5, 7
    s2 db 2, 6, 9, 4
    common_len equ $ - s2
    separator db -1
    len_of_d equ common_len * 2
    d resb len_of_d
    
segment code use32 class=code
    start:
        mov esi, s1
        mov edi, s2
        mov ecx, 0 
        
        while_ecx_smaller_than_len_of_d:
            cmp ecx, len_of_d
            je fin
        
            mov al, [esi]
            mov [d + ecx], al
            
            mov al, [edi]
            mov [d + ecx + 1], al
            
            inc esi
            inc edi
            add ecx, 2
            jmp while_ecx_smaller_than_len_of_d
            
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
