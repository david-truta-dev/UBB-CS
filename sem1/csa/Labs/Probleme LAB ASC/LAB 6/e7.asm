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
    s dd 12345678h, 1A2B1A2Bh, 0xFE98DC76, 30345678h, 12345678h
    len equ ($-s)/4
    trei db 3
    ;d db 0 ;d = 1230
    d resb len
    

; our code starts here
segment code use32 class=code
    start:
    
        ;Obtain the list made out of the high bytes of the high words of each doubleword from the given list with the property that these bytes are multiple of 3.
        
        
        mov esi, s
        mov ecx, len
        mov edx, 0
        mov edi, d
       
        
        repeta:
          
            lodsd
            
            rol eax, 8
            mov ah, 0
            
            mov bl, al
            
            div byte[trei]
            cmp ah, 0
            
            jnz nediv3
            ;mov[d+edx], bl
            mov al, bl
            stosb
            ;inc edx
           
            
            nediv3:
            
        loop repeta;
        
        ;d = 1230
        
        
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
