section .data
msg1: db "Enter the number of rows",0Ah
len1: equ $-msg1
msg2: db "Enter the number of coulumns",0Ah
len2: equ $-msg2
msg3: db "Enter the elements",0Ah
len3: equ $-msg3
msg4: db "The Matrix",0Ah
len4: equ $-msg4
msg5: db " "
len5: equ $-msg5
msg6: db 0Ah
len6: equ $-msg6
msg7: db "hello",0Ah
len7: equ $-msg7
msg8: db "Cannot Multiply",0Ah
len8: equ $-msg8

section .bss
ar1: resw 400
ar2: resw 400
res: resd 1600
temp: resb 1
num: resw 1
i: resb 1
j: resb 1
k: resb 1
r1: resb 1
r2: resb 1
c1: resb 1
c2: resb 1
number1: resw 1
i_loop: resb 1
j_loop: resb 1
sum: resd 1
nod: resb 1
check: resb 1

section .text
global _start:
_start:

mov byte[nod],0

mov ebx,ar1
mov edi,ar1
call read_matrix
mov cl,byte[i]
mov byte[r1],cl
mov cl,byte[j]
mov byte[c1],cl

mov ebx,ar2
mov edi,ar2
call read_matrix
mov cl,byte[i]
mov byte[r2],cl
mov cl,byte[j]
mov byte[c2],cl

mov cl,byte[r2]
cmp byte[c1],cl
jne print_cannot_mult

mov byte[i],0
mov byte[j],0
mov byte[k],0

mov eax,res
mov ebx,ar1
mov ecx,ar2
mov edx,ar2
mov edi,res
pusha

for1:
   mov cl,byte[r1]
   cmp cl,byte[i]
   je after_for1
   mov byte[j],0
   for2:
      mov cl,byte[c2]
      cmp cl,byte[j]
      je after_for2
      mov byte[k],0
      mov dword[sum],0
      for3:
         mov cl,byte[r2]
         cmp cl,byte[k]
         je after_for3
         
         mov eax,0
         movzx eax,word[ebx]
         movzx ecx,word[edx]
         push edx
         mul ecx
         mov ecx,dword[sum]
         add ecx,eax
         pop edx
         mov dword[sum],ecx
         
         add ebx,2
         add edx,20
         add byte[k],1
         jmp for3
      after_for3:
      	mov eax,dword[sum]
         stosd
         popa
         add edx,2
         add byte[j],1
         add edi,4
         pusha
         jmp for2
    after_for2:
         popa
         add ebx,20
         add byte[i],1
         mov edx,ecx
         add eax,40
         mov edi,eax
         pusha
         jmp for1
after_for1:
popa
mov ebx,res
mov esi,res
mov cl,byte[r1]
mov byte[i],cl
mov cl,byte[c2]
mov byte[j],cl
call print_dword_matrix
jmp exit
print_cannot_mult:
mov eax,4
mov ebx,1
mov ecx,msg8
mov edx,len8
int 80h
jmp exit

exit:
mov eax,1
mov ebx,0
int 80h

    mov eax,3
    mov ebx,0
    mov ecx,temp
    mov edx,1
    int 80h

read_matrix:
pusha
  push ebx
    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,len1
    int 80h
    call scan_number
    mov cl,byte[number1]
    mov byte[i],cl
    mov byte[i_loop],0
    
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,len2
    int 80h
    
    call scan_number
    mov cl,byte[number1]
    mov byte[j],cl
    mov byte[j_loop],0
    
    mov eax,4
    mov ebx,1
    mov ecx,msg3
    mov edx,len3
    int 80h
    
    for_readmatrix_i:
        mov cl,byte[i]
        cmp cl,byte[i_loop]
        je after_for_readmatrix_i
        mov byte[j_loop],0
      for_readmatrix_j:
          mov cl,byte[j]
          cmp cl,byte[j_loop]
          je after_for_readmatrix_j
           
          call scan_number
          mov ax,word[number1]
          stosw
          add byte[j_loop],1
          jmp for_readmatrix_j
       after_for_readmatrix_j:
          pop ebx
          add ebx,20
          mov edi,ebx
          push ebx
          add byte[i_loop],1
          jmp for_readmatrix_i
     after_for_readmatrix_i:
        pop ebx
        popa
      ret
      
print_matrix:
 pusha
 push ebx
    mov eax,4
    mov ebx,1
    mov ecx,msg4
    mov edx,len4
    int 80h
    
    mov byte[i_loop],0
    mov byte[j_loop],0
    
    for_print_matrix_i:
       mov cl,byte[i]
       cmp cl,byte[i_loop]
       je after_for_print_matrix_i
       mov byte[j_loop],0
     for_print_matrix_j:
        mov cl,byte[j]
        cmp cl,byte[j_loop]
        je after_for_print_matrix_j
        
        lodsw
        mov dword[sum],eax
        call print_number
        call print_space
        add byte[j_loop],1
        jmp for_print_matrix_j
     after_for_print_matrix_j:
        pop ebx
        add ebx,20
        mov esi,ebx
        push ebx
        add byte[i_loop],1
        call print_null
        jmp for_print_matrix_i
    after_for_print_matrix_i:
      pop ebx
      popa
      ret

scan_number:
pusha
mov word[number1],0

loop_read:
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
    
    cmp byte[temp], 10
    je after_read
    
    cmp byte[temp],32
    je after_read
    
    mov ax, word[number1]
    mov bx, 10
    mul bx
    movzx bx, byte[temp]
    sub bx, 30h
    add ax, bx
    mov word[number1], ax
    jmp loop_read
    
 after_read:
 popa
 ret
 
 
print_number:
 pusha
 mov eax, dword[sum]
 mov byte[nod],0
 cmp dword[sum],0
 je print_zero
 
jmp extract_no

   extract_no:
    cmp dword[sum], 0
    je print_no
    inc byte[nod]
    mov edx, 0
    mov eax, dword[sum]
    mov ebx, 10
    div ebx
    push edx
    mov dword[sum], eax
    jmp extract_no

  print_no:
    cmp byte[nod], 0
    je after_print
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
after_print:
popa
ret



print_zero:
mov byte[temp],0
add byte[temp],30h
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h

popa
ret

print_space:
pusha
   mov eax,4
   mov ebx,1
   mov ecx,msg5
   mov edx,len5
   int 80h
popa
ret

print_null:
pusha
   mov eax,4
   mov ebx,1
   mov ecx,msg6
   mov edx,len6
   int 80h
popa
ret

print_dword_matrix:
 pusha
 push ebx
    mov eax,4
    mov ebx,1
    mov ecx,msg4
    mov edx,len4
    int 80h
    
    mov byte[i_loop],0
    mov byte[j_loop],0
    
    for_print_dword_matrix_i:
       mov cl,byte[i]
       cmp cl,byte[i_loop]
       je after_for_print_dword_matrix_i
       mov byte[j_loop],0
     for_print_dword_matrix_j:
        mov cl,byte[j]
        cmp cl,byte[j_loop]
        je after_for_print_dword_matrix_j
        
        lodsd
        mov dword[sum],eax
        call print_number
        call print_space
        add byte[j_loop],1
        jmp for_print_dword_matrix_j
     after_for_print_dword_matrix_j:
        pop ebx
        add ebx,40
        mov esi,ebx
        push ebx
        add byte[i_loop],1
        call print_null
        jmp for_print_dword_matrix_i
    after_for_print_dword_matrix_i:
      pop ebx
      popa
      ret
