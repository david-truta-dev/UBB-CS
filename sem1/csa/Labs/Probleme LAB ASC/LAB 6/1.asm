bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    input  dd   127F5678h, 0ABCDABCDh
    len    equ  ($-input)/4 ; length of the string in quadwords
    output resb len         ; where the results gets stored

; our code starts here
segment code use32 class=code
    start:
        ;   An array with doublewords containing packed data (4 bytes written as a single doubleword) is given. Write an asm program in order to obtain a new array of doublewords, where each doubleword will be composed by the rule: the sum of the bytes from an odd position will be written on the word from the odd position and the sum of the bytes from an even position will be written on the word from the even position. The bytes are considered to represent signed numbers, thus the extension of the sum on a word will be performed according to the signed arithmetic.
        ;   Example:
        ;   for the initial array:
        ;   12 7F 56 78h, 0ABCDABCDh, ...
        ;   The following should be obtained:
        ;   006800F7h, 0FF56FF9Ah, ... 
            ; in memory, that looks like: F7 00 68 00 | 9A FF 56 FF 
        
        mov esi, input      ; eds:esi stores the FAR address of 'input'
        mov edi, output     ; eds:edi stores the FAR address of 'output'
        cld                 ; DF = 0
        
        mov ecx, len
        jecxz parse_input_fin
        parse_input:
            xor bx, bx      ; using BX to store the sum of the bytes from an odd  position
            xor dx, dx      ; using DX to store the sum of the bytes from an even position
            
            lodsb           ; AL = 1st byte
            cbw             ; AX = AL signed conversion
            add bx, ax      ; BX = BX + AX
            
            lodsb           ; AL = 2nd byte
            cbw             ; AX = AL signed conversion
            add dx, ax      ; DX = DX + AX
            
            lodsb           ; AL = 3rd byte
            cbw             ; AX = AL signed conversion
            add bx, ax      ; BX = BX + AX
            
            lodsb           ; AL = 4th byte
            cbw             ; AX = AL signed conversion
            add dx, ax      ; DX = DX + AX
            
            mov ax, bx
            stosw           ; insert the word AX = BX into EDI, then EDI += 2
            mov ax, dx      
            stosw           ; insert the word AX = DX into EDI, then EDI += 2
        loop parse_input
        parse_input_fin:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
