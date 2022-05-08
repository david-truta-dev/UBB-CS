bits 32
global start

extern scanf
extern printf
extern exit
extern fopen
extern fclose
extern fprintf
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll
import fprintf msvcrt.dll

extern function

    ; 17. Read a string of unsigned numbers in base 10 from keyboard. 
    ; Determine the minimum value of the string and write it in the 
    ; file min.txt (it will be created) in 16 base.
    
segment data use32 class=data
    
    len db 0
    input dd 0
    min dd 0xFFFFFFFF
    dformat db '%d', 0
    hformat db '%x', 0
    access_mode db 'w', 0
    file_name db 'min.txt', 0
    file_descriptor resd 1  
    how_many db "Enter how many numbers do you want to give: ", 10, '>', 0
    give_number db "Enter a positive number in base 10: ", 0

segment code use32 class=code
    start:
        ; We print the message "Enter how many numbers do you want to give: "
        push dword how_many
        call [printf]
        add esp, 4
        
        ; The input from the user will be len 
        push dword len
        push dword dformat
        call [scanf]
        add esp, 4*2
        
        ; We repeat this loop len times
        mov ecx, [len]
        read:
            ; We print the message "Enter a positive number in base 10: "
            pushad
            push dword give_number
            call [printf]
            add esp, 4
            
            ; We put the number in the input variable
            push dword input
            push dword dformat
            call [scanf]
            add esp, 4*2
            
            ; We call a function which compares two numbers and returns 
            ; the smaller one (unsigned)
            ; Initial min will be the biggest number on 32 bits (FFFFFFFFh)
            push dword [input]
            push dword [min]
            call function
            add esp, 4*2
            
            ; We will put the smaller value in min
            mov [min], eax
            popad
        loop read
        
        ; We print the minimum value in 16 base
        push dword [min]
        push dword hformat
        call [printf]
        add esp, 4*2
        
        ; We write in the file min.txt the minimum value in 16 base
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        mov [file_descriptor], eax
        
        push dword [min]
        push dword hformat
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*3
        
        push dword [file_descriptor]
        call [fclose]
        
    push    dword 0
    call    [exit]
    