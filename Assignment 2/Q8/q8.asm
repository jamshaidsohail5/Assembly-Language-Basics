[org 0x0100]

;this program counts the no of 1 in ax and put the count back
;in ax register .Repeat this process until no of count of 1 is one.

mov ax,[value]        ;putting initially 0x1234 in ax register
mov word[count],0     ;initiallizing my count 

loop1:

shl ax,1              ;shift lefting the count   
jc increment          ;jump if 1 has gone to carry flag
jnc loop1             ;jump if no carry to loop1 one again

increment:

add word[count],1     ;incrementing count if carry flag is set     
cmp ax,0              ;comparing ax with 0 to check if more 1's are present 
je putnewcount        ;jump if equal
jne loop1             ;jump if not equal to loop1

putnewcount:

cmp word[count],1     ;camparing count with 1
je exit               ;jump if count is 1 to exit from program  
mov ax,[count]
mov word[count],0
jmp loop1

value:dw 0x1234
count:dw 0

exit:
mov ax,0x4c00
int 21h
