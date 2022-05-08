bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose, scanf   ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll                ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll               ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fprintf msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;12.A file name is given (defined in the data segment). Create a file with the given name, then read numbers from the keyboard and write those numbers in the file, until the value '0' is read from the keyboard.
    file_name db "Problema12.txt", 0
    access_mode db "w", 0
    file_descriptor dd -1
    input_format db "%d", 0
    current_number resd 1
    output_format db "%d ", 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4 * 2
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je final1
        
        while_not_zero:
            push dword current_number
            push dword input_format
            call [scanf]
            add esp, 4 * 2
            
            cmp dword[current_number], 0
            je final2
            
            push dword [current_number]
            push dword output_format
            push dword [file_descriptor]
            call [fprintf]
            add esp, 4 * 3
            jmp while_not_zero
        
        final2:        
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4 * 1
        
        final1:
   
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
