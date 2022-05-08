bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,printf,convert               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;#24: Sa se citeasca un sir s1 (care contine doar litere mici). Folosind un alfabet (definit in segmentul de date), determinati si afisati sirul s2 obtinut prin substituirea fiecarei litere a sirului s1 cu litera corespunzatoare din alfabetul dat.Exemplu:
    ;Alfabetul: OPQRSTUVWXYZABCDEFGHIJKLMN
    ;Sirul s1:  anaaremere
    ;Sirul s2:  OBOOFSASFS
    
    alphabet db "OPQRSTUVWXYZABCDEFGHIJKLMN",0
    s1 resb 100
    s2 resb 100
    
    m1 db "Enter string:",0
    m2 db "The converted string is:",0
    
    format db "%s",0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;getting input
        push dword m1
        call [printf]
        add esp, 4*1
        
        push dword s1
        push dword format
        call [scanf]
        add esp, 4*2
        
        ;calling the function
  
        push dword s1
        push dword s2
        push dword alphabet
        call convert  
        add esp, 4*3
        
        ;printing result
        push dword m2
        call [printf]
        add esp, 4*1
        
        push dword s2
        push dword format
        call [printf]
        add esp, 4*2
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
