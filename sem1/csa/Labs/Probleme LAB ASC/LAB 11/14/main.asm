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
extern concatenate_words   

segment data use32 class=data
    n dd 0
    n_format db "%d",0
    format_print db 10,'%s',10,0
    
    i dd 0
    s times 100 db 0
    result times 300 db 0
    
    message_sentence db 10,"Enter sentence %d: ",0
    message_n db 10,"Enter n: ",0

    
segment code use32 class=code
    start:
    ;print Enter n:
    push dword message_n
    call [printf]
    add esp,4*1
    
    ;reading n
    push dword n
    push dword n_format
    call [scanf]
    add esp,4*2  
    
    
    push dword s
    call [gets]
    add esp, 4
    
    xor ecx,ecx ;clearing ecx to use as index
    
    loop_sentences:
        cmp ecx,[n]
        jae done_looping
    pushad
        ;print entering the sentence index
        push ecx
        push dword message_sentence
        call [printf]
        add esp,4*2
    popad
    
    
    pushad
        ;reading one sentence
        push dword s
        call [gets]
        add esp, 4
    popad
        
        
        
    pushad
        ;concatenate_words(s,result,i) - taking the i'th word from string s and adding it to end of result
        push dword ecx
        push dword result
        push dword s
        call concatenate_words
        add esp,4*3
    popad
        
        inc ecx
    jmp loop_sentences
    done_looping:
    
    ; printing the obtained sentence
    push dword result
    push dword format_print
    call [printf]
    add esp,4*2
    jmp done
    
    
    done:

        push    dword 0
        call    [exit]
