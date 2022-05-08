bits 32 

global start, concat_string_final    

extern exit, scanf, printf, concatenate_string       
import exit msvcrt.dll    
import scanf msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    concat_string_final resb 90
    string_1 resb 30
    string_2 resb 30
    string_3 resb 30
    format_read_string db "%s", 0
segment code use32 class=code
    start:
        push dword string_1
        push format_read_string
        call [scanf]
        add esp, 4 * 2
        
        push dword string_2
        push format_read_string
        call [scanf]
        add esp, 4 * 2
        
        push dword string_3
        push format_read_string
        call [scanf]
        add esp, 4 * 2
        
        mov ebx, 0
        
        push string_1
        call concatenate_string
        add esp, 4 
        
        push string_2
        call concatenate_string
        add esp, 4 
        
        push string_3
        call concatenate_string
        add esp, 4 
        
        push concat_string_final
        call [printf]
        add esp, 4 * 1
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
