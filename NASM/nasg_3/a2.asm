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
mov ecx,string

for1:
cmp byte[ebx],0
je exit
mov al,byte[ebx]
add ebx,1
mov ecx,ebx
sub ebx,1
jmp check1


check1:
cmp byte[ecx],0
je step2
mov dl,byte[ecx]
cmp al,dl
je makeone
add ecx,1
jmp check1

makeone:
mov byte[ecx],1
add ecx,1
jmp check1

step2:
cmp byte[ebx],1
je step3
mov al,byte[ebx]
mov byte[temp],al
push ebx
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
pop ebx
add ebx,1
jmp for1

step3:
add ebx,1
jmp for1

exit:
mov eax,1
mov ebx,0
int 80h

section .data
msg1: db "enter the string",0Ah
length1: equ $-msg1

section .bss
temp: resb 1
string: resb 50
