bits 32 


global _put_lower
global _put_upper


;void put_lower(char *src, char *dest)
segment code public code use32 
	_put_lower:
		push ebp
		mov ebp, esp   
		pushad 
		
		mov esi, [ebp+8]
		mov edi, [ebp+12]

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
		
		popad
		mov esp, ebp
		pop ebp
		
		ret
    

	_put_upper:
		push ebp
		mov ebp, esp   
		pushad 
		
		mov esi, [ebp+8]
		mov edi, [ebp+12]

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
		
		popad
		mov esp, ebp
		pop ebp
		
		ret
