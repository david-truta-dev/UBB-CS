bits 32 ;assembling for the 32 bits architecture
global start

; we ask the assembler to give global visibility to the symbol called start 
;(the start label will be the entry point in the program) 
extern exit ; we inform the assembler that the exit symbol is foreign; it exists even if we won't be defining it
extern scanf
extern printf
import exit msvcrt.dll  ; we specify the external library that defines the symbol
import scanf msvcrt.dll
import printf msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions

; our variables are declared here (the segment is called data) 
segment data use32 class=data

    input dd 0
    inputMessage db "Introduceti un numar in baza 10:", 0
    message  db "Numarul citit in baza 16: %x", 0
    format db "%d", 0
    
segment code use32 class=code
start:
;    Read a number in base 10 from the keyboard and display the value of that number in base 16
    ;scanf("%d", input) , printf('numar: %d', 10)
    
    ;print  'Introduceti numarul:'
    push dword inputMessage
    call [printf]
    add esp, 4
    ;citirea numarului
    push dword input
    push dword format
    call [scanf]
    add esp, 4*2
    ;printarea in format hexa(%x)
    push dword &input
    push dword message
    call [printf]
    add esp, 4*2
    
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program