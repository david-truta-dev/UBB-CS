bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fprintf, fopen, fclose              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fprintf msvcrt.dll  
import fopen msvcrt.dll
import fclose msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db "asm,13,54.as2!2", 0
    lena equ ($-a)
    
    file_name db "newfile.txt", 0 
    access_mode db "w", 0
    file_descriptor dd -1
    
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;A file name and a text (defined in data segment) are given.
        ;The text contains lowercase letters, uppercase letters, digits and special characters. 
        ;Replace all digits from the text with character 'C'. 
        ;Create a file with the given name and write the generated text to file.
        
        ;replacing digits with "C"
        mov ecx, lena
        mov esi, 0
        repeta:
            mov bl, [a+esi]
            cmp bl, 30h
            jb not_digit
            
            cmp bl, 39h
            ja not_digit
            
            mov byte [a+esi], 43h
            
            not_digit:
            inc esi
        loop repeta
        
        ;opening file
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2
        
         mov [file_descriptor], eax
         
        ;writing to file
        push dword a
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
