section .data
	m1: db "Enter the first string: ", 0Ah
	l1: equ $-m1
	msg2 : db "Enter the second string : ",0Ah
	len2 : equ $-msg2
	m2: db "The sorted order is:", 0Ah
	l2: equ $-m2
	m3: db  0Ah
	l3: equ $-m3
	m4: db  " "
	l4: equ $-m4
	
section .bss
	flag: resb 1	
	rank: resb 20	
	str: resb 200
	temp1: resb 1
	second: resb 10
	first: resb 10
	copy: resb 200
	nos: resb 1
	i: resb 1
	j: resb 1
	temp: resb 1
	temp2: resb 1

section .data
	global _start
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, m1
	mov edx, l1
	int 80h
	mov byte[nos], 0
	mov ecx, str
	
reading:
	push ecx
	
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	
	pop ecx	
	
	cmp byte[temp], 10
	je stepbetween

	cmp byte[temp], 32
	je storenext
	
	continue:	
	mov al, byte[temp]
	mov byte[ecx], al
	inc ecx
	
	jmp reading
	
stepbetween:
  pusha
   mov eax,4
   mov ebx,1
   mov ecx,msg2
   mov edx,len2
   int 80h
  
  popa

  mov ecx,' '
  inc ecx
  jmp storenext2
 

reading2:
       
      

	push ecx
	
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	
	pop ecx	
	
	cmp byte[temp], 10
	je end_read

	cmp byte[temp], 32
	je storenext2
	
	continuenext:	
	mov al, byte[temp]
	mov byte[ecx], al
	inc ecx
	
	jmp reading2
	


end_read:
	mov byte[i], 0
	mov al, byte[nos]
	mov byte[temp], al
	dec byte[temp]
	loopi:
		mov byte[j], 0
		loopj:
			mov al, byte[j]
			;inc al
			mov bl, 10
			mul bl
			
			mov ebx, str
			add ebx, eax
		
			mov esi, ebx
			mov edi, ebx
			add edi, 10
			add ebx, 10

			push ecx
			mov ecx, 10
			repe cmpsb
			dec esi
			dec edi
			pop ecx
			mov al, byte[esi]
			mov ah, byte[edi]
			cmp al, ah
			jg swap

		continue2:
			inc byte[j]
			mov al, byte[j]
			cmp al, byte[nos]
			je continue1
			jmp loopj
	continue1:
	inc byte[i]	
	mov al, byte[nos]
	cmp byte[i], al
	je printing
	jmp loopi

printing:
	

	mov eax, 4
	mov ebx, 1
	mov ecx, m2
	mov edx, l2
	int 80h
	mov byte[temp2], 0
	print:	
		mov al, byte[temp2]
				
		cmp byte[nos], al
		jl exit
		mov ecx, str
		mov al, byte[temp2]	
		mov bl, 10
		mul bl
		add ecx, eax
		mov byte[temp1], 10
		inner:
			cmp byte[temp1], 0
			je printcontinue
			
			push ecx
			mov al, byte[ecx]
			mov byte[temp], al
		
			mov eax, 4
			mov ebx, 1
			mov ecx, temp
			mov edx, 1
			int 80h
		
			pop ecx
			inc ecx
			dec byte[temp1]
			jmp inner
		printcontinue:	
			mov eax, 4
			mov ebx, 1
			mov ecx, m4
			mov edx, l4
			int 80h
		
		inc byte[temp2]
		jmp print
exit:
		
      mov eax,4
      mov ebx,1
      mov ecx,m3
      mov edx,1
      int 80h

	mov eax, 1
	mov ebx, 0
	int 80h




storenext:
	
	mov al, 10
	mov bl, byte[nos]
	inc bl
	mul bl
	inc byte[nos]
	mov ecx, str
	add ecx, eax
	jmp reading


storenext2:
	
	mov al, 10
	mov bl, byte[nos]
	inc bl
	mul bl
	inc byte[nos]
	mov ecx, str
	add ecx, eax
	jmp reading2
	

swap:
		pusha	
		mov edx, ebx
		mov ecx, 10
		mov edi, first
		mov esi, edx
		rep movsb
		
		mov edi, edx
		sub edx, 10
		mov esi, edx
		mov ecx, 10
		rep movsb
		
		mov edi, edx
		mov esi, first
		mov ecx, 10
		rep movsb
		popa
		jmp continue2
		
