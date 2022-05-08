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
    ;Problem #14
    ;Given an array S of doublewords, build the array of bytes D formed from bytes of doublewords sorted as unsigned numbers in ascending order.
    s DD 12345607h, 1A2B3C15h
    len equ $-s
    d resb len
    cnt dd 0
    min db 0
    poz dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s
        mov edi, d
        mov ecx, len
        copy:
            movsb    ;build the string of bytes in d
        loop copy
        ;for the sorting we'll use a simple selection of minimum sort
        mov esi, 0   ;from now on esi and ebi will be indexes (like i and j)
        xor ecx,ecx
        mov ecx,len
        sub ecx,1
        loop1:
            mov al,[d+esi] ;in al we'll keep d[esi]
            ;the reason why I'm not using lod here is because I want to increase
            ;esi after finishing my job with it later on
            ;with lod I'd need to work with esi-1 which is doable, but more confusing
            mov [cnt],ecx  ;make a copy of ecx so we can use ecx for the second loop
            xor ecx,ecx
            mov ecx,len
            sub ecx,1
            sub ecx,esi
            mov edi,esi
            add edi, 1  ;prepare the index for the second loop
            mov ah,al ;in ah we'll keep the min 
            loop2:
                mov bl,[d+edi]
                ;another caveat of using lod specifically in this case would be
                ;using esi for both the indexes (the i and the j)
                cmp bl,ah
                jnb skip
                    mov ah,bl     ;if d[edi] is smaller than the min so far, update the
                    mov [poz],edi ;min and it's position
                skip:
                inc edi
            loop loop2
            cmp ah,al
            jz skip2
            mov [d+esi],ah  ;if the min is smth other than d[esi], swap the values
            mov ebx,[poz]
            mov [d+ebx],al
            skip2:
            mov ecx, [cnt] ;put back in ecx the counter for the first loop
            inc esi
        loop loop1    
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
