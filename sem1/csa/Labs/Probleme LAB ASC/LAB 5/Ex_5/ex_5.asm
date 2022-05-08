bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; A character string S is given. Obtain the string D containing all small letters from the string S
segment data use32 class=data
    s db 'a', 'A', 'b', 'B', '2', '%', 'x', '!', 'm', 'M', '@'
    len_s equ $ - s
    separator db 0
    d resb len_s
    
segment code use32 class=code
    start:
        mov esi, s
        mov edi, d
        cld
        
        mov ecx, len_s
        jecxz fin
        
        parse_string_s:
            mov al, [esi]
            
            cmp al, 'a'
            jb not_small_letter
            
            cmp al, 'z'
            ja not_small_letter
            
            movsb
            jmp fin_of_parsing
            
            not_small_letter:
                inc esi
                
            fin_of_parsing:
                loop parse_string_s
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
