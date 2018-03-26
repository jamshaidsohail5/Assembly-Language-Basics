[org 0x0100]

mov bx,0XAAAA ;To extract the odd bits of given number
mov cx,0x5555 ;To extract the even bits of given number

mov ax,0x1234   ;number whose alternative bits are to be swapped
mov dx,ax

and ax,bx     ;now ax contains the odd bits of the given number
and dx,cx     ;now dx contains the even bits of thye given number

shr ax,1      ;shifting right the odd bits 1 time
shl dx,1      ;shifting left the even bits 1 time

or ax,dx      ;now bx contains the number whose alternative bits are swapped 
   


mov ax,0x4c00
int 21h