bits 32 
global calc_result
segment data use32 class=data
   
segment code use32 class=code
    calc_result:
        mov eax, [esp + 4]
        mov ebx, [esp + 8]
        mov ecx, [esp + 12]
        
        add eax, ebx
        sub eax, ecx
    
    ret