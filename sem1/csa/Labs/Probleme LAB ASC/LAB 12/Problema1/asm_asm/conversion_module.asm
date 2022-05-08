bits 32

; char * convert_num_to_hexa_string(int number, int * size){
;  char digits[] = "0123456789ABCDEF";
;  char hex_repr[10];
;  *size = 0;
;  if(number == 0) {*size = 1; return "0";}
;  while(number){
;     hex_repr[*size] = digits[number & F];
;     number /= 4;
;     *size = *size + 1;
;  }
;  for(int i = 0, int j = *size; i != j; i++, j--) swap(hex_repr[i], hex_repr[j]);
; 
;  return hex_repr;}


global convert_num_to_hexa_string

segment data use32 class=data
    hex_representation resb 10
    hex_digits db "0123456789ABCDEF"


segment code use32 class=code
    convert_num_to_hexa_string:
        ; push registers to save their values
        push edi
        push ebx
        push ecx
        push edx
        
        ; convert number to hexa string
        mov edx, [esp + 4 + 4 * 4]   ; EDX = number value
        mov ecx, [esp + 8 + 4 * 4]   ; ECX = pointer to the hexadecimal digit counter
        mov edi, hex_representation  ; ESI = pointer to the representation of the number
        mov dword [ecx], 0
        mov ebx, hex_digits          ; table for rapid conversion
        cld
        
        ; loop through every hex digit (nibble)
        hex_digit_loop:
            mov al, dl  ; get the last byte of the number
            shr edx, 4  ; number = number / 16
            
            and al, 0Fh ; isolate the low 4 bits
            xlat        ; AL = the character representing the digit
            
            stosb       ; save character in the string
            inc dword [ecx]
            
            ; if the number is not 0, we find the next digit
            cmp edx, dword 0
            jne hex_digit_loop
            
            jmp reverse_string
        
        ; reverse the characters in the string
        reverse_string:
        mov eax, [ecx]      ; eax = length of the string / j
        sub edi, eax        ; edi = the beginning of the string
        mov ebx, 0          ; ebx = i
        dec eax
        
        loop_to_reverse:    ; for(i = 0, j = length; i != j; i++, j--) swap(s[i], s[j]);
            ; BL = i; AL = j;
            cmp bl, al      ; if(i => j) break;
            jae end_loop
            
            ; swap(s[i], s[j])
            mov dl, [edi + ebx]   ; DL = s[i]
            mov dh, [edi + eax]   ; DH = s[j]
            mov [edi + ebx], dh   ; s[i] = DH
            mov [edi + eax], dl   ; s[j] = DL
            
            inc bl      ; i++ 
            dec al      ; j--
            
            jmp loop_to_reverse
        
        end_loop:
        
        ; move the string address to EAX
        mov eax, edi
        
        ; clean the stack
        pop edx
        pop ecx
        pop ebx
        pop edi
        ret         ; end the function