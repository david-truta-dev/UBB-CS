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
    ;a,b,c,d-byte; e-word; x-qword
    a db 5 
    b db 4
    c db 4 
    d db 1
    e dw 0001h
    x dq 000000000000000Ah
    p dw 0
    para1 dw 0
    ;para2 dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;( ( a*b - 2*c*d ) / (c-e) + x/a ) - unsigned
        
        mov eax,0
        mov al, [a]
        mov bl, [b]
        mul bl
        mov [p], ax ; p=a*b=14h
        
        mov al, 2
        mov bl, [c]
        mul bl
        mov bx, ax ;bx=2*c
        mov al, [d]
        mul bx ;dx:ax=2*c*d=8h
        push dx
        push ax
        pop ecx ;ecx=8h
        
        sub [p], ecx ;p = ( a*b - 2*c*d ) = 0Ch
        
        mov al, [c]
        sub al, [e]
        mov [para1], al ;para1=(c-e)
        mov al, [p]
        
        div word [para1]
        mov [para1], al; para1=(a*b - 2*c*d)/(c-e)=4
        mov eax, [x]
        mov edx, 0
        mov ebx, 0
        mov bl, [a]
        div bl; al=x/a=2
             
        add al, [para1] ;( ( a*b - 2*c*d ) / (c-e) + x/a ) = 6
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
