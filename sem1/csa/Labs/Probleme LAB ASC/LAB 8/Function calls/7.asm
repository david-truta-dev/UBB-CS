; 7. Two natural numbers a and b (a: dword, b: dword, defined in the data segment) are given. 
; Calculate a/b and display the remainder in ; the following format: "<a> mod <b> = <remainder>". 
; Example: for a = 23, b = 5 it will display: "23 mod 5 = 3".
; The values will be displayed in decimal format (base 10) with sign.


bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern printf
extern scanf
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll                          


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    b dd 0
    inputgeta db "a = ", 0
    inputgetb db "b = ", 0
    inputmsg db "%d", 0
    outputmsg db "%d mod %d = %d", 0
    ; 450 mod 27 = 18

; our code starts here
segment code use32 class=code
    start:
        ; read a (unsigned) from console
        push inputgeta
        call [printf]
        add esp, 4
        
        push dword a 
        push inputmsg
        call [scanf]
        add esp, 4 * 2
        
        ; read b (unsigned) from console
        push inputgetb
        call [printf]
        add esp, 4
        
        push dword b
        push inputmsg
        call [scanf]
        add esp, 4 * 2
        
        ; if b == 0 -> end program
        cmp dword [b], 0
        jz final
        
        ; calculate a%b, result is stored in EDX
        mov eax, [a]
        mov edx, 0            ; EDX:EAX = a 
        
        div dword [b]         ; EDX = EDX:EAX % b = a % b
        
        ; print the result in the specified format
        push edx
        push dword [b]
        push dword [a]
        push outputmsg
        call [printf]
        add esp, 4 * 4
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
