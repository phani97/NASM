section .data
 msg1: db "enter first number:",0Ah
 len1: equ $-msg1
 msg2: db "enter second number:",0Ah
 len2: equ $-msg2
 msg3: db "Sum :", 0Ah
 len3: equ $-msg3
 msg4: db 0Ah
 len4: equ $-msg4

section .bss
 number1: resw 1
 number2: resw 1
 sum: resw 1
 temp: resb 1
 nod: resb 1
 
section .text
 global _start:
   _start:
   
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

mov word[number1], 0
mov word[number2], 0
  
read1:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
    
cmp byte[temp], 10
je print2
    
mov ax, word[number1]
mov bx, 10
mul bx
movzx bx, byte[temp]
sub bx, 30h
add ax, bx
mov word[number1], ax
jmp read1 

print2: 
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

read2:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
    
cmp byte[temp], 10
je add
    
mov ax, word[number2]
mov bx, 10
mul bx
movzx bx, byte[temp]
sub bx, 30h
add ax, bx
mov word[number2], ax
jmp read2 

add:
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h
    
mov ax, word[number1]
mov bx, word[number2]
add ax, bx
mov word[sum], ax
mov ax, word[sum]

extract_no:
cmp word[sum], 0
je print_no
inc byte[nod]
mov dx, 0
mov ax, word[sum]
mov bx, 10
div bx
push dx
mov word[sum], ax
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
mov ecx,msg4
mov edx,len4
int 80h
mov eax,1
mov ebx,0
int 80h
