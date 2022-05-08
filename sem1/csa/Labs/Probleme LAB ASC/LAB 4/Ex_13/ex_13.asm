bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Given 4 bytes, compute in AX the sum of the integers represented by the bits 4-6 of the 4 bytes.
segment data use32 class=data
    a db 0101111b ; bits 4 - 6 represent the integer number: 2
    b db 1111111b ; bits 4 - 6 represent the integer number: 7
    c db 1001111b ; bits 4 - 6 represent the integer number: 4
    d db 0011111b ; bits 4 - 6 represent the integer number: 1
segment code use32 class=code
    start:
        mov ax, 0
        mov bx, 0
        
        mov bl, [a]
        shr bl, 4
        and bl, 111b
        
        add ax, bx
        mov bx, 0
        
        mov bl, [b]
        shr bl, 4
        and bl, 111b
        
        add ax, bx
        mov bx, 0
        
        mov bl, [c]
        shr bl, 4
        and bl, 111b
        
        add ax, bx
        mov bx, 0
        
        mov bl, [d]
        shr bl, 4
        and bl, 111b
        
        add ax, bx
        
        ; the value of AX will be 14
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
