bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll   

; A character string S is given. Obtain the string D that contains all capital letters of the string S
segment data use32 class=data
    s db 'a', 'A', 'b', 'B', '2', '%', 'x', 'M'
    len_of_s equ $ - s
    separator db -1
    d resb len_of_s
    
segment code use32 class=code
    start:
        mov ecx, 0
        mov ebx, 0
        
        while_ecx_smaller_than_len_of_s:
            cmp ecx, len_of_s
            je fin
        
            mov al, [s + ecx]
            
            cmp al, 'A'
            jb fin_of_while
            
            cmp al, 'Z'
            ja fin_of_while
            
            mov [d + ebx], al
            inc ebx
            
            fin_of_while:
                inc ecx
                jmp while_ecx_smaller_than_len_of_s
            
        fin:    
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
