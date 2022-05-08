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
    a db 2
    b dw 5A3h
    c dd 8AD42Fh
    d dq 1F784Ah

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;((a + a) + (b + b) + (c + c)) - d   -- unsigned
        
        mov eax, 0
        mov al, [a]
        add al, [a]
        mov ah, 0 ;ax=4
        
        add ax, [b]
        add ax, [b]
        mov dx,0  ;dx:ax=(a+a)+(b+b) = B4Ah
        
        mov bx, word [c]
        mov cx, word [c+2]
        
        add ax, bx
        adc dx, cx
        add ax, bx
        adc dx, cx 
        push dx
        push ax
        pop eax
        mov edx,0 ;edx:eax=(a+a)+(b+b)+(c+c) = 115B3A8h
        
        sub eax, dword [d]
        sbb edx, dword [d+4] ;edx:eax = F63B5Eh
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
