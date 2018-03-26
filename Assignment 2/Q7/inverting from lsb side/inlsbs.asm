[org 0x0100]

mov ax,[noinax]    ;moving the number into the ax register
mov bx,0x1234      ;number whose bit is to be inverted
mov cx,1           ;this is my mask to invert the corresponding bit in bx register
mov dx,0           ;this register is used to store the number which matches with the 
                   ;ax register          
jmp loop2          ;jumping to loop2

loop1:

add dx,1           ;incrementing this register to compare the incremented value 
                   ;with the ax register
loop2:

cmp ax,dx          ;comparing the value in ax register with the value in dx register  
je invert          ;jump if equal to invert the corresponding bit in bx register
jne loop1          ;jump if not equal to increment the value of dx and again comparing

invert:

cmp dx,0           ;if dx is 0 that is 0 is present then simply invert the 0th bit  
je ou              ;and get out by simply taking jump if not equal

invert1:
     
sub dx,1           ;decrementing the counter
shl cx,1           ;shift lefting the by one
cmp dx,0           ;checking dx 
jnz invert1        ;jump if not zero
jz out1

ou:
xor bx,1           ;inverting the 0th bit from lsb side
jmp exit           ;now get exit from program 

out1:
shr cx,1          ;shifting right the cx once to nullify one exta shift left 
xor bx,cx         ;now take xor of the bx register with my mask 
jmp exit          ;now get exit from program

noinax: dw 6

exit:
mov ax,0x4c00
int 21h
