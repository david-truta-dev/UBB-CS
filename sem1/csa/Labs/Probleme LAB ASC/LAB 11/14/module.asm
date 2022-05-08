bits 32
global concatenate_words
segment data public data use32
segment code public code use32

concatenate_words:
    
    mov esi,[esp+4]     ; address of sentence
    mov edi,[esp+8]     ; address of result
    mov ebx,[esp+12]    ; value of i
    
    go_to_end:
        cmp byte [edi],0
        je good_edi
        inc edi
    jmp go_to_end
    
    good_edi:       ; edi will point to end of result so we can add the words to the end
    
    xor edx,edx    ;use edx as index
    
    .parse_sentences:
        lodsb
        cmp al,0
        je .fin     ;if al == 0 we reached end of sentence
        
        cmp ebx,edx
        jne .cont
        stosb       ;add letters to edi only when we reach the i'th word
        
        .cont:
        cmp al,' '
        jne .cont_parsing
        inc edx ;edx increases only when we advance to another word
        
        .cont_parsing:
    jmp .parse_sentences
    
    .fin:
        mov al,0 
        stosb  ;add null character at the end of the string
    
    ret
    