bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit 
extern printf 
extern scanf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll                       
import printf msvcrt.dll   ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    read db "%x %x"
    msg db "a = %x",10,"b = %x",10,"sum = %x",10, "difference = %x",  0
    a dd 0h
    b dd 0h


; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;20.Read two doublewords a and b in base 16 from the keyboard. Display the sum of the low parts of the two numbers and the difference between the high parts of the two numbers in base 16 Example:
        ;a = 00101A35h
        ;b = 00023219h
        ;sum = 4C4Eh
        ;difference = Eh
           
        ;read numbers
        push b
        push a
        push read
        call [scanf]
        add esp, 4*3

 
        ;calculate diff:
        xor eax,eax
        mov ax, word [a+2]
        sbb ax, word [b+2]
        xor dx,dx     
        push eax

        ;calculate sum:
        xor eax,eax
        mov ax, word [a]
        add ax, word [b]
        xor dx,dx
        push eax
        
        push dword [b]
        push dword [a]   
        push dword msg
        
        call [printf]
        add esp, 4 * 5
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
