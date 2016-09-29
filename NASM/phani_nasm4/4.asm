section .data
	msg1: db "Enter number1:"
	len1: equ $-msg1
	msg2: db "Enter number2:"
	len2: equ $-msg2
	msg3: db 0Ah
	len3: equ $-msg3
	msg4: db "GCD:"
	len4: equ $-msg4
	msg5: db "Invalid input"
	len5: equ $-msg5


section .bss
	num1 : resw 1
	num2 : resw 1
	gcd : resw 1
	temp : resb 1
	nod : resb 1
	input: resw 1

section .text
 global _start:
   _start:

   mov eax,4
   mov ebx,1
   mov ecx,msg1
   mov edx,len1
   int 80h

   mov word[input],0
   call read_num
   mov ax,word[input]
   mov word[num1],ax

   mov eax,4
   mov ebx,1
   mov ecx,msg2
   mov edx,len2
   int 80h

   mov word[input],0
   call read_num
   mov ax,word[input]
   mov word[num2],ax
   
   call GCD

	mov eax,4
	mov ebx,1
	mov ecx,msg4
	mov edx,len4
	int 80h    

   extract_no:
    cmp word[gcd], 0
    je print_no
    inc byte[nod]
    mov edx, 0
    mov ax, word[gcd]
    mov bx, 10
    div bx
    push dx
    mov word[gcd], ax
    jmp extract_no

  print_no:
    cmp byte[nod], 0
    je exit
    dec byte[nod]
    pop dx
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


;;FUNCTIONS

;;GCD
GCD:
	cmp word[num1],0
	je retnum2
	cmp word[num2],0
	je retnum1
	mov ax,word[num1]
	cmp ax,word[num2]
	jge f_s
		mov ax,word[num2]
		sub ax,word[num1]
		mov word[num2],ax
		call GCD
		ret

	f_s:
		mov ax,word[num1]
		sub ax,word[num2]
		mov word[num1],ax
		call GCD
		ret 

	retnum2:
		mov ax,word[num2]
		mov word[gcd],ax
		ret

	retnum1:
		mov ax,word[num1]
		mov word[gcd],ax
		ret	 

;;Read Function
read_num:
	pusha
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
	    
	    mov ax, word[input]
	    mov bl, 10
	    mul bl
	    movzx bx, byte[temp]
	    sub bx, 30h
	    add ax, bx
	    mov word[input], ax
	    jmp loop_read

	 next:
	    popa
	    ret


;;Print Fucntion

invalid:
	mov eax,4
	mov ebx,1
	mov ecx,msg5
	mov edx,len5
	int 80h
	jmp exit