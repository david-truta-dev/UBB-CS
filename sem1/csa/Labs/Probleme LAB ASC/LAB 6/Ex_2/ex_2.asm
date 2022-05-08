bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    


;An array of words is given. Write an asm program in order to obtain an array of doublewords, where each doubleword will contain each nibble unpacked on a byte (each nibble will be preceded by a 0 digit), arranged in an ascending order within the doubleword.
segment data use32 class=data
    s dw 1432h, 8675h, 0ADBCh
    len_s equ $ - s
    s_terminator dw 0
    r resd len_s / 2
    res_aux dd 0
segment code use32 class=code
    start:
        mov esi, s
        mov edi, r
        
        cld
        
        parse_s_to_obtain_r:
            lodsw
            
            cmp ax, 0
            je fin
            mov ecx, 0
            
            while_ax_greater_than_0:
                cmp ax, 0
                je fin_of_while
                
                mov dx, ax
                mov ah, 0
                
                mov bl, 16
                div bl
                
                mov byte [res_aux + ecx], ah
                inc ecx
                mov ax, dx
                shr ax, 4
                jmp while_ax_greater_than_0
                
            fin_of_while:    
            
            ;now we have to sort the bytes of the result (we will use bubble sort)
            
            mov ebx, 0 ; ebx will act as i
            
            for_i_in_0_2:
                cmp ebx, 3
                je fin_of_sort
                
                mov ecx, ebx ; ecx will act as j
                inc ecx
                for_j_in_i_puls_1_3:
                    cmp ecx, 4
                    je fin_of_j_loop
                
                    mov al, [res_aux + ebx]
                    cmp al, [res_aux + ecx]
                    jbe no_swap
                    
                    mov dl, [res_aux + ecx]
                    mov [res_aux + ebx], dl
                    mov [res_aux + ecx], al
                    
                    no_swap:
                    inc ecx
                    jmp for_j_in_i_puls_1_3
                    
                fin_of_j_loop: 
                inc ebx
                jmp for_i_in_0_2
            
            fin_of_sort:
                mov eax, [res_aux]
                stosd
                jmp parse_s_to_obtain_r
        
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
