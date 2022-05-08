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
    
    s dw -22, 145, -48, 127
    len db $-s
    db '|' ; separator - 7C
    d db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; 6. A word string s is given. Build the byte string d such that each element d[i] contains:
        ; - the count of zeros in the word s[i], if s[i] is a negative number
        ; - the count of ones in the word s[i], if s[i] is a positive number
        ; Example:
        ; s: -22, 145, -48, 127
        ; in binary:
        ; 1111111111101010, 10010001, 1111111111010000, 1111111
        ; d: 3, 3, 5, 7
        
        xor eax, eax ; forces the content of eax to 0
        mov al, [len] ; we move the len value in al
        mov byte [len], 2
        div byte [len] ; we divide the length of s (word string) by 2 
        mov [len], al  ; we obtain the length of d (byte string) in al and move it back in len
        xor ecx, ecx ; forces the content of ecx to 0
        mov cl, byte [len]  ; we put the length len in ecx so that it loops ecx - 1en times
        mov esi, s  ; we move s in esi
        mov edi, d  ; we move d in edi
        
        jecxz End_Program      
        Program:    
        
            mov bl, 0 ; counts 1's
            mov dl, 0 ; counts 0's
            mov ax, word[esi-2] ; we move the word in ax
            
            lodsw ; we move in ax the word from the string and esi=esi+2
            push ecx   ; we push ecx to the stack so we can make a second loop
            mov ecx, 16 ; we want to rotate 16 times, one bit at a time
            
            Second_Program:
                
                ror ax, 1 ; we rotate ax once to the right and the CF keeps the last rotated bit           
                inc bl ; we increase the counter of 1's
                
                jc one_value ; we jump if the CF = 1 and the 1's counter will not be modified again
                inc dl ; in case the CF = 0 we increase the counter of 0's
                dec bl ; then we decrease the counter of 1's
                one_value:
            
            loop Second_Program
            
            pop ecx
            mov ax, word[esi - 2] ; ; we move again the word in ax to check if it's positive or negative
            
            cmp ax, 0 ; we compare the value from ax to 0
            mov byte[edi], bl ; we move the 1's count in d 
            jg positive ; we jump over the next instruction if the number is positive
            mov byte[edi], dl
            positive:
            
            inc edi
            
        loop Program
        End_Program:          ; ending the program if ecx is 0
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
