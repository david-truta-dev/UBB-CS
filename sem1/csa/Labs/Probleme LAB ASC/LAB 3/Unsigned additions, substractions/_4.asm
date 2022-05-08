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
    ; a - byte, b - word, c - double word, d - qword - Unsigned representation
    a db 255 
    b dw 253 
    c dd 1260 
    d dq 184467

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; (a-b)+(c-b-d)+d 
        ; result = 1009 = 3F1h
        
        ; a-b = 2 in bx 
        ;mov ebx, 0
        mov ebx, 0
        mov bl, [a]
        mov ax, [b]
        sub bx, ax
        ;(a-b)+(c-b-d)
        mov edx, 0
        mov ecx, 0
        mov ecx, [c]
        mov edx, 0
        mov dx, [b]
        sub ecx, edx
        adc ecx, ebx
        mov eax, 0
        mov eax, ecx
        sub eax, dword[d]
        sbb edx, dword[d+4]
        ; (a-b)+(c-b-d)+d 
        add eax, dword[d]
        adc edx, dword[d+4]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program