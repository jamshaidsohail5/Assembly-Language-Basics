[org 0x0100]

mov ax,0                                            ;mov 0 to ax
mov bx,0                                            ;mov 0 to bx

call divider
mov al,[buffer+si]                                  ;mov the element which is now pointed                                                     ;by si register           mov bl,[buffer+si+1]                                ;mov the element which is after si                                                     ;address

mov cx,8                                            ;moving 8 to cx register
sub cx,dx                                           ;subtracting 8 from the bitnumber 
back1:  
cmp cx,0                                            ;moving 0 to cx

je back                                             ;jump if equal to back label

dec cx                                              ;decrement cx 
shr bx,1                                            ;shift right bx by 1
jmp back1                                           ;jump to back1 label  


back:

cmp dx,0                                            ;comparing the bit no with 0 
je next                                             ;jump if equl to next label
dec dx                                              ;decrement dx  
shl ax,1                                            ;shift left the ax register  
jmp back                                            ;jump to back label
next:                 
and ax,0x00FF                                       ;anding ax with 0x00FF
or ax,bx                                            ; oring ax and bx

jmp end


divider:
mov dx,[position]                                            ;now dx contains the bit number
mov si,0                                                     ;si contains 0
mov cx,8                                                     ;cx contains 8
cmp dx,cx                                                    ;comparing the bit no with 8
jl return                                                    ;jump if less to label return  to execute the ret statement    

Lable:

sub dx,cx                                                    ;remainder goes to di                                                                  
add si,1                                                     ;qoutient goes to si
cmp dx,cx                                                    ;comparing bitno with 8 
jge Lable                                                    ;jump if greater or equal to label Label 
return:

ret                                                          ;ret command pops the stack                                                              ;once and copy                                                                 ;the popped element to ip register

end:


mov ax, 0x4c00
int 0x21
buffer : db 0x55,0xAA,0xFE,0xFF,0xAB,0x14,0xDE,0x9A,0x55,0x0,0xFE,0xFF,0xAB,0x14,0xDE,0x9A,0x55,0x0,0xFE,0xFF,0xAB,0x14,0xDE,0x9A,0x55,0x0,0xFE,0xFF,0xAB,0x14,0xDE,0x9A
position:dw 0
