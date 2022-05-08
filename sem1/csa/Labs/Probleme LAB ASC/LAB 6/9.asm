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
    s dd 12345578h, 1A2C3C4Dh, 98FCDD76h, 12783A2Bh
    len equ ($-s)/4
    two db 2
    nr db 0xFF
    d dd 0

    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;A list of doublewords is given. 
        ;Starting from the low part of the doubleword, obtain the doubleword made of the high even bytes of the low words of each doubleword from the given list. 
        ;If there are not enough bytes, the remaining bytes of the doubleword will be filled with the byte FFh.
        ;...
        ;Example:
        ;Given the string of doublewords:
            ;s DD 12345578h, 1A2C3C4Dh, 98FCDD76h, 12783A2Bh
        ;obtain the doubleword:
            ;d DD FF3A3C56h
        ;...
        

        mov edi, d  ;our result will be in d
        mov ebx, 0  ;how many odd numbers
        mov ax,0
        
        mov esi, s
        mov ecx, len
        s_sequence:
            lodsw   ;in ax -> the low part of the dword
            mov al, ah  ;in al -> the high byte of the low part of the dword
            mov ah, 0
            div byte [two]
            cmp ah, 0
            jnz odd_number
            mul byte [two]
            stosb   ;in d -> our byte if even
            test ah,ah
            jz even_number
            odd_number:
                inc ebx     ;number of odd numbers
            even_number:
            mov ax,0
            inc esi
            inc esi
        loop s_sequence
        
        mov al, [nr]
        mov ecx, ebx
        sequence:
            mov [edi], al   ;put in d the number FF every time the programm found an odd number and jumped over it in the previous for
            inc edi
        loop sequence
            
            
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
