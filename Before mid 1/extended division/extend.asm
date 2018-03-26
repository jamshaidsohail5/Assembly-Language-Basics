[org 0x0100]
 
jmp start                 ;jumping to start label

carry: 

cmp dx, 0       

je adbx

sub dx, 1

jmp l1

adbx: 

add bx,ax

jmp exit

start:

mov dx, [dividend+2] ; define double variable created in memory

mov bx, [dividend]   ; moving the dividend from memory

mov ax, [divider] ;  moving the divisor to register

l1: 

sub bx, ax

jc carry

add word [quotient] , 1 ; dw var created in memory

jmp l1

exit:

mov dx, bx

mov ax, [quotient]

dividend: dd 25
divider: dw 5
quotient: dw 0

mov ax,0x04c00
int 21h
