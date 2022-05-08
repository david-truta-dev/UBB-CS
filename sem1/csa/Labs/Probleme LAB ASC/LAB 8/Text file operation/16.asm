bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf, fopen, fprintf, fclose              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll  
import fprintf msvcrt.dll
import fclose msvcrt.dll                   
                    ;A text file is given. Read the content of the file, count the number of letters 'y' and 'z' and display the values on the screen. The file name is defined in the data segment.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_fisier dd 0
    textul_din_fisier dd 0
    
    message1 dd "nume fisier:", 0
    message2 dd "text pentru fisier:", 0
    
    formatnume db "%s", 0
    formattext db "%s", 0
    
    mod_acces db "a", 0
    
    descriptor_fis dd -1 ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
                           

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;Read a file name and a text from the keyboard. Create a file with that name in the current folder and write the text ;that has been read to file. Observations: The file name has maximum 30 characters. The text has maximum 120 characters.
        push ebx ; save registers
        push ecx
        
         push dword message1
        call [printf]
        add esp, 4*1 ; remove parameters
        
        push dword nume_fisier ; address of nume_fisier
        push dword formatnume ; 
        call [scanf]
        add esp, 4*2 ; remove parameters 
        
 
        ; apelam fopen pentru a crea fisierul
        ; functia va returna in EAX descriptorul fisierului sau 0 in caz de eroare
        ; eax = fopen(nume_fisier, mod_acces)
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2; eliberam parametrii de pe stiva
        
        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0
        je final
                
        push dword message2
        call [printf]
        add esp, 4*1 ; remove parameters
        
        push dword textul_din_fisier ; address of textul_din_fisier
        push dword formattext ; 
        call [scanf]
        add esp, 4*2 ; remove parameters 
        
                ; adaugam/scriem textul in fisierul deschis folosind functia fprintf
        push dword textul_din_fisier
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*2

        ; apelam functia fclose pentru a inchide fisierul
        ; fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
      final:
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
