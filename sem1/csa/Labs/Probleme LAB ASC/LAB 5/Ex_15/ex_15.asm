bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll   

; Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the odd elements of A
segment data use32 class=data
    a db  2, 1, 3, 3, 4, 2, 6
    len_a equ $ - a
    b db  4, 5, 7, 6, 2, 1
    len_b equ $ - b
    separator db -1
    r resb len_a + len_b
segment code use32 class=code
    start:
        mov ebx, 0
        
        mov esi, b
        add esi, len_b - 1
        
        mov ecx, len_b
        std
        
        parse_string_b_in_reverse_order:
            lodsb ; move the byte from DS:ESI into AL
            
            mov [r + ebx], al
            
            inc ebx
            loop parse_string_b_in_reverse_order
        
        mov ecx, 0
        parse_string_a_for_odd_elements:
            cmp ecx, len_a
            je fin
            
            mov al, [a + ecx]
            test al, 1
            jz last_command_of_parse_for_odd
            
            mov [r + ebx], al
            inc ebx
            
            last_command_of_parse_for_odd:
            inc ecx
            jmp parse_string_a_for_odd_elements
        
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
