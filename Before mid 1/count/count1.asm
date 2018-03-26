[org 0x0100]

mov si, 0              ;register to point to next byte in the current segment

l1: 

mov al, [cs:si]        ;moving the first element from the segment

l2:

shl al, 1              ;shift left the first element

jnc skip               ;jump if no carry

add word [count] , 1   ;increment no of 1

adc word [count+2] , 0 ;incrementing no of 1 

skip:             

cmp al, 0              ;checks if the current byte contains more 1 or not

jne l2

add si, 1              ;moving to next byte in memory 

cmp si, 0xFFFF         ;checks the end of segment

jne l1

je exit

count: dw 0,0
exit
mov ax,0x04c00
int 21h
