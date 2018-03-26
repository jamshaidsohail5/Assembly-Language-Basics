[org 0x0100]


;i will write this code to find 5 consecutive zeros in series of bits as i have
;asked it from teacher

mov cx,0              ;counter to count the zeros
mov dx,3              ;to check about 3 consecutive zeros
mov bx,sequence       ;moving the starting address of sequence
mov si,0              ;register to point to the next element in the sequence

loop3:
mov al,[bx+si]        ;moving the element from the register

loop1:
cmp si,4              ;checking out of bound error
je exit               ;jump if equal  
shl al,1              ;shift lefting the al register
jnc count             ;jump if 0 is gone to carry flag to count this into cx 
jc setcountzero       ;jump if carry flag is set to set again count to zero


count:

add cx,1              ;incrementing the count
cmp al,0              ;checking if al contains 0
je incr               ;if al contains 0 then jump to point to next element in sequence   

loop2:
      
cmp cx,dx             ;checking if five consecutive 0 has come or not
je exit               ;jump if 5 consecutive 0 has come to exit from program
jne loop1             ;jump if not equal back to loop1 to check next bit

incr:

add si,1              ;pointing si to next element if al contains zero
mov al,[bx+si]        ;moving the new element to al register
jmp loop2             ;jump to loop 2

setcountzero:

mov cx,0              ;setting count to zero  if carry flag has been set to start new    
cmp al,0              ;counting 
je incr1              ;jump if equal to increment si
jne loop1             ;jump to loop1 if al is not zero yet 

incr1:
add si,1
jmp loop3


sequence: db 0xFF,0X12,0X87,0X3A

exit:
mov ax,0x4c00
int 21h
