bits 32 

global start, first_string, current_string     


extern exit, scanf, printf, check_subsequence         
import exit msvcrt.dll    
import scanf msvcrt.dll 
import printf msvcrt.dll 
segment data use32 class=data

    number_of_string resb 1
    first_string resb 101
    current_string resb 101
    format_decimal db "%u", 0
    format_string db "%s", 0
    message_is_a_subseq db "The first string is a subsequence of the others", 0
    message_is_not_subseq db "The first string is NOT a subsequence of the others", 0
    ok db 1
segment code use32 class=code
    start:
        push number_of_string
        push format_decimal
        call [scanf]
        add esp, 4 * 2
        
        mov ecx, [number_of_string]
        push ecx
        
        push first_string
        push format_string
        call [scanf]
        add esp, 4 * 2
        
        pop ecx
        dec ecx
        
        jecxz fin
        
        while_number_of_strings:
        push ecx
        cmp byte [ok], 0
        jz fin
        
        push current_string
        push format_string
        call [scanf]
        add esp, 4 * 2
        
        call check_subsequence
        
        mov ecx, 100
        clear_current_string:
            mov byte [current_string + ecx], 0
            loop clear_current_string    
            
        mov [ok], al
        pop ecx 
        
        loop while_number_of_strings
        
        fin:
        cmp byte [ok], 0
        jz not_subeq
        
        push message_is_a_subseq
        call [printf]
        add esp, 4 * 1
        jmp total_end
        
        not_subeq:
            push message_is_not_subseq
            call [printf]
            add esp, 4 * 1
        
        total_end:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
