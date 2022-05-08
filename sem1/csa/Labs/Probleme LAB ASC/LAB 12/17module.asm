bits 32
global _function
segment data use32 class=data

segment code use32 class=code
    
    _function:
        push ebp
        mov ebp, esp
        
        mov eax, [ebp + 8]
        mov ebx, [ebp + 12]
        ; The function compares the two values and returns 
        ; the smaller one (unsigned)  
        cmp eax, ebx
        jb smaller
        mov eax, ebx
        smaller:
        
        mov esp, ebp
        pop ebp
        
    ret