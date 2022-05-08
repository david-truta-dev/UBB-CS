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
    a db 10101100b ; ACh
    b db 11100110b ; E6h
    c dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; 5. Given the bytes A and B, compute the doubleword C as follows:
        ; the bits 16-31 of C have the value 1
        ; the bits 0-3 of C are the same as the bits 3-6 of B
        ; the bits 4-7 of C have the value 0
        ; the bits 8-10 of C have the value 110
        ; the bits 11-15 of C are the same as the bits 0-4 of A
        
        ; result c -> 11111111 11111111 01100110 00001100b -> FFFF660C 
        
        mov eax, 0 ; we compute in eax
        or eax, 11111111111111110000000000000000b ; bits 16-31 have the value 1 now
        
        mov bl, [b]
        ; we want to shift to right the bits 3 positions, so that bits 3-6 will be on position 0-3
        shr bl, 3
        ; we leave the bits 0-3 of bl unchanged and set the other bits to 0
        and bl, 00001111b
        or al, bl
        
        ; the bits 4-7 in al are already 0, but let's pretend they are not and put 0 on 4-7 bits anyway
        and al, 00001111b
        
        ; the bits 9-10 will be 11, the rest will remain unchanged
        or ax, 00000011000000000b
        ; the bit 8 will have the value 0
        and ax, 11111111011111111b
        
        mov bx, 0
        mov bx, [a]
        ; we want to shift to left the bits 11 positions, so that bits 0-4 will be on position 11-15
        shl bx, 11
        ; we leave the bits 11-15 of bx unchanged and set the other bits to 0
        and bx, 01111100000000000b
        ; we convert the bits 11-15 of ax to 0
        and ax, 10000011111111111b
        ; we move the bits 11-15 from bx to ax, the rest of ax remains unchanged
        or ax, bx
        
        ; the final result is in [c] (and in eax also)
        or [c], eax
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
