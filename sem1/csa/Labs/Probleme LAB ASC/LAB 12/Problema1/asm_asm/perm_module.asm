bits 32 

; void perm_str(char * str){
;   char aux = str[0];
;   int i = 0;
;   while(str[i] != 0){str[i] = str[i + 1];}
;   str[i - 1] = aux;}


global perm_str

segment data use32 class=data

segment code use32 class=code

    perm_str:
        ; save the register values on the stack
        push esi
        push edi
        push ecx
        push edx  
        mov esi, [esp + 4 + 4 * 4]      ; ESI = string
        mov dh, [esi]                   ; DH = string[0]
        
        lea edi, [esi + 1]
        cld
        permute_characters:
            cmp byte [edi], 0   ; if(string[i + 1] == 0) break;
            je stop_perm
            
            mov dl, [edi]   ; aux = string[i + 1]
            mov [esi], dl   ; string[i] = string[i + 1] 
            inc esi         ; i++
            inc edi

            jmp permute_characters
        stop_perm:
        
        mov [esi], dh       ; string[length - 1] = string[0];
        
        ; clean the stack
        pop edx
        pop ecx
        pop edi
        pop esi
        ret