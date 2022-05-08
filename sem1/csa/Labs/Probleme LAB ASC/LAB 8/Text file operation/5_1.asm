; Exercise 5 
; A text file is given. Read the content of the file, count the number of special characters and display the result on the screen.
; The name of text file is defined in the data segment. 
bits 32

global start

extern fopen, fclose
extern fread, printf
extern exit
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll

segment data use32 class=data
    file_name db "text.txt", 0
    file_open_specifier db "r", 0
    print_text db "The number of special characters is: %d", 10, 0
    file_desc dd -1
    len equ 100
    nr_chars_read dd 0    
    text resb 100  
    nr_special_chars dd 0  
    ; spec_chars resb 100

segment code use32 class=code
start:
    ; eax = fopen(file_name, file_open_specifier)
    push dword file_open_specifier
    push dword file_name
    call [fopen]
    
    add esp, 4 * 2
    
    cmp eax, 0                      ; if eax == 0 the file could not be opened
    je finish
    
    mov dword [file_desc], eax            ; save the file_descriptor in eax
    
    ; do {
    ;       nr_chars_read = fread(file_desc, 1, len, text)
    ;       if (nr_chars_read > 0)
    ;           instrunctions on text
    ; while (nr_chars_read != 0);
    
    ; mov edi, dword spec_chars
    loop_1:
    
        ; eax = fread(text, 1, len, file_desc)
        push dword [file_desc]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4 * 4
        
        cmp eax, 0
        je end_of_file                                  ; if eax == 0 we have reach the end of file
        
        mov dword [nr_chars_read], eax                  ; save the number of read characters in nr_chars_read
        
        mov ecx, dword [nr_chars_read]
        
        mov esi, dword text                             ; esi = &text
        
        ; count the number of special characters
        loop_2:
            cmp byte[esi], byte 32                      ; if [esi] <= 33 it is not a graphical character so we jump to not_graphical
            jbe not_graphical
            cmp byte[esi], byte 127                     ; if [esi] == 127 it is not a graphical character so we jump to not_graphical
            je not_graphical
            cmp byte[esi], byte '0'                     ; if [esi] < '0' and [esi] > 32 => it is a special character so we jump to not_alnum
            jb not_alnum
            cmp byte[esi], byte '9'                     ; if '0' <= [esi] <= '9' => [esi] is digit so we jump to is_alnum 
            jbe is_alnum
            cmp byte[esi], byte 'A'                     ; if [esi] > '9' and [esi] < 'A' => [esi] is special character so we jump to not_alnum
            jb not_alnum
            cmp byte[esi], byte 'Z'                     ; if 'A' <= [esi] <= 'Z' => [esi] is alphabetical so we jump to is_alnum
            jbe is_alnum
            cmp byte[esi], byte 'a'                     ; if [esi] > 'Z' and [esi] < 'a' => [esi] is special character so we jump to not_alnum
            jb not_alnum
            cmp byte[esi], byte 'z'                     ; if 'a' <= [esi] <= 'z' => [esi] is alphabetical so we jump to is_alnum
            jbe is_alnum
            
            not_alnum:             
            
            inc dword [nr_special_chars]
            ;movsb
            ;dec esi
            
            is_alnum:
            not_graphical:
        
        inc esi
        loop loop_2
        
        mov ecx, 2                                  ; ecx = 1 so that the loop_1 end only when we finished to read all the characters
    
    loop loop_1
    
    end_of_file:
    
    ; printf("The number of special characters is: %d", nr_special_chars)
    push dword [nr_special_chars]
    push dword print_text
    call [printf]
    add esp, 4 * 2
    
    ; fclose(file_desc)
    push dword [file_desc]
    call [fclose]
    add esp, 4 * 1
    
    finish:
    
    push dword 0
    call [exit]