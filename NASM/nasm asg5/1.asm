section .data
msg1:db "Enter String",0Ah
len1:equ $-msg1
msg2:db "Output:"
len2:equ $-msg2
msg3:db 0Ah
len3:equ $-msg3

section .bss
str :resb 100
temp:resb 1
temp1:resb 1
temp2:resb 1

section .text
global _start:
 _start:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h
mov eax,str
mov ebx,str
reading_string:
pusha
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

popa
cmp byte[temp],' '
je reverse_word
cmp byte[temp],10
je reverse_word
continue:
mov dl,byte[temp]
mov byte[ebx],dl
inc ebx

jmp reading_string

end_read:
mov byte[ebx],0

print_string:

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

mov ebx,str
print:
cmp byte[ebx],0
je exit
mov al,byte[ebx]
mov byte[temp],al
pusha
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
popa
inc ebx
jmp print

reverse_word:
mov ecx,ebx
dec ecx
rev:
cmp eax,ecx
jge after_rev
mov dl,byte[eax]
mov byte[temp1],dl
mov dl,byte[ecx]
mov byte[eax],dl
mov dl,byte[temp1]
mov byte[ecx],dl
inc eax
dec ecx
jmp rev
after_rev:
cmp byte[temp],10
je end_read
mov eax,ebx
inc eax
jmp continue
exit:

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h

mov eax,1
mov ebx,0
int 80h
