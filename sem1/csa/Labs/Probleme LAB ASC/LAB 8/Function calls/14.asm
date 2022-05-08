bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf  ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll      ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll    ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;14.Read two numbers a and b (in base 16) from the keyboard and calculate a+b. Display the result in base 10
    a dd 0
    b dd 0
    message1 dd "a=", 0
    message2 dd "b=", 0
    message3 dd "a+b=", 0
    numbers_format dd "%x", 0
    result_format dd "%d", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword message1
        call [printf]
        add esp, 4 * 1
        
        push dword a
        push dword numbers_format
        call [scanf]
        add esp, 4 * 2
         
        push dword message2
        call [printf]
        add esp, 4 * 1
        
        push dword b
        push dword numbers_format
        call [scanf]
        add esp, 4 * 2
        
        push dword message3
        call [printf]
        add esp, 4 * 1
        
        mov eax, dword[a]
        add eax, dword[b]
        
        push eax
        push dword result_format
        call [printf]
        add esp, 4 * 2
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
