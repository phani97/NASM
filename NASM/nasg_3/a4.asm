section .data
msg1: db "Enter string1:"
len1: equ $-msg1
msg2: db "Enter string2:"
len2: equ $-msg2
msg3: db 0Ah
len3: equ $-msg3
msg4: db "Enter string3:"
len4: equ $-msg4

global _start:
 _start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h
;enter first string
mov ebx,a1
;call read_string

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

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h
;enter second string
mov ebx,a2
;call read_string

read2:
push ebx
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
pop ebx
cmp byte[temp],10
je nextstep2
mov al,byte[temp]
mov byte[ebx],al
add ebx,1
jmp read2

nextstep2:
mov byte[ebx],0

mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,len4
int 80h
;enter second string
mov ebx,a3
;call read_string

read3:
push ebx
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
pop ebx
cmp byte[temp],10
je nextstep3
mov al,byte[temp]
mov byte[ebx],al
add ebx,1
jmp read3

nextstep3:
mov byte[ebx],0

mov eax,a1
mov ebx,a4

transfer:
mov ecx,a2
cmp byte[eax],0
je print_string
mov dl,byte[eax]
cmp dl,byte[ecx]
je check_equal
mov byte[ebx],dl
add eax,1
add ebx,1
jmp transfer

check_equal:
mov byte[i],0
mov ecx,a2
check:
mov dl ,byte[ecx]
cmp dl, 0
je insert_a3
cmp dl,byte[eax]
jne not_equal
add byte[i],1
add eax,1
add ecx,1
jmp check

insert_a3:
mov ecx,a3
insert:
mov dl,byte[ecx]
cmp dl,0
je transfer
mov byte[ebx],dl
add ebx,1
add ecx,1
jmp insert

not_equal:
mov dl,byte[i]
sub eax,edx
mov dl,byte[eax]
mov byte[ebx],dl
add eax,1
add ebx,1
jmp transfer




print_string:
mov byte[ebx],0
mov ebx,a4
print_s:
mov al,byte[ebx]
mov byte[temp],al

cmp byte[temp],0
je exit

push ebx

mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h

pop ebx

add ebx,1
jmp print_s

exit:
mov eax,1
mov ebx,0
int 80h

section .bss
a1: resb 100
a2: resb 100
a3: resb 100
a4: resb 200
temp:resb 1
i:resb 1
