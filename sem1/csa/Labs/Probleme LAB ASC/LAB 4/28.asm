bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    ;Given the quadword A, obtain the integer number N represented on the bits 17-19 of A. 
    ;Then obtain the the doubleword B by rotating the high doubleword of A N positions to the left. 
    ;Obtain the byte C as follows:
        ;the bits 0-2 of C are the same as the bits 9-11 of B
        ;the bits 3-7 of C are the same as the bits 20-24 of B
        
    a dq 0000000000000000000000000000000100000000000001100000000000000000b
    ;           |       |       |       |       |       |       |      
    n dd 0
    b dd 0
    c dw 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov bx, 0
        mov eax, dword [a]
        mov edx, dword [a+4]
        and eax, 00000000000011100000000000000000b
        mov cl, 17
        ror eax, cl
        mov [n], eax    ;n=3
        
        mov cl, byte [n]
        rol edx, cl ;edx=001(=3) ->we rotate 3 times to the left => edx=100(=8)
        mov [b], edx
        
        mov ax, word [b]
        mov dx, word [b+2]
        
        and ax, 0000111000000000b
        mov cl, 9
        ror ax, cl
        or [c],ax
        
        and dx, 0000000111110000b
        mov cl, 4
        ror dx, cl
        or [c],dx ;result will be 0 because b = 00000000000000000000000000000100
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
