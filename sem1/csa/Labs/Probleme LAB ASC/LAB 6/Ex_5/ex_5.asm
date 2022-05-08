bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; Two byte strings s1 and s2 are given. Build the byte string d such that, for every byte s2[i] in s2, d[i] contains either the position of byte s2[i] in s1, either the value of 0
segment data use32 class=data
    s1 db  7, 33, 55, 19, 46
    len_1 equ $-s1
    s2 db 33, 21, 7, 13, 27, 19, 55, 1, 46 
    len_2 equ $-s2
    d resb len_2
    

; our code starts here
segment code use32 class=code
    start:
        ;Here is how my "code segment" would look in C++ (I use this scheme because it's mutch easier to build my program in Assembly after I have this)
        ; for (i = 0; i < len(s2) ; i++)
        ;  { 
        ;   for( j = 0; j< len(s1) ; j++)
        ;       if(s2[i] == s1[j]) 
        ;         {  
        ;           d[i] = j + 1;
        ;           break;
        ;         }
        ;   if(j == len(s1))
        ;       d[i] = 0
        ;  }
        
        ; Obs.: the comments which have '...' represent the meaning of that instruction in my C++ scheme
        mov esi, s2 ; esi will contain the start memory address of s2 
        mov edi, s1 ; edi will contain the start memory address of s1
        mov ebx, d ; ebx will contaion the start memory address of d
        
        mov ecx, len_2
        
        jecxz fin
        cld; clear direction flag so we can parse the string from beggining to end
        
        loop_in_s2:
            lodsb ; (move the byte from DS:ESI into AL ('al = s2[i]')
            
            push ecx
            mov ecx, len_1
            mov edi, s1
            
            jecxz append_0
            
            cld ; clear direction flag so we can parse the string from beggining to end
            loop_in_s1:
                mov dl, byte [edi]
                scasb ; compares AL and the byte from ES:EDI ('if(s2[i] == s1[j])')
                jz append_position
                
                loop loop_in_s1

            
            append_0:
                mov byte [ebx], 0 ; 'd[i] = 0'
                inc ebx
                jmp fin_of_loop_in_s2
            
            append_position:
            sub edi, s1
            mov edx, edi
            mov byte [ebx], dl ; 'd[i] = j + 1;'
            inc ebx
            
        
        fin_of_loop_in_s2:
            pop ecx
            loop loop_in_s2
        
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
