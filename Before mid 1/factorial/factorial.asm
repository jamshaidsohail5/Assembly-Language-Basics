[org 0x0100]



mov ax,4

mov bx,ax

loop1:




sub bx,1

mov cx,bx

mov dx,ax

cmp bx,1

je exit

loop2:

add ax,dx

sub cx,1

cmp cx,1

je loop1

jne loop2


exit:mov ax,0x4c00
int 21h
