bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

;Two byte strings S1 and S2 are given. Obtain the string D by concatenating the elements of S1 from the left hand side to the right hand side and the elements of S2 from the right hand side to the left hand side.
segment data use32 class=data
    s1 db 1, 2, 3, 4
    len_s1 equ $ - s1
    s2 db 5, 6, 7
    len_s2 equ $ - s2
    d resb len_s1 + len_s2
    
segment code use32 class=code
    start:
        mov esi, s1
        mov edi, d
        
        cld ; clear direction flag (DF = 0) in order to parse the first string in normal order (from 0 to (len_s1 - 1))
        mov ecx, len_s1
        
        parse_string_1:
            movsb ; move the byte from DS:ESI to DS:EDI
            loop parse_string_1
        
        mov esi, s2
        add esi, len_s2 - 1
        
        std ; set direction flag to 1 in order to parse the second string in reverse order
        
        mov ecx, len_s2
       
        parse_string_2:
            lodsb ; move the byte from DS:ESI into AL
            mov byte [edi], al
            
            inc edi
            loop parse_string_2
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
