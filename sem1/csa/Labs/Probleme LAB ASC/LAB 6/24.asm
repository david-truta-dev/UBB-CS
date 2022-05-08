; Being given a string of doublewords, build another string of doublewords which will include only the doublewords from the given string which have an even number of bits with the value 1.


; for element in S:
;   set_bits = 0
;   while (element != 0):
;       set_bits += last_bit_of_element
;       element = element >> 1
;   if not (set_bits and 1):
;       D.add_element(element) 


bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    S dd 0BBBD4CD5h, 3h, 3, 1, 0Fh, 0Ah, 111b, 2, 4, 8, 0, 00101011b, 0BBBD4CD7h
    lenS equ ($-S)/4
    D resd 1
    ; D = BBBD4CD5h (it has 20 set bits), 3, 3, F, A, 0, 2B

; our code starts here
segment code use32 class=code
    start:
        cld                 ; DF <- 0, parsing to the right
        mov ECX, lenS       ; ECX <- length of S
        mov ESI, S          ; ESI <- start of the string S
        mov EDI, D          ; EDI <- start of the string D
        
        jecxz end_parse_S   ; finish the program if S is empty
        
        parse_S:
            ; for each element in the string S, repeat: 
            
            lodsd           ; EAX <- the current element of S
            push EAX        ; the initial value of EAX is stored in the stack
            mov BL, 0       ; count of 1 bits in the current element of S
                
                ; loop to shift the bits of EAX (the current element) to the right and add them in BL (counter)
                shr EAX, 1          ; the last bit is stored in CF and EAX is shifted once to the right
                bit_parse_loop:
                adc BL, 0           ; BL <- BL + CF (we add the last bit of EAX to BL)
                shr EAX, 1          ; CF <- last bit of EAX ; EAX = EAX / 2
                jnz bit_parse_loop  ;   jump to the start of the loop is EAX is not zero (there are still set bits in EAX)
                adc BL, 0           ; add the last bit to the counter
            
            pop EAX         ; restore EAX
            
            test BL, 1      ; if the value of BL is even, its last bit is 0 <-> (BL AND 1) == 0
                            ; -> we go to the next element of S if the result of the TEST is not zero 
            jnz end_parse
            
            stosd ; we store EAX into the string D
            
            end_parse: 
        loop parse_S
 
        end_parse_S:
        
        ; EDX <- length of string D
        mov EDX, EDI
        sub EDX, D
        shr EDX, 2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
