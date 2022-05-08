bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

;Given a character string S, obtain the string D containing all special characters (!@#$%^&*) of the string S
segment data use32 class=data
    s db '+', '@', '#', '1', '@', '3', '$', '*', '!'
    len_s equ $ - s
    separator db 0xFF
    d resb len_s
segment code use32 class=code
    start:
        mov ecx, 0 ; ecx - is a general index for parsing the s string
        mov ebx, 0 ; ebx - is the index which point to the the next free element of d
        while_ecx_smaller_than_len_s:
            cmp ecx, len_s
            je fin
            
            cmp byte [s + ecx], '!'
            je add_char
            
            cmp byte [s + ecx], '@'
            je add_char
            
            cmp byte [s + ecx], '#'
            je add_char
            
            cmp byte [s + ecx], '$'
            je add_char
            
            cmp byte [s + ecx], '%'
            je add_char
            
            cmp byte [s + ecx], '^'
            je add_char
            
            cmp byte [s + ecx], '&'
            je add_char
            
            cmp byte [s + ecx], '*'
            je add_char
            
            jmp fin_of_while
            
            add_char:
                mov al, [s + ecx]
                mov [d + ebx] , al
                inc ebx
                
            fin_of_while:
                inc ecx
                jmp while_ecx_smaller_than_len_s
            
            
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
