bits 32 ; assembling for the 32 bits architecture
; Zachman Roxana 917/2
; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern scanf,printf,exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;A negative number a (a: dword) is given. Display the value of that number in base 10 and in the base 16 in the following format: "a = <base_10> (base 10), a = <base_16> (base 16)"
    a dd 0
    format db "%d",0
    message db "a = %d (base 10), a = %x (base 16)",0
; our code starts here
segment code use32 class=code
    start:
        push dword a
        push dword format
        call [scanf]
        add esp, 4*2
        
        mov eax,[a]
        
        push dword eax
        push dword eax
        push dword message
        call [printf]
        add esp, 4*3
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
