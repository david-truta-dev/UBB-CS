bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
extern printf 
extern scanf
extern gets 
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll                          
import printf msvcrt.dll   
import scanf msvcrt.dll
import gets msvcrt.dll

extern function   

                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    s1 db "ana are mere.",0
    s2 db "anul nou va fi mai bun.",0
    s3 db "anunt important",0
    result times 201 db 0
    s12msg db "The prefix for s1 and s2 is: %s",10,0
    s23msg db "The prefix for s2 and s3 is: %s",10,0
    s13msg db "The prefix for s1 and s3 is: %s",10,0
    no_prefix db "There is no prefix.",10,0


; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;Three strings (of characters) are given. 
        ;Show the longest prefix for each of the three pairs of two strings that can be formed.
        
        ;Se da inseamna ca acele date pot fi puse direct in segmentul de date;
        ; se citesc inseamna ca acele date trebuie citite de la tastatura.
        ;Daca nu este precizat altfel, sirurile de caractere de pana la 100 de caractere (sirul propriu-zis).
        
    ; function(s1,s2,result)  
    push dword result
    push dword s2
    push dword s1
    call function
    add esp,4*3
    
    cmp eax,0
    jne print12
    
    ;We have no prefix:
    push dword no_prefix
    push dword s12msg
    call [printf]
    add esp,4*2
    jmp over12
    
    ;There is a prefix:
    print12:
    push dword result
    push dword s12msg
    call [printf]
    add esp,4*2
    
    over12:
    ; function(s1,s3,result)
    push dword result
    push dword s3
    push dword s1
    call function
    add esp,4*3
    
    cmp eax,0
    jne print13
    
    push dword no_prefix
    push dword s13msg
    call [printf]
    add esp,4*2
    jmp over13
    
    print13:
    push dword result
    push dword s13msg
    call [printf]
    add esp,4*2
    
    over13:
    
    ; function(s2,s3,result)
    push dword result
    push dword s3
    push dword s2
    call function
    add esp,4*3
    
    
    cmp eax,0
    jne print23
    
    push dword no_prefix
    push dword s23msg
    call [printf]
    add esp,4*2
    jmp over23
    
    print23:
    push dword result
    push dword s23msg
    call [printf]
    add esp,4*2
    over23:
        

        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
