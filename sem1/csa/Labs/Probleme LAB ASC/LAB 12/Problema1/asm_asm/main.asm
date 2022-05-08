bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
extern scanf
extern printf
import scanf msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

extern perm_str
extern convert_num_to_hexa_string

segment data use32 class=data
    number dd 0
    hex_string dd 0
    repr_length dd 0
    input_msg db "Enter a number: ", 0
    input_read db "%d", 0
    new_line db 10, 0
    output_msg db "The circular permutations of the hexadecimal representation of the number are: ", 10, 0

; An unsigned number a on 32 bits is given. Print the hexadecimal representation of a, but also the results of the circular 
; permutations of its hex digits.

; our code starts here
segment code use32 class=code
    start:
        ; read input
        push dword input_msg
        call [printf]
        add esp, 4
        
        push dword number
        push dword input_read
        call [scanf]
        add esp, 4 * 2
        
        ; convert number to hexa string
        ; EAX = the address to the string
        push dword repr_length
        push dword [number]
        call convert_num_to_hexa_string
        add esp, 4 * 2
        mov [hex_string], eax
        
        ; print the representation and its permutations
        push output_msg
        call [printf]
        add esp, 4
        
        mov ebx, [repr_length]          ; ebx = length of the representation
        print_loop:
            ; print the representation
            push dword [hex_string]
            call [printf]
            add esp, 4
            ; add a newline
            push new_line
            call [printf]
            add esp, 4
            
            ; permute the string
            push dword [hex_string]
            call perm_str
            add esp, 4
            
            dec ebx
            jnz print_loop
            
            jmp exit_print_loop
        
        exit_print_loop:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
