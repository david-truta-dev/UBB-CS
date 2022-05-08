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
    ; a - word b,c,d - byte e - doubleword x - qword - Unsigned representation
    b db 32 ; = 20h
    c db 124 ; = 72h
    d db 45 ; = 23h
    a dw 1111 ; = 457h
    e dd 29836 ; = 748Ch
    x dq 223311 ; = 3684Fh
    aux dd
; our code starts here
segment code use32 class=code
    start:
        ; ...                              
        ; (a*2+b/2+e)/(c-d)+x/a
        ; result = (2222+16+29836)/79 + 201 = 607 = 25Fh 
        
        ; a*2 = 8AE
        mov eax, 0
        mov al, 2
        mov cx, [a]
        mul cx
        ; b/2 = 10
        mov ebx, eax
        mov eax, 0
        mov al, [b]
        mov ah, 0
        mov cl, 2
        div cl
        ;(a*2+b/2+e) = 7D4Ah in ebx
        add eax, [e]
        add ebx, eax
        ;(c-d) = 4F in cx
        mov ecx, 0
        mov eax, 0
        mov cl, [c]
        mov ch, 0
        mov al, [d]
        mov ah, 0
        sub cx, ax
        ;(a*2+b/2+e)/(c-d) = 196h in ax
        mov eax, ebx
        mov dx, 0 
        div cx
        ;x/a -> eax
        mov bx, ax
        mov ax, [a]
        mov ecx, eax
        mov eax, dword [x]
        mov edx, dword [x+4]
        div ecx
        ;(a*2+b/2+e)/(c-d)+x/a
        mov ecx, eax
        mov ax, bx
        add eax, ecx
        ; result in eax
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program