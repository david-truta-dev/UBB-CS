bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               
import exit msvcrt.dll    

; Two character strings S1 and S2 are given. Obtain the string D by concatenating the elements found on even positions in S2 and the elements found on odd positions in S1.
segment data use32 class=data
    s1 db 'a', 'b', 'c', 'd', 'e', 'f'
    len_s1 equ $ - s1
    s2 db '1', '2', '3', '4', '5'
    len_s2 equ $ - s2
    separator db -1
    d resb len_s1 + len_s2
segment code use32 class=code
    start:
        mov ebx, 0 ; ebx will point tot the last free element from string d
        
        mov ecx, 1
        parse_s2:
            cmp ecx, len_s2
            jae fin_of_parsing_of_s2
            
            mov al, [s2 + ecx]
            mov [d + ebx], al
            inc ebx
            
            add ecx, 2
            jmp parse_s2
            
        fin_of_parsing_of_s2:
        
        mov ecx, 0
        parse_s1:
            cmp ecx, len_s1
            jae fin_of_parsing_of_s1
            
            mov al, [s1 + ecx]
            mov [d + ebx], al
            inc ebx
            
            add ecx, 2
            jmp parse_s1
            
        fin_of_parsing_of_s1:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
