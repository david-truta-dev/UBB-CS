bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; A byte string s is given. Build the byte string d such that every byte d[i] is equal to the count of ones in the corresponding byte s[i] of s
segment data use32 class=data
    s db 5, 25, 55, 127
    len_s equ $ - s
    d resb len_s 
    
segment code use32 class=code
    start:
        mov esi, s
        mov edi, d
        
        cld
        mov ecx, len_s
        parse_s_to_obtain_r:
            lodsb ; move the byte from DS:ESI into AL
            mov bl, 0
            clc
            while_al_bigger_than_0:
                cmp al, 0
                je fin_of_while
                
                shr al, 1
                jnc don_t_add_1
                
                inc bl
                
                don_t_add_1:
                    jmp while_al_bigger_than_0
                
            fin_of_while:
            
            mov al, bl
            stosb ; move the byte from AL into ES:EDI
            
            loop parse_s_to_obtain_r
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
