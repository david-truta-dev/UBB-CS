bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               
import exit msvcrt.dll   

; A byte string S is given. Obtain the string D1 which contains the elements found on the even positions of S and the string D2 which contains the elements found on the odd positions of S. 
; Observation: the example from mr. Vancea's website has a mistake, which is the first string is with the odd positions and the second one with even, not like in the example
segment data use32 class=data
    s db 1, 5, 3, 8, 2, 9
    len_s equ $ - s
    separator_1 db -1
    d1 resb len_s
    separator_2 db -1
    d2 resb len_s
    
segment code use32 class=code
    start:
        mov ecx, 1
        mov ebx, 0
        
        parse_s_on_even_position:
            cmp ecx, len_s
            jae fin_of_parsing_for_even
        
            mov al, [s + ecx]
            mov [d1 + ebx], al
            
            inc ebx
            add ecx, 2
            jmp parse_s_on_even_position
            
        fin_of_parsing_for_even:
        
        mov ecx, 0
        mov ebx, 0
        
        parse_s_on_odd_position:
            cmp ecx, len_s
            jae fin_of_parsing_for_odd
        
            mov al, [s + ecx]
            mov [d2 + ebx], al
            
            inc ebx
            add ecx, 2
            jmp parse_s_on_odd_position
            
        fin_of_parsing_for_odd:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
