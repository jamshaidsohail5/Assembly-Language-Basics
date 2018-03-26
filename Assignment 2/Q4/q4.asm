[org 0x0100]


;this program calculates the no of 1 bits in bx register and 
;complement an equal no of lsb's in ax register

mov ax,0x1234           ;register whose values are to be inverted 
mov bx,0x5678           ;register in which no of 1's are to be counted

cmp bx,0                ;comparing if bx contains 0 that is there are no 1 bits in bx
                        ;register
je exit                 ;terminate the program if bx contains 0  

loop1:
shl bx,1                ;shift lefting the bx register
jc incount              ;jump if the bit gone to carry flag is 1
jnc loop1               ;jump to loop1 back if no carry is generated

incount:
add word[count],1
cmp bx,0
jne loop1
   
mov cx,[count]          ;moving my counter from memory into the cx register
mov dx,1                ;taking my mask which is initially 1


loop2:
xor ax,dx              ;now complementing count no of lsb's in ax register
shl dx,1               ;shift lefting my mask
sub cx,1               ;decrementing my counter
cmp cx,0               ;comparing counter with zero
jnz loop2              ;jump if counter is still not zero
jmp exit               ;otherwise exit the program


count: dw 0

exit:
mov ax,0x4c00
int 21h