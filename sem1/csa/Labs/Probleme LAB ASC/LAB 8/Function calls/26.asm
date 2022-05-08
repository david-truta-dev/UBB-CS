bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start

extern exit
extern printf
extern scanf  
  
import exit msvcrt.dll   
import printf msvcrt.dll
import scanf msvcrt.dll

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    result dd 0
    format1 db 'a=', 0 
    format2 db 'b=', 0 
    readformat db '%d', 0 
    printformat db '(%d-%d)*%d=%xh', 0 
    k db 3

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; 26. Two numbers a and b are given. Compute the expression value: (a-b)*k, where k is a constant value defined in data segment. Display the expression value (in base 16).
        
        ; call printf("a=")
        push dword format1
        call [printf]
        add esp, 4*1
        
        ; call scanf("%d", a)
        push dword a     ; push the offset of a for reading (not its value)
        push dword readformat
        call [scanf]
        add esp, 4*2
        
        ; call printf("b=")
        push dword format2
        call [printf]
        add esp, 4*1
        
        ; call scanf("%d", b)
        push dword b 
        push dword readformat
        call [scanf]
        add esp, 4*2
        
        ; (a-b)
        mov edx, 0
        mov eax, [a]
        sub eax, [b]
        adc edx, 0     
        
        ; (a-b)*k
        mov ebx, 0
        mov ebx, [k]
        mul ebx
        
        ; result=(a-b)*k
        mov [result], eax   ; the result from above is stored in the variable result
        
        ; call printf("(%d-%d)*%d=%xh", a, b, k, result)
        ; now we will push the values of the variables for printing, not their offsets as before
        push dword [result]
        push dword [k]
        push dword [b]
        push dword [a]
        push dword printformat
        call [printf]
        add esp, 4*6
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
