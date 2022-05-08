; Read two numbers a and b (base 10) from the keyboard and calculate: (a+b)/(a-b). 
; The quotient will be stored in a variable called "result" (defined in the data segment).
; The values are considered in signed representation. 
bits 32

global start

extern exit, scanf, printf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    format_read db "%d", 0
    format_write_a db "a = ", 0
    format_write_b db "b = ", 0
    format_write_result db "The result is: %d", 10, 0
    error_string db "Cannot divide by 0", 10, 0
    a dd 0
    b dd 0
    result resd 1

segment code use32 class=code
start:
    ; printf ("a = ")
    push format_write_a                 
    call [printf]
    add esp, 4
    
    ; scanf ("%d", &a)
    push a
    push format_read
    
    call [scanf]
    
    add esp, 8
    
    ; printf ("b = ")
    push format_write_b
    call [printf]
    add esp, 4
    
    ; scanf ("%d", &b)
    push b
    push format_read
    
    call [scanf]
    
    add esp, 8
    
    ; a + b
    mov eax, [a]
    add eax, [b]
    cdq                     ; expand eax to edx:eax
    
    ; a - b
    mov ebx, [a]
    sub ebx, [b]
    
    jz skip
        ; eax = (a + b) / (a - b)
        ; edx = (a + b) % (a - b)
        idiv ebx
        
        mov [result], eax   ; result = eax
        
        ; printf("The result is: %d\n", result)
        push dword [result]
        push format_write_result
        
        call [printf]
        
        add esp, 8
        
        jmp end
    skip:
    
    ; printf("Cannot divide by 0\n")
    push error_string
    call [printf]
    add esp, 4
    
    end:

    push 0
    call [exit]