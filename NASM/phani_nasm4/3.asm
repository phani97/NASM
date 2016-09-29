section .data
	msg1: db "Enter the number:"
	len1: equ $-msg1
	msg2: db "Factorial:"
	len2: equ $-msg2
	msg3: db 0Ah
	len3: equ $-msg3
	msg4: db "overflow"
	len4: equ $-msg4
	msg5: db "Invalid input"
	len5: equ $-msg5

section .bss
	num : resd 1
	fact : resd 1
	temp : resb 1
	nod : resb 1


section .text
 global _start:
   _start:

   mov eax,4
   mov ebx,1
   mov ecx,msg1
   mov edx,len1
   int 80h

   mov dword[num],0

   loop_read:
	    mov eax, 3
	    mov ebx, 0
	    mov ecx, temp
	    mov edx, 1
	    int 80h
	    
	    cmp byte[temp], 10
	    je next
	    cmp byte[temp], '-'
	    je invalid
	    
	    mov eax, dword[num]
	    mov bx, 10
	    mul bx
	    movzx ebx, byte[temp]
	    sub ebx, 30h
	    add eax, ebx
	    mov dword[num], eax
	    jmp loop_read

	next:
		cmp dword[num], 12
		jg overflow
		mov dword[fact],1
		call factorial

		   mov eax,4
		   mov ebx,1
		   mov ecx,msg2
		   mov edx,len2
		   int 80h

		extract_no:
		    cmp dword[fact], 0
		    je print_no
		    inc byte[nod]
		    mov edx, 0
		    mov eax, dword[fact]
		    mov ebx, 10
		    div ebx
		    push edx
		    mov dword[fact], eax
		    jmp extract_no

  		print_no:
		    cmp byte[nod], 0
		    je exit
		    dec byte[nod]
		    pop edx
		    mov byte[temp], dl
		    add byte[temp], 30h

		    mov eax, 4
		    mov ebx, 1
		    mov ecx, temp
		    mov edx, 1
		    int 80h
		    
		    jmp print_no
    

 exit:
 	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,len3
	int 80h
	
	 mov eax,1
	 mov ebx,0
	 int 80h


;;FUNCTION FACTORIAL

factorial:
	mov eax,dword[num]
	cmp eax,0
	je ret1
	mov eax,dword[fact]
	mov ebx,dword[num]
	mul ebx
	mov dword[fact],eax
	dec dword[num]
	call factorial
	ret1:
	 ret

overflow:
mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,len4
int 80h
jmp exit

invalid:
	mov eax,4
	mov ebx,1
	mov ecx,msg5
	mov edx,len5
	int 80h
	jmp exit