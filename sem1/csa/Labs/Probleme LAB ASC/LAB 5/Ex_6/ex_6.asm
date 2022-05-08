bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; A byte string S is given. Obtain the string D by concatenating the elements found on the even positions of S and then the elements found on the odd positions of S.
segment data use32 class=data
    s db 1, 2, 3, 4, 5, 6, 7, 8
    len_s equ $ - s
    separator db -1
    d resb len_s
    
segment code use32 class=code
    start:
        mov ecx, 0
        mov ebx, 0
        
        parse_string_s_odd_pos:
            cmp ecx, len_s 
            jae fin_of_first_parsing
            
            mov al, [s + ecx]
            mov [d + ebx], al
            
            inc ebx
            add ecx, 2
            jmp parse_string_s_odd_pos
            
        fin_of_first_parsing:
        
        mov ecx, 1
        parse_string_s_even_pos:
            cmp ecx, len_s 
            jae fin_of_second_parsing
            
            mov al, [s + ecx]
            mov [d + ebx], al
            
            inc ebx
            add ecx, 2
            jmp parse_string_s_even_pos
            
        fin_of_second_parsing:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
