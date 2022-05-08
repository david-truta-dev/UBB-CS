bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data

    s1 db 1, 3, 6, 2, 3, 7   ; declaring initial values
    len equ $-s1             ; len stores the length of s1
    s2 db 6, 3, 8, 1, 2, 5
	d times (len) db 0       ; reserving and initialising with 0 a memory space of len bytes for the destination string d

; our code starts here
segment code use32 class=code
    start:
        ; 17. Two byte strings S1 and S2 are given, having the same length. Obtain the string D so that each element of D represents the maximum of the corresponding elements from S1 and S2.
        ; Example:
        ; S1: 1, 3, 6, 2, 3, 7
        ; S2: 6, 3, 8, 1, 2, 5
        ; D:  6, 3, 8, 2, 3, 7
        
        mov ecx, len          ; we put the length len in ecx so that it loops ecx - 1en times
        mov esi, 0            ; i = 0
        jecxz End_Program      
        Program:     
            mov al, [s1+esi]  ; we move in al s1[i]
            mov [d+esi], al   ; we move in d[i] = s1[i]
            mov bl, [s2+esi]  ; we move in bl s2[i]
            
            cmp al, bl        ; we compare s1[i] with s2[i]
            ja overit         ; we jump over the next instruction if s1[i] > s2[i], because we dont't need to modify d[i] then
            
            mov [d+esi], bl   ; d[i] = s2[i] if s2[i] > s1[i]
            
            overit:
            
            inc esi           ; i++
        loop Program
        End_Program:          ; ending the program if ecx is 0
    
        ; exit(0)
        push    dword 0       ; push the parameter for exit onto the stack
        call    [exit]        ; call exit to terminate the program
