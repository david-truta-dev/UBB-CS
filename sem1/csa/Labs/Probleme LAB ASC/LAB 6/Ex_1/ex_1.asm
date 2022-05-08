bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; An array with doublewords containing packed data (4 bytes written as a single doubleword) is given. Write an asm program in order to obtain a new array of doublewords, where each doubleword will be composed by the rule: the sum of the bytes from an odd position will be written on the word from the odd position and the sum of the bytes from an even position will be written on the word from the even position. The bytes are considered to represent signed numbers, thus the extension of the sum on a word will be performed according to the signed arithmetic.
segment data use32 class=data
    s dd 127F5678h, 0ABCDABCDh
    s_terminator dd 0
    len_s equ $ - s
    r resd len_s / 4
    aux resd 1
    res_aux resd 1
segment code use32 class=code
    start:
        mov esi, s
        mov edi, r
        
        cld
        
        parse_string_s_to_obtain_r:
            lodsd ; move the dword from DS:ESI into EAX
            
            cmp eax, 0
            je fin
            
            
            mov [aux], eax
            
            movsx ax, byte [aux]
            movsx bx, byte [aux + 2]
            add ax, bx
            mov byte [res_aux + 2], ah
            mov byte [res_aux + 3], al
            
            movsx ax, byte [aux + 1]
            movsx bx, byte [aux + 3]
            add ax, bx
            mov byte [res_aux], ah
            mov byte [res_aux + 1], al
            
            mov eax, [res_aux]
            stosd ; move the dword form EAX into ES:EDI
            
            mov dword [aux], 0
            mov dword [res_aux], 0
            
            jmp parse_string_s_to_obtain_r
            
        
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
