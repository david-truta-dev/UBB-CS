bits 32 


global start        


extern exit, scanf, printf       
import exit msvcrt.dll    
import scanf msvcrt.dll    
import printf msvcrt.dll    
               
extern put_lower
extern put_upper
               

segment data use32 class=data
    scanf_format db "%100[^",10,"]", 0
    printf_format db "lower: %s", 10, "upper: %s", 0
    
    upper resb 105
    input resb 105
    lower resb 105

segment code use32 class=code
    start:
        push input
        push scanf_format
        call [scanf]
        
        mov esi, input
        mov edi, lower
        call put_lower

        mov esi, input
        mov edi, upper
        call put_upper
        
        push upper
        push lower
        push printf_format
        call [printf]
        
        push dword 0      
        call [exit]       
