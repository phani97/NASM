section .bss

  array:  resb 50
  element: resb 1
  num: resb 1
  pos: resb 1
  temp: resb 1
  ele: resb 1
  rnum: resw 1
  count :resb 1
  pnum: resw 1
  nod: resb 1


section .data

msg1: db "Enter the number of numbers : "
size1: equ $-msg1
msg2: db "Enter a number:"
size2: equ $-msg2
msg3: db "Enter the number to be searched : "
size3: equ $-msg3
msg_found: db "Element found at position : "
size_found: equ $-msg_found
msg_not: db "Element not found"
size_not: equ $-msg_not

section .text
  global _start

_start:
  

;Printing the message to enter the number
  mov eax, 4
  mov ebx, 1
  mov ecx, msg1
  mov edx, size1
  int 80h
  
  call read_num
	mov byte[num], al
   mov byte[count], al
  
  

  mov ebx, array
  

reading:
  
  push ebx

  ;Printing the message to enter the numbers
  mov eax, 4
  mov ebx, 1
  mov ecx, msg2
  mov edx, size2
  int 80h
  
 call read_num


  ;al now contains the number
  pop ebx

  mov byte[ebx], al

  add ebx, 1

  dec byte[count]
  cmp byte[count], 0
  jg reading

  ;Reading the number to be searched :.....

  mov eax, 4
  mov ebx, 1
  mov ecx, msg3
  mov edx, size3
  int 80h
  
call read_num

  mov byte[ele], al

  
  movzx ecx, byte[num]

  mov ebx, array
  mov byte[pos], 1

searching:
 
  mov al , byte[ebx]

  cmp al, byte[ele]
  je found

  add ebx, 1

  add byte[pos], 1
  movzx ax,byte[num]
  movzx cx,byte[pos]
  cmp ax,cx
  jb notfound
  jmp searching
  
 notfound: 
  mov eax, 4
  mov ebx, 1
  mov ecx, msg_not
  mov edx, size_not
  int 80h

exit:
  mov eax, 1
  mov ebx, 0
  int 80h


found:
  mov eax, 4
  mov ebx, 1
  mov ecx, msg_found
  mov edx, size_found
  int 80h
  
  movzx ax, byte[pos]
  call print_num
  jmp exit
  
  read_num:
	pusha
	mov word[rnum], 0
	loop_read:
		mov eax, 3
		mov ebx, 0
		mov ecx, temp
		mov edx, 1
		int 80h
	
		cmp byte[temp], 0Ah
		je end_read
	
		mov ax, word[rnum]
		mov bx, 10
		mul bx
		mov bl, byte[temp]
		sub bl, 30h
		mov bh, 0
		add ax, bx
		mov word[rnum], ax
		jmp loop_read
	
	end_read:
		popa
		mov ax,word[rnum]
		ret
  print_num:
	mov word[pnum], ax
	pusha
	mov byte[nod], 0
	extract_no:
		cmp word[pnum], 0
		je print_no
		inc byte[nod]
		mov dx, 0
		mov ax, word[pnum]
		mov bx, 10
		div bx
		
		push dx
		mov word[pnum], ax
		jmp extract_no
	
	print_no:
		cmp byte[nod], 0
		je end_print
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
		
	end_print:
		popa
		ret
  
