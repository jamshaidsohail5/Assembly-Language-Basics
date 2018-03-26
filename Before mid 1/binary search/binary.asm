[org 100h]

mov ax, [val]            ;moving the element to be founded
mov cx, 0                   
mov dx, [size]           ;moving the size
shl dx, 1                ;multipltying the size by 2 

loop1:
	cmp cx, dx       ;comparing the size  
	jg nfound        ;jump if greater

	mov bx, cx       ;moving cx into bx
	add bx, dx       ;adding bx into dx  
	shr bx, 1         ;dividing by 2 the size
	and bx, 0xFFFE    ;making the odd bx to even bx
	cmp ax, [arr + bx]
	jz found
	cmp ax, [arr + bx]
	jg great1

	sub bx, 2
	mov dx, bx
	jmp loop1

great1:
	add bx, 2
	mov cx, bx
	jmp loop1

nfound:
	mov ax, 0
	jmp end

found:
	mov ax, 1

end:
	mov ax, 4c00h
	int 21h

val: dw 3
size: dw 6
arr: dw 2, 3, 4, 5, 6, 7
