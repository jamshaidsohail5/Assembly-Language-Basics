[org 0x0100]

;program to swap the nibbles in each byte of ax register

mov ax,0x1234   ;moving the value in ax register whose nibbles are to be swapped
mov dx,4        ;my counter to run the loop

;swapping nibbles of al register

loop1:
rol al,1        ;rotate left operation
sub dx,1        ;decrementing the counter 
jnz loop1       ;jump if not zero

mov dx,4        ;again initialize the counter

;swapping nibbles of ah register

loop2:
rol ah,1       ;rotate left operation
sub dx,1       ;decrementing the counter
jnz loop2      ;jump if not zero


mov ax,0x04c00 ;exit the program
int 21h
