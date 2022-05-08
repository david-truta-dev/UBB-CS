bits 32 ; assembling for the 32 bits architecture
; Zachman Roxana 917/2
; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,fclose,fread,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll                              ; exit is a function that ends the calling process. It is defined in msvcrt.dll   
import fopen msvcrt.dll                             ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fread msvcrt.dll 
import fclose msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; A text file is given. Read the content of the file, determine the lowercase letter with the highest frequency and display the letter along with its frequency on the screen. The name of text file is defined in the data segment.
    file_name db "2_7.asm", 0
    access_mode db "r", 0
    file_descriptor dd -1
    char_number dd 0
    len equ 100
    buffer resb len
    
    freq_array resd 26  ; the number of appearances of each lowercase letter
    Max dd 0            ; the maximum number of appearances
    message db "The lowercase letter with the highest frequency is: %c",10,"The letter %c appeared %d times.",10,10,0
    
    bad_message db "There were no lowercase letters. :(",0
    bool_lwc db 0   ; 0 if there are no lowercase letters, 1 otherwise
    
    letters resd 27     ; array of letters that appeared Max times; 
    len_letters db 0    ; length of that array
    
    good_offset dd 0    ; asta e o micunealta secreta
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; eax = fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0                  
        je final
        
        mov [file_descriptor], eax
        
        read_from_file:
            ; eax = fread(buffer, 1, len, file_descriptor)
            push dword [file_descriptor]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            
            cmp eax, 0
            je close_file

            mov [char_number], eax
            
            ;
            mov ecx, [char_number]
            mov esi,buffer ; so we read some characters and now we parse through them
                solve:
                    mov eax,0
                    lodsb ; al = current char
                    cmp al,'a' ; see if it is lowercase letter
                    jb not_stuff
                    cmp al,'z'
                    ja not_stuff
                    
                    
                    ; D = [freq_array + 4*3]
                    mov [bool_lwc],byte 1   ; we found at least one lowercase letter
                    mov edx,0
                    mov dl,al
                    sub dl,97               ; edx keeps the index of the current char (0 - 25)
                    
                    
                    mov al,dl ; al = the index of the current char
                    mov bl,4  ; bl = 4
                    mul bl    ; ax = al*bl
                    mov dx,ax ; edx = letter_index * 4
                    
                    
                    mov [good_offset],dword freq_array      ; store in the good_offset the starting address of freq_array
                    add [good_offset], edx                  ; add the proper index have the address of the dword of the appearances of the current char
                    mov edx,[good_offset]                   ; now edx has that address
                    inc dword [edx]                         ; increment the value from that address
                    
                    not_stuff:
                loop solve
            jmp read_from_file
        
        close_file:
        push dword [file_descriptor]
        call [fclose]
        add esp, 4*1
      
        cmp byte [bool_lwc], 0
        jne all_good
      
            push dword bad_message
            call [printf]
            add esp, 4*1
            jmp final
      
        all_good:
        mov edi,letters
        cld
        mov ecx,26
        find_max:
            mov eax,0
            mov ebx,0
            mov edx,0
            mov dl,26
            sub dl,cl ; edx will take indexes from 0 to 25
            
            mov al,dl
            add al,97 ; eax will take each current letter a-z
            
                    push eax    ; save eax
                    mov al,dl
                    mov bl,4
                    mul bl
                    mov dx,ax ; edx = letter_index*4
                    pop eax     ; get eax back
                    
            mov ebx,[Max]
            mov [good_offset],dword freq_array ; take the offset of starting of array
            add [good_offset], edx             ; now has the offset of current element of array
            ; good_offset - offset of this variable; [good_offset] - the value, which is also an offset. a good one
            mov edx,[good_offset]              ; edx takes the offset of the current element of array
            mov edx, dword [edx]                       ; edx takes the value of the current element of array (number of appearances of current char)
            
            cmp ebx,edx     ; compares the max(ebx) with number of appearances of current char
            ja not_stuff_again
            ; the stuff below has the same effect as
            ;if(Max<freq_array[i])
            ;{
            ;    len_letters = 1;
            ;    letters[len_letters] = 97+i; (the current char)
            ;    Max = freq_array[i];
            ;}
            ;else if(Max == freq_array[i])
            ;    letters[len_letters++] = 97+i;
            je same_max
                mov edi,letters
                mov [len_letters], byte 1
                stosd
                mov ebx,edx
                mov [Max],ebx
                jmp not_stuff_again
            same_max:
                inc byte [len_letters]
                stosd
            not_stuff_again:
        loop find_max
        
        mov ebx,0
        mov ebx,[Max]
        
        mov ecx,0
        mov cl, byte [len_letters]
        mov esi,letters
        
        print_stuff:
        
            lodsd
        pushad                      ; have to save the registers because the function call messes with them
            push dword ebx
            push dword eax
            push dword eax
            push dword message
            call [printf]
            add esp, 4*4
        popad
        loop print_stuff
        final:  
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
