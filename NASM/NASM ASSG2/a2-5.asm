section .data
Error1:	db	"ERROR: Number of elements has to be more than 1",0Ah
Error1_len: equ	$-Error1
msg3:	db	"Enter  Elements ",0Ah
msg3_len: equ	$-msg3
msg2:	db	"The Second smallest Number is "
msg2_len: equ	$-msg2


section .bss
rnum:	resw 1
pnum:	resw 1
num:	resw 1
min:	resw 1
min2:	resw 1
temp:	resb 1
nod:	resb 1
n:		resw 1

section .text

global _start



_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, msg3_len
	int 80h
	
	
	
	mov word[n], 10
	sub word[n], 2
	
	 call read_num
	mov word[min], ax
	
	call read_num
	cmp ax, word[min]
	jb axIsmin
	
	mov word[min2], ax
	jmp loopReadingArray
	
	axIsmin:
		mov bx, word[min]
		mov word[min2], bx
		mov word[min], ax
	
	loopReadingArray:
	cmp word[n], 0
	je endOfLoop
	call read_num
	cmp ax, word[min]
	jb gotNewmin
	cmp ax, word[min2]
	jb gotNewmin2
	jmp next
	gotNewmin:
		mov bx, word[min]
		mov word[min2], bx
		mov word[min], ax
		jmp next
	
	gotNewmin2:
		mov word[min2], ax
		jmp next
		
	next:
	dec word[n]
	jmp loopReadingArray
	
	endOfLoop:
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, msg2_len
	int 80h
	
	mov ax, word[min2]
	call print_num
	
	mov byte[temp], 0Ah
	mov eax, 4
	mov ebx, 1
	mov ecx, temp
	mov edx, 1
	int 80h
	
	Exit:
	mov eax, 1
	mov ebx, 0
	int 80h
	
	

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
