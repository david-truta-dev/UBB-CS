bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

;Given the doubleword A, obtain the integer number n represented on the bits 14-17 of A. Then obtain the doubleword B by rotating A n positions to the left. Finally, obtain the byte C as follows:
; the bits 0-5 of C are the same as the bits 1-6 of B
; the bits 6-7 of C are the same as the bits 17-18 of B

segment data use32 class=data
  a dd 0x11010000  
  b resd 1
  c resb 1
  n resb 1
segment code use32 class=code
    start:
        mov eax, [a]
        shr eax, 14
        and eax, 1111b
        mov byte [n], al ; obtain the integer number n represented on the bits 14-17 of A
        
        mov cl, [n]
        mov eax, [a]
        rol eax, cl
        mov dword [b], eax ; obtain the doubleword B by rotating A n positions to the left
        
        mov eax, [b]
        shr eax, 1
        and eax, 111111b
        or byte [c], al
        
        mov eax, [b]
        shr eax, 17
        and eax, 11b
        shl eax, 6
        or byte [c], al
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
