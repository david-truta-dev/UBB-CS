bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Two character strings S1 and S2 are given. Obtain the string D by concatenating the elements of S2 in reverse order and the elements found on even positions in S1.
segment data use32 class=data
   s1 db '+', '2', '2', 'b', '8', '6', 'X', '8'
   len_s1 equ $ - s1
   s2 db 'a', '4', '5'
   len_s2 equ $ - s2
   separator db 0
   d resb len_s1 + len_s2
segment code use32 class=code
    start:
        mov ebx, 0 ; ebx whill point to the next free element from string d
        
        mov esi, s2
        add esi, len_s2 - 1
        mov ecx, len_s2
        std
        
        parse_s2_in_revserse_order:
            lodsb ; mov the byte from DS:ESI into AL
            
            mov [d + ebx], al
            inc ebx
            
            loop parse_s2_in_revserse_order
        
        
        mov ecx, 1
        parse_s1_on_even_positions:
            cmp ecx, len_s1
            jae fin
            
            mov al, [s1 + ecx]
            mov [d + ebx], al
            
            inc ebx
            add ecx, 2
            jmp parse_s1_on_even_positions
            
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
