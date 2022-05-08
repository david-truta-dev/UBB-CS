bits 32

global function

segment data use32 class=data

segment code use32 public code


function:

    mov esi,[esp+4] ; address of first string
    mov edx,[esp+8] ; address of second string
    mov edi,[esp+12] ; address of result string
    
    xor ebx,ebx
    start_comparing:
        lodsb       ; al=el of first string
        cmp al,[edx]    ; [edx] = el of second string
        jne go_on       ; found a difference
            mov ebx,1   ; mark that we have a prefix
            stosb   ; the elements are equal so we store them in result
        inc edx
    jmp start_comparing
    go_on:
        
    mov al,0
    stosb
    mov eax,ebx ;returns 1 if we have a prefix; else 0
    
    ret