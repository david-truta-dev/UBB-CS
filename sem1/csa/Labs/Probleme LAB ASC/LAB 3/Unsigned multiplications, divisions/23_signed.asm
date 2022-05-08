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
    d db 3
    e dw 0A41h
    x dq 000000000000000Ah
    p dd 0
    para1 dw 0
    ;para2 dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;( ( a*b - 2*c*d ) / (c-e) + x/a ) - signed
        
        mov eax,0
        mov al, [a]
        mov bl, [b]
        imul bl
        mov [p], ax ; p=a*b=14h
        
        mov al, 2
        mov bl, [c]
        imul bl
        mov bx, ax ;bx=2*c
        mov al, [d]
        imul bx ;dx:ax=2*c*d=18h
        push dx
        push ax
        pop ebx ;ebx=18h
        
        sbb [p], ebx ;p = ( a*b - 2*c*d ) = FFFF FFFCh
        
        mov ax,0
        mov al, [c]
        cbw
        sbb ax, [e] ;ax=(c-e)=F5C3
        mov [para1], ax ;para1=(c-e)
        mov ax, [p]
        mov dx, [p+2] ;ax:dx=(a*b-2*c*d)
        idiv word [para1] 
        
        mov [para1], ax ;para1=(a*b-2*c*d)/(c-e) = 0
        
        mov eax, [x]
        cdq
        mov ebx, 0
        mov bl, [a]
        idiv bl; al=x/a=2
        
        
        add al, [para1] ;( ( a*b - 2*c*d ) / (c-e) + x/a ) = 2
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
