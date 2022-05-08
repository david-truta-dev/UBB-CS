bits 32 ;assembling for the 32 bits architecture
global start

; we ask the assembler to give global visibility to the symbol called start 
;(the start label will be the entry point in the program) 
extern exit ; we inform the assembler that the exit symbol is foreign; it exists even if we won't be defining it
import exit msvcrt.dll  ; we specify the external library that defines the symbol
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions

; our variables are declared here (the segment is called data) 
segment data use32 class=data

    sir DD 12345678h, 1256ABCDh, 12AB4344h
    len equ ($ - sir)/4 ; length of second loop
    res resb len
    
segment code use32 class=code
start:
;    A string of doublewords is given. Order in decreasing order the string of the low words (least significant) from these doublewords. The high words (most significant) remain unchanged.
;   Example:
;   being given
;       sir DD 12345678h 1256ABCDh, 12AB4344h
;   the result will be
;       1234ABCDh, 12565678h, 12AB4344h. 
    
    mov ecx, len
    jecxz empty
    mov edi, res
    
    Iloopstart:
        
        ; This loop puts the low words in their place
        mov esi, sir
        mov edx, [sir]
        push ecx
        
        mov ecx, len
        Jloopstart:
            lodsd
            
            cmp ax, dx
            JB bigger  ; jump if ax < dx
                mov edx, [esi - 4]
                mov ebx, esi
            bigger:
            
        Loop Jloopstart
        
        ; we are going to have the addres of the maximal value of the low word from SIR in EBX - 4
        ; and the value in DX
        
        mov word [ebx-4], 0
        pop ecx
        mov ax, dx
        stosd ; store in RES the maximal word  
        
    Loop Iloopstart
        
    mov esi, sir
    mov edi, res
    mov ecx, len
    
    Cloopstart:
        ; This loop puts the high words in their place
            lodsd
            ror eax, 16
            
            add edi, 2
            stosw 
             
    Loop Cloopstart
        
    empty:
    
    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program