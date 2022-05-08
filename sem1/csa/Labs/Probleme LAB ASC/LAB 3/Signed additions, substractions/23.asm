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
    a db 5
    b dw 4F7h
    c dd 7F74D578h
    d dq 0AF54Ah
    p dw 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;a + b + c + d - (a + b) - signed
        
        mov eax, 0
        mov al, [a]
        cbw
        add ax, [b]
        mov [p], ax
        cwd ; dx:ax=a+b
        
        sub ax, word [p]
        sbb dx, word [p+2]
        
        add ax, word [c] 
        adc dx, word [c+2]
        
        push dx
        push ax
        pop eax 
        cdq 
        
        add eax, dword [d]
        adc edx, dword [d+4]; a+b+c+d = 7F7FCAC2h
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
