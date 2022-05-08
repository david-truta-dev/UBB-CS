bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf                ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    messagea  db "a=", 0  
    messageb  db "b=", 0
	format  db "%d", 0 
    mresult db "a+b=%x",0
    result dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;Read two numbers a and b (in base 10) from the keyboard and calculate a+b.
        ;Display the result in base 16
        
        ;print a=
        push dword messagea 
        call [printf]      
        add esp, 4*1       
        
        ;read a
        push dword a       
        push dword format
        call [scanf]       
        add esp, 4 * 2  
    
        ;print b=
        push dword messageb
        call [printf]      
        add esp, 4*1     
        
        ;read b
        push dword b       
        push dword format
        call [scanf]       
        add esp, 4 * 2  
        
        ;compute result
        mov EAX, [a]
        add EAX, [b]
        mov [result], EAX
        
        ;print result
        push dword [result]
        push dword mresult
        call [printf]
        add esp, 4 * 2
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
