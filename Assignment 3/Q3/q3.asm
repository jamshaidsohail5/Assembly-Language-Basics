[org 0x0100]

jmp start

value_of_a: dw 2
value_of_r: dw 3
value_of_l: dw 4
sum_of_series: dd 0




summation:

push bp                               ;storing old value of bp
mov bp,sp                             ;moving the value of sp into the bp as a reference
                                      ;to access parameters

push ax                               ;storing old value of ax
push bx                               ;storing old value of bx    
push cx                               ;storing old value of cx 
push dx                               ;storing old value of dx
push si                               ;storing old value of si
push di                               ;storing old value of di


mov bx,[bp+6]                         ;moving the value of r into the bx register
mov cx,[bp+4]                         ;moving the value of l into the cx register
mov dx,0                              ;variable to control the loop i.e it is n
mov ax,1
mov di,1
mov si,bx
add cx,1

cmp dx,0                              ;comparing if power is initiallay zero
je jumping_long                             ;jump if equal to move 1 to bx and increment power 
jne loop1                             ;jump if not equal to label loop1

jumping_long:
jmp moving









initialize:
mov ax,1
mov di,1
jmp loop1

initialize1:
mov ax,0
mov di,1
jmp loop1


initialize2:
mov ax,-5
mov di,1


loop1:

cmp ax,dx                             ;comparing the incrementing power with the valueof                                        ;l  
je check_second_condition
jne loop3


check_second_condition:

cmp ax,1
je moving1 
jne multiplying_and_putting

loop3:
mov di,1
jmp loop2


loop2:

cmp di,[value_of_r]                   ;comparing the value of r with loop                                                       ;control
                                      ;variable
je put                                ;jump if equal to put 

add si,[value_of_r]                   ;adding the value of r into itself
mov bx,si                             ;moving the sum into bx


inc di                               ;incrementing loop control variable
    
jmp loop2

put:

mov si,bx                           ;moving bx into si

inc ax                              ;incrementing loop control variable
jmp loop1                           ;of outer loop


multiplying_and_putting:

add dx,1
push dx
push ax
mov ax,[bp+8]
mul bx

add word[sum_of_series+2],dx         ;adding the sum 
adc word[sum_of_series],ax 

pop ax
pop dx




cmp dx,cx                            ;comapring the value of l with the the value
                                     ;incrementing power which is in dx
je end

cmp dx,4
je initialize2


jne initialize1 








moving1:
add dx,1
push dx
push ax
mov bx,[bp+6]
mov ax,[bp+8]
mul bx


add word[sum_of_series+2],dx         ;adding the sum 
adc word[sum_of_series],ax 

pop ax
pop dx


cmp dx,cx                            ;comapring the value of l with the the value
                                     ;incrementing power which is in dx
je end

jne initialize 


moving:
mov bx,1                             ;moving  1 to bx register
add dx,1                             ;incrementing power   
jmp adding



adding:
push dx
push ax


mov ax,[bp+8]                        ;moving the value of a into the ax register
mul bx


add word[sum_of_series+2],dx         ;adding the sum 
adc word[sum_of_series],ax 

pop ax
pop dx


cmp dx,cx                            ;comapring the value of l with the the value
                                     ;incrementing power which is in dx
je end

jne initialize 



end:
pop bp
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret 6 


 


 



start:

mov ax,[value_of_a]                    ;moving the value of a into the ax register
push ax                                ;pushing ax to the stack as a parameter

mov ax,[value_of_r]                    ;moving the value of r into the ax register
push ax                                ;pushing ax to the stack as a parameter  

mov ax,[value_of_l]                    ;moving the value of l into the ax register
push ax                                ;pushing ax to the stack as a parameter

call summation




mov ax,0x4c00
int 21h