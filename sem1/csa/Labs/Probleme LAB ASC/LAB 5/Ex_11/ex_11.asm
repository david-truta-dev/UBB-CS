bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    


; A byte string S is given. Obtain the string D1 which contains all the even numbers of S and the string D2 which contains all the odd numbers of S.
segment data use32 class=data
    s db 1, 5, 3, 8, 2, 9
    len_s equ $ - s
    separator_1 db -1
    d1 resb len_s
    separator_2 db -1
    d2 resb len_s
    
segment code use32 class=code
    start:
        mov ecx, 0
        mov ebx, 0
        parse_s_to_search_for_even_numbers:
            cmp ecx, len_s
            je fin_of_first_parsing
            
            mov al, [s + ecx]
            test al, 1
            jz even_number
            jmp last_commands_of_first_parsing
            
            even_number:
                mov byte [d1 + ebx], al
                inc ebx
            
            last_commands_of_first_parsing:
                inc ecx
                jmp parse_s_to_search_for_even_numbers
            
        fin_of_first_parsing:
        mov edx, -1
        mov ecx, 0
        mov ebx, 0
        parse_s_to_search_for_odd_numbers:
            cmp ecx, len_s
            je fin_of_second_parsing
            
            mov al, [s + ecx]
            test al, 1
            jnz odd_number
            jmp last_commands_of_second_parsing
            
            odd_number:
                mov byte [d2 + ebx], al
                inc ebx
            
            last_commands_of_second_parsing:
                inc ecx
                jmp parse_s_to_search_for_odd_numbers
        
        fin_of_second_parsing:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
