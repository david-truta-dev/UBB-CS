; Given two strings S1 and S2, compute the string D which holds elemends which appear in S1 but not in S2

; pseudocode:
; for i <- 0, length_S1 - 1
;   for j <- length_S2 - 1, 0
;     if S1[i] == S2[j]
;       break;
;   if j <= 0
;      D[length_D++] = S1[i]

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    S1 db '+', '4', '2', 'a', '8', '4', 'X', '5'
    lenS1 equ $-S1
    S2 db 'a', '4', '5'
    lenS2 equ $-S2
    D resb 1
    ; length of D is stored in EDX
    
; our code starts here
segment code use32 class=code
    start:
        ; skips program if S1 is empty
        mov edx, lenS1
        cmp edx, 0
        je exit_loop
        
        mov edx, 0 ; holds the length of D
        mov ebx, 0 ; iterator for S1 | i
        
        ; for(int i = 0; i < lenS1; ++i)
        S1_iterate:
            cmp ebx, lenS1      ; exits the loop if we arrived at the end of the array (i >= lenS1)
            jge exit_loop
            
            mov al, [S1 + ebx]  ; al = S1[i]
            
            ; for(int j = lenS2 - 1; j >= 0; j--)
            mov ecx, lenS2      ; iterator for S2 | ecx - 1 = j
            jecxz S2_exit_loop  ; skips the loop if S2 is empty
            
            S2_iterate:
                ; if (S1[i] == S2[j]) break 
                ; (S1[i] cannot be added to D so we move to first loop)
                cmp al, [S2 + ecx - 1]
                je found_in_S2
            loop S2_iterate
            
        S2_exit_loop:
        
        ; D[length_d++] = S1[i]
        ; (S1[i] was not found in S2 so we can add it)
        mov [D + edx], al
        inc edx
        
        found_in_S2:
        inc ebx         ; i++
        jmp S1_iterate  ; go back to the start of the loop
    
    exit_loop:
        
        ; D should be '+', '2', '8', 'X'
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
