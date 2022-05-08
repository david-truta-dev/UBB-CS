; A file name (defined in data segment) is given. 
; Create a file with the given name, then read words from the keyboard until character '$' is read. 
; Write only the words that contain at least one lowercase letter to file.


; scanf("%s", sir)
; do
;   parse sir
;   if sir has lower letters: fprintf("output.txt", "%s")
;   else: continue
; while sir != '$'



bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
extern fopen
extern fclose
extern fprintf
extern scanf

import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db 'output.txt', 0
    access_mode db 'w', 0
    file_descriptor resd 1
    write_string_in_file db '%s ', 0
    
    read_input_string db '%s',0
    input_string resb 50

; our code starts here
segment code use32 class=code
    start:
        ; file_descriptor = fopen("output.txt", "w")
        push access_mode
        push file_name
        call [fopen]
        add esp, 4 * 2
        mov [file_descriptor], eax
        
        ; if the file did not open correctly, then end the program
        cmp eax, 0
        je final
        
        ; loop to read every word from the keyboard
        read_words_from_keyboard:
        ; scanf("%s", input_string)
        push input_string
        push read_input_string
        call [scanf]
        add esp, 4 * 2
        
        ; mov the string to esi
        mov esi, input_string
            
            ; loop to check each letter of the string until we reach the end or find a lowercase letter
            parse_string:
            lodsb       ; AL = input_string[i]
            
            ; if input_string[i] = 0 -> we reached the end of the current word, so we read the next word
            cmp AL, 0
            je read_words_from_keyboard
            
            ; if character '$' was read, we can close the file and stop the program
            cmp AL, '$'
            je close_file
            
            ; if input_string[i] is a lowercase letter -> write the word in the file
            ; else read the next letter
            cmp AL, 'a'
            jb parse_string
            
            cmp AL, 'z'
            ja parse_string
            
            ; if we arrived here then the last read word will be written into the file
            
        write_word_to_file:
        ; fprintf(file_descriptor, input_string)
        push dword input_string
        push dword write_string_in_file
        push dword [file_descriptor]
        call [fprintf]
        
        jmp read_words_from_keyboard
        
        ; fclose(file_descriptor)
        close_file:
        push dword [file_descriptor]
        call [fclose]
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
