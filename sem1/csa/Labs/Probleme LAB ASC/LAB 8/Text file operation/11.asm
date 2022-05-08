bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern printf, scanf, fprintf, fopen, fclose
import printf msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    greeting_msg db 'Enter words:',10, 0
    input_msg db ">",0
    format db '%s', 0
    newline dd 10
    x resb 30
    
    fname db "output.txt", 0
    write db "w", 0
    descriptor dd -1
    
    ;A file name is given (defined in the data segment). Create a file with the given name, then read words from the keyboard and write those words in the file, until character '$' ;is read from the keyboard.
; our code starts here
segment code use32 class=code
    start:
    ; ...
    push dword write
    push dword fname
    xor eax, eax
    call [fopen]       
    add esp, 4*2
    
    cmp eax, 0
    je fin
    
    mov dword [descriptor], eax
    
    push dword greeting_msg
    call [printf]
    add ESP, 4 * 1          
    
    repet:
        
        push dword input_msg     
        call [printf]
        add ESP, 4 * 1
        
        push dword x
        push dword format
        call [scanf]
        add ESP, 4 * 2
    
        mov al, [x]
        cmp al, 24h
        je fin
    
        push dword x
        push dword format
        push dword [descriptor]
        call [fprintf]
        add esp, 4 * 3
        
        push dword newline
        push dword [descriptor]
        call [fprintf]
        add esp, 4 * 2
        
    jmp repet
    
    fin:
        push dword [descriptor]
        call [fclose]
        add esp, 4 * 1  
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
