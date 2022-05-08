bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern printf
extern fopen
extern fgets
extern fclose

import printf msvcrt.dll
import fopen msvcrt.dll
import fgets msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    fname db "input.txt",0
    mode db "r",0
    descriptor dd -1
    
    info resb 1000
    freq times 26 db 0
    pos dd 0
    
    format db "The most frequent letter is '%c' with %d appearances.",0
    
; our code starts here
segment code use32 class=code
        ;A text file is given. Read the content of the file, determine the uppercase letter with the highest frequency and display the letter along with its frequency on the screen. The name of text file is defined in the data segment.

        start:
            push dword mode
            push dword fname
            xor eax,eax
            call [fopen]
            add esp, 4*2
            cmp eax,0
            je finnish
            
            mov [descriptor], eax 
            push dword [descriptor]
            push dword 1000
            push dword info
            call [fgets]
            add esp, 4*3
            
            push dword [descriptor]
            call [fclose]
            add esp, 4*1
                  
            mov esi, info
            xor eax, eax
            
            ;counts every uppercase
            loop1:              
                lodsb
                
                cmp eax, 0
                je end_loop1
                cmp eax, 0x41
                jb skip
                cmp eax, 0x5A
                ja skip  ;check if uppercase
                                
                mov bl, [freq+eax-0x41]
                inc bl
                mov [freq+eax-0x41],bl
                
                skip:
                jmp loop1
            end_loop1:
            
            xor eax,eax
            xor ebx,ebx
            mov ecx, 26
            mov esi, freq
            
            ;find most frequent uppercase letter
            loop2:              
                lodsb
                cmp ebx, eax  ;ebx stores most freq ch frequency number
                ja skip2
                    mov ebx, eax
                    mov [pos], esi
                skip2:
            loop loop2
            
            push ebx    ;frequency
            
            mov eax, [pos]
            sub eax, freq   ;most freq character's adress - the adress where we start at = the character's position in the alphabet
            add eax, 0x40   ; the ch's position + the hex number = the character in hex 
            push eax    ;most frequent character
            
            push format
            call [printf]
            add esp, 4*3
         

            
        finnish:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        