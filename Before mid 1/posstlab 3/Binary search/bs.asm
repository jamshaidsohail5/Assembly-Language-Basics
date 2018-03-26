[org 0x0100]


mov bx,data
mov bp,data                      ;storing address of first and last elements

mov si,data+16

lable :

add bx,si
mov di,bx        ;calculating address of middle element
shr di,1
       
mov ax,[searchdata]       ;moving the searching element
cmp ax,[di]               ;comparing searching element with the middle element
je exit                   ;exit if the element is present in the middle


ja update
jb updateadd




update:

add di,2
mov bx,di
mov si,data+16

jmp lable


updateadd:


sub di,2
mov bx,di
mov si,data
jmp lable


exit:mov byte[found],1

mov ax,0x4c00
int 21h



data: dw 10,25,30,35,40,45,50,55,60
searchdata: dw 55
found:dw 0