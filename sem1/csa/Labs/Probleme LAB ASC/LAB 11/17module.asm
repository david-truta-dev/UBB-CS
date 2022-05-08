bits 32                         
segment code use32 public class=code
global function

    function:
        mov eax, [esp + 4]
        mov ebx, [esp + 8]
        ; The function compares the two values and returns 
        ; the smaller one (unsigned)        
        cmp eax, ebx
        jb smaller
        mov eax, ebx
        smaller:
    
	ret