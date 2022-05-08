bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, fopen, fclose, fread       
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf  msvcrt.dll
import fopen   msvcrt.dll
import fclose  msvcrt.dll
import fread   msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    path          db "test.txt", 0
	printf_format db "The number of vowels from file %s is %d", 0
    read_mode     db "r", 0
    descriptor    dd -1
    len           equ 100
    buffer        resb len
    counter       dq 0
    debug_msg     db "%d ", 0
    vowels        db 'aeiouAEIOU'
    
; our code starts here
segment code use32 class=code
    start:
        ; A text file is given. Read the content of the file, count the number of vowels and display the result on the screen. The name of text file is defined in the data segment.
        
        push dword read_mode
        push dword path
        call [fopen]          ; eax = fopen(path, "r")
		add esp, 4*2          ; clean stack
        mov [descriptor], eax ; save descriptor
        
        cmp eax, 0
        je fin
        
        str_iter:  
            push dword [descriptor]
            push dword len
            push dword 1
            push dword buffer
            call [fread]      ; fread(char, 1, 100, file)
            add esp, 4*4
            
            cmp eax, 0        ; eax = 0 means end of file
            je fin
            
            mov ecx, eax
            mov esi, buffer
            buffer_iter:
                lodsb
                
                push ecx
                mov ecx, 10
                mov edx, vowels
                
                check_vowel:
                    cmp al, [edx]
                    
                    jne skip
                    inc dword [counter]
                    
                    skip:
                    inc edx
                loop check_vowel
                pop ecx
                
            loop buffer_iter
            
            jmp str_iter
        fin:
        
		push dword [counter]
		push path
        push printf_format
		call [printf]		 ; printf(printf_format, path, count_vowels)
		add esp, 4*3         ; clean stack
        
        push dword [descriptor]
        call [fclose]        ; fclose(descriptor)
        add esp, 4*1
	
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
