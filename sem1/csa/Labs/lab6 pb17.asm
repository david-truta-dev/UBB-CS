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
    l1 equ ($ - sir)/4 ; length of second loop
    l2 equ l1 - 1 ; length of first loop
    
segment code use32 class=code
start:
;    A string of doublewords is given. Order in decreasing order the string of the low words (least significant) from these doublewords. The high words (most significant) remain unchanged.
;   Example:
;   being given
;       sir DD 12345678h 1256ABCDh, 12AB4344h
;   the result will be
;       1234ABCDh, 12565678h, 12AB4344h. 
    
    mov ecx, l1
    jecxz empty ; if string is empy jump to empty label
    
    mov esi, 0 ; mov 0 in esi
    Iloopstart:
        mov edi, esi 
        inc edi ; edi = esi + 1
        
        Jloopstart:
            mov eax, [sir + esi*4] ; eax gets the value from the address (sir + i*4)
            mov ebx, [sir + edi*4] ; ebx gets the value from the address (sir + j*4)
            
            cmp ax, bx
            JA bigger  ; jump if ax > bx
                ; exchange lower word value from address (sir + i*4) with lower word value from (sir + j*4)
                mov word [sir + esi*4],bx
                mov word [sir + edi*4],ax
            bigger:
            
            inc edi; edi += 1
            cmp edi, l1; sets ZF to 1 if they have the same length as l1
        JNZ Jloopstart ; jumps if ZF is 0
        
        inc esi ; esi += 1
        cmp esi,l2 ; sets ZF to 1 if they have the same length as l2
    JNZ Iloopstart
    
    empty:
    
    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program