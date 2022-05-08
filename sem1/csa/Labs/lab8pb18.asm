bits 32 ;assembling for the 32 bits architecture
global start

; we ask the assembler to give global visibility to the symbol called start 
;(the start label will be the entry point in the program) 
extern exit, fopen, fclose, fread, printf ; we inform the assembler that the exit symbol is foreign; it exists even if we won't be defining it
import exit msvcrt.dll  ; we specify the external library that defines the symbol
import fopen msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions

; our variables are declared here (the segment is called data) 
segment data use32 class=data

    accessMode db 'r', 0
    fileName db 'lab8pb18.txt', 0
    fileDescriptor resd 1
    len equ 100
    textFromFile resb len
    numberWords dd 0
    displayMessage db 'The number of words is %d.', 0
    
segment code use32 class=code
start:

;    A text file is given. The text contains letters, spaces and points. Read the content of the file, determine the number of words and display the result on the screen.


    ; inLoop: if (is space or dot AND previous char is a letter): nrWords++
    ; outsideLoop:   if (last char is letter): nrWords++
   
    push dword accessMode
    push dword fileName
    call [fopen]
    add esp, 4*2
    mov [fileDescriptor], eax
    
    push dword [fileDescriptor]
    push dword len
    push dword 1
    push dword textFromFile
    call [fread]
    
    mov ecx, eax
    mov bl, [textFromFile + ecx-1]
    dec ecx
    loop1:
        mov dl, [textFromFile + ecx-1] ; dl = i-1, bl = i
        cmp dl, '.'
        jz Ok
        cmp dl, ' '
        jnz notOk
        Ok:
        cmp bl, '.'
        jz notOk
        cmp bl, ' '             
        jz notOk ;          if (bl letter AND dl not letter):  numberWords += 1  
        
            add byte[numberWords], 1
        
        notOk:
        mov bl, dl
    loop loop1
    ; Checking the first char is letter:
    mov bl, byte[textFromFile]
    cmp bl, '.'
    jz notLetter
    cmp bl, ' '
    jz notLetter
        ; If it's a letter, increase number of words
        add byte[numberWords], 1
    notLetter:
    
    ;Closing the file:
    push dword [fileDescriptor]
    call [fclose]
    add esp, 4
    
    ;Printing the result:
    push dword[numberWords]
    push dword displayMessage
    call [printf]
    
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program