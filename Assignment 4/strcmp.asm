[org 0x0100]

jmp start

msg1: db 'lamb',0
msg2: db 'lame',0
lenght1:dw 4
lenght2:dw 4


strcmp:
push bp
mov bp,sp
push cx
push si
push di
push es
push ds

lds si,[bp+4]
les di,[bp+8]

mov cx,[lenght1]  
mov ax,[lenght2]

cmp cx,ax
jne exit_false

mov dx,1
repe cmpsb
jcxz exit_simple


exit_false:
mov dx,0
exit_simple:
pop ds
pop es
pop di
pop si
pop cx
pop bp
ret 8



start:
push ds
mov ax,msg1
push ax
push ds
mov ax,msg2
push ax
call strcmp

mov ax,0x4c00
int 21h