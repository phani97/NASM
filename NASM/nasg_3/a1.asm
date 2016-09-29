section .data
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,length1
int 80h

mov ebx,string

read:
push ebx
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
pop ebx
cmp byte[temp],10
je nextstep
mov al,byte[temp]
mov byte[ebx],al
add ebx,1
jmp read

nextstep:
mov byte[ebx],0
mov ebx,string
print:
cmp byte[ebx],0
je exit
mov al,byte[ebx]
push ebx
cmp al,65
jl dontprint
cmp al,122
jg dontprint
cmp al,90
jg check1
mov byte[temp],al
push ebx
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
pop ebx
add ebx,1
jmp print

check1:
cmp al,97
jl dontprint
mov byte[temp],al
push ebx
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
pop ebx
add ebx,1
jmp print

dontprint:
add ebx,1
jmp print

exit:
mov eax,1
mov ebx,0
int 80h

section .data
msg1: db "enter the string",0Ah
length1: equ $-msg1
msg2: db "i am in dontprint",0Ah
length2: equ $-msg2
msg3: db "i am in check",0Ah
length3: equ $-msg3

section .bss
temp: resb 1
string: resb 50
