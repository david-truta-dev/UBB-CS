bits 32 


global put_lower
global put_upper


;void put_lower(char *src, char *dest)
put_lower:
    .iter:
        lodsb
        
        cmp al, 'a'
        jb .skip
        cmp al, 'z'
        ja .skip
        
        stosb
        
        .skip:
    
    cmp byte [esi], 0
    jne .iter
    
    mov al, 0
    stosb
    
    ret
    

put_upper:
    .iter2:
        lodsb
        
        cmp al, 'A'
        jb .skip2
        cmp al, 'Z'
        ja .skip2
        
        stosb
        
        .skip2:
    
    cmp byte [esi], 0
    jne .iter2
    
    mov al, 0
    stosb
    
    ret
