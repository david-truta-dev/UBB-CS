bits 32
global _concatenate_words
extern _printf
segment data public data use32


segment code public code use32
_concatenate_words:
	push ebp
	mov ebp,esp  
    
    mov esi,[ebp+20] ; address of sentences
    mov edi,[ebp+8]    ; address of result
    ; 2d array el. address formula: a[i][j] = a+cols*i+j
    
    mov ecx,0
    .parse_whole:
        cmp ecx,[ebp+12]
        jae .fin
        
        mov eax,[ebp+16] ;101
        mul ecx ; edx:eax = cols*i
        add eax,[ebp+20]
        mov esi,eax ;adresa inceput prim element de pe linia ecx
        
        xor edx,edx
        
        .parse_sentences:
            lodsb
            cmp al,0
            je .over
            
            cmp ecx,edx
            jne .cont
            stosb
            
            .cont:
            cmp al,' '
            jne .cont_parsing
            inc edx
            .cont_parsing:
        jmp .parse_sentences
        
    .over:
    
    inc ecx
    jmp .parse_whole
    
    .fin:
        
        mov al,0
        stosb
    
    mov esp, ebp
    pop ebp
    ret
    