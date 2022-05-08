bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               
import exit msvcrt.dll    

;A byte string S is given. Obtain the string D1 which contains all the positive numbers of S and the string D2 which contains all the negative numbers of S
segment data use32 class=data
    s db 1, 3, -2, -5, 3, -8, 5, 0
    len_s equ $ - s
    separator_1 db 0
    d1 resb len_s
    separator_2 db 0
    d2 resb len_s
    
segment code use32 class=code
    start:
        mov ecx, 0
        mov ebx, 0
        
        parse_s_for_positive_numbers:
            cmp ecx, len_s
            je fin_of_parse_for_positive
            
            mov al, [s + ecx]
            cmp al, 0
            jl last_command_of_parse_for_positive
            
            mov [d1 + ebx], al
            inc ebx
            
            last_command_of_parse_for_positive:
                inc ecx
                jmp parse_s_for_positive_numbers
                
        fin_of_parse_for_positive:
        
        
        
        mov ecx, 0
        mov ebx, 0
        
        parse_s_for_negative_numbers:
            cmp ecx, len_s
            je fin_of_parse_for_negative
            
            mov al, [s + ecx]
            cmp al, 0
            jg last_command_of_parse_for_negative
            
            mov [d2 + ebx], al
            inc ebx
            
            last_command_of_parse_for_negative:
                inc ecx
                jmp parse_s_for_negative_numbers
                
        fin_of_parse_for_negative:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
