bits 32

global start        

extern exit         
extern scanf         
extern gets         
extern printf         
import exit msvcrt.dll
import scanf msvcrt.dll
import gets msvcrt.dll
import printf msvcrt.dll
extern is_subsequence   

segment data use32 class=data
    ;Multiple strings of characters are being read. Determine whether the first appears as a subsequence in each of the others and give an appropriate message.
    n dd 0
    n_fr db "%d",0
    i dd 0
    s1 times 100 db 0
    s times 100 db 0
    result times 300 db 0
    format_print db '%s',10,0
    nice_message db 10,"Enter sentence: ",0
    nice_message0 db 10,"Enter n: ",0
    bad_message db "You can read 100 characters max per string.",0
    no_msg db "It is not a subsequence.",0
    yes_msg db "It is a subsequence.",0
segment code use32 class=code
    start:
    push dword nice_message0
    call [printf]
    add esp,4*1
    
    push dword n
    push dword n_fr
    call [scanf]
    add esp,4*2  
    
    push dword s1    ; reads nl char from the end
    call [gets]
    add esp, 4
    
    push dword nice_message
    call [printf]
    add esp,4*1
    
    push dword s1    ; reads the first string
    call [gets]
    add esp, 4
    
    mov ecx,[n]
    dec ecx
    
    loop_strings:
    pushad
        push dword nice_message
        call [printf]
        add esp,4*1
    popad
    pushad
        push dword s
        call [gets]
        add esp, 4
    popad
        cmp byte [result-1],0
        jne bad
        cmp eax,0
        je bad
pushad
        push dword s
        push dword s1
        call is_subsequence
        add esp,4*2
        
        cmp eax,0
        je print_no
        
        pushad
        push dword yes_msg
        call [printf]
        add esp,4*1
        popad
        jmp done_seq
        
        print_no:
        pushad
        push dword no_msg
        call [printf]
        add esp,4*1
        popad
        done_seq:
popad
    loop loop_strings
    
    
    push dword result
    push dword format_print
    call [printf]
    add esp,4*2
    jmp done
    
    bad:
    push dword bad_message
    call [printf]]
    add esp, 4
    
    done:
    
    push    dword 0
    call    [exit]
