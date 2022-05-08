bits 32 
global transform_to_binary

segment data use32 class=data
    result_string resb 101
import printf msvcrt.dll
segment code use32 class=code
   transform_to_binary:
        mov eax, [esp + 4] 
        mov ecx, 0
        while_eax_not_0:
            cmp eax, 0
            jz fin_of_proc
            shl eax, 1
            jc add_1
            mov byte [result_string + ecx], 0 
            jmp fin_of_while
            add_1:
                mov byte [result_string + ecx], 1
            fin_of_while:
                inc ecx
        fin_of_proc:
            mov byte [result_string + ecx], 2
            mov eax, result_string
            ret