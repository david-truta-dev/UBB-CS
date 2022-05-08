bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start, a, final_string, string_permutated

; declare external functions needed by our program
extern exit, printf, circular_permutation               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
import printf msvcrt.dll
segment data use32 class=data
    string_permutated times 20 db 0
    final_string times 20 db 0
    a dd 0x572A87
    print_format db "The hex repres of a is: %x", 10, 0
; our code starts here
segment code use32 class=code
    start:
        push dword [a]
        push dword print_format
        call [printf]
        add esp, 4 * 2
        
        call circular_permutation
        
        push dword final_string
        call [printf]
        add esp, 4 * 1

        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
