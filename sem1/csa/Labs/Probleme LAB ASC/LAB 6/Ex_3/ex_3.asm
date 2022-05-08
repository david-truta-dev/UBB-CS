bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; An array of doublewords, where each doubleword contains 2 values on a word (unpacked, so each nibble is preceded by a 0) is given. Write an asm program to create a new array of bytes which contain those values (packed on a single byte), arranged in an ascending manner in memory, these being considered signed numbers.
segment data use32 class=data
    s dd 0702090Ah, 0B0C0304h, 05060108h
    len_s equ $ - s
    s_terminator dd 0
    r resb len_s / 2
    separator db 0xFF
    sorted_r resb len_s / 2
    aux dw 0
    res_aux_2 db 0
    res_aux_1 db 0
segment code use32 class=code
    start:
        mov esi, s
        mov edi, r
        
        cld
        parse_s_to_obtaion_r:
            lodsd ; mov the dword from DS:ESI into EAX
            
            cmp eax, 0
            je fin_of_parsing
            
            mov [aux], ax
            mov bl, [aux + 1]
            shl bl, 4
            add bl, [aux]
            
            mov byte [res_aux_2], bl
            
            shr eax, 16
            mov [aux], ax
            mov bl, [aux + 1]
            shl bl, 4
            add bl, [aux]
            
            mov byte [res_aux_1], bl
            
            mov al, [res_aux_1]
            stosb
            mov al, [res_aux_2]
            stosb
            
            jmp parse_s_to_obtaion_r
            
        fin_of_parsing:
        
        mov esi, r
        mov edi, sorted_r
        mov ecx, len_s / 2
        while_len:
            movsb
            loop while_len
        
        
        mov edx, len_s / 2 ; edx will contain the length of r
        
        mov esi, 0 ; ebx will act as i
        
        for_i_in_0_len_r_minus_1:
            dec edx
            cmp esi, edx
            je fin
            inc edx
            
            
            mov ecx, esi
            inc ecx
            for_j_in_i_plus_1_len_r:
                cmp ecx, edx
                je fin_of_j_loop
                
                mov al, [sorted_r + esi]
                mov bl, [sorted_r + ecx]
                cmp al, bl
                jl no_swap
                
                mov byte [sorted_r + esi], bl
                mov byte [sorted_r + ecx], al
                
                no_swap:
                    inc ecx
                    jmp for_j_in_i_plus_1_len_r
                
            fin_of_j_loop:
                inc esi
                jmp for_i_in_0_len_r_minus_1
            
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
