bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
                          
import printf msvcrt.dll  ; indicating to the assembler that the printf fct can be found in the msvcrt.dll library
import scanf msvcrt.dll   ; similar for scanf

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 100
    b dd 0
    input_msg     db "> Enter dword: ", 0
    scanf_format  db "%d", 0
    printf_format db "> %d + %d/%d = %d", 0
    
; our code starts here
segment code use32 class=code
    start:
        ; A natural number a (a: dword, defined in the data segment) is given. Read a natural number b from the keyboard and calculate: a + a/b. Display the result of this operation. The values will be displayed in decimal format (base 10) with sign.
    
        push dword input_msg
        call [printf]               ; displaying a prompt message to the console
        add esp, 4*1                ; clean stack
    
        push dword b
        push dword scanf_format
        call [scanf]                ; reading number 'b'
        add esp, 4*2                ; clean stack
        
        mov eax, [a]
        cdq                         ; edx:eax = eax = a
        idiv dword [b]              ; eax = edx:eax / b = a / b
        add eax, [a]                ; eax = a + a/b
        
        push dword eax
        push dword [b]
        push dword [a]
        push dword [a]
        push dword printf_format
        call [printf]               ; printf(printf_format, a, a, b, a + a/b)
        add esp, 4*5                ; clean stack
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
