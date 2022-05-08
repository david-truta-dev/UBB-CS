bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll     ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 39
    b dd -62
	message db "%d + %d = %d", 0
    
    ;Two natural numbers a and b (a, b: dword, defined in the data segment) are given. Calculate their sum and display the result in the following format: "<a> + <b> = <result>". Example: "1 + 2 = 3"
    ;The values will be displayed in decimal format (base 10) with sign.

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov eax, [a]
        add eax, [b]
        push eax
        
        mov eax,[b]
        push eax
        
        mov eax, [a]
        push eax
        
        push dword message
        call [printf]
        add  esp,4*4 
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
