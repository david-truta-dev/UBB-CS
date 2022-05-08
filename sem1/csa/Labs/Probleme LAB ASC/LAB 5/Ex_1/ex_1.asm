bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Given a byte string S of length l, obtain the string D of length l-1 as D(i) = S(i) * S(i+1) (each element of D is the product of two consecutive elements of S)
segment data use32 class=data
   s db 1, 2, 3, 4
   len_s equ $ - s
   d resb len_s
   
segment code use32 class=code
    start:
        mov ecx, 0 ; ecx - is a general index for parsing the s string
        
        while_ecx_smaller_than_len_s:
            cmp ecx, len_s
            je fin
            
            mov al, [s + ecx]
            mov bl, [s + ecx + 1]
            mul bl
            
            mov byte [d + ecx], al
            
            inc ecx
            jmp while_ecx_smaller_than_len_s
            
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
