[org 0x0100]

;;;;;;;;;;;;;;;LOGIC FOR TA;;;;;;;;;;;;;

;Sir i will simple move star at [b800:di=0]
;and star at [b800:si=158] and apply clearscreen 
;and increment/decrement si and di 
;accordingly and then again print..... 
;then apply conditions on si and di value
;to control star movement 
;and apply infinite loop
;Kindly read the instructions

              ;Instructions
              ;1:Sir you will see 2 stars one from left and one from  right
              ;star moving very fast on screen     
              ;to view them slowly simpy slow the 
              ;cycles by pressing ctrl+f11
    

jmp start
str1:db '*'


clrscr:
push ax                 ;storing old values
push bx
push cx
push dx
push si
push di
push es


mov  ax, 0xb800         ;moving into ax the memory of video               
mov  es, ax             ;pointing es to video memory                          
xor di,di               ;making di 0 (economic way of making 0)
   
     
mov  ax, 0x0720         ;moving space on the screen      
mov cx,2000                                      

cld                     ;clear direction flag 

rep stosw               ;mov ax->[es:di] and increment di by 2 and decrement cx
                        ;loop break condition
                        ;cx becomes 0

pop es                  ;restoring old values
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret

start:

mov ax,0xb800           ;moving memory of screen into the ax reg  
mov es,ax               ;pointing es to b800
mov di,0                ;loading 0 into di
mov si,158              ;loading end of 1 line on screen into si

mov ah,2                ;loading green colour into ah register
mov al,[str1]           ;loading star into al register

loop2:
mov si,158
mov di,0

loop1:

mov word[es:di],ax      ;moving star onto screen on left part
mov word[es:si],ax      ;moving star onto screen on right part 

call clrscr             ;calling clear screen
 
add di,2                ;incrementing di by 2
sub si,2                ;decrementing si by 2

cmp si,0                ;comparing if si has become 0   
je loop2                ;jump if equal to loop2 label to implement infinite loop 

cmp di,158              ;comparing if di has become 158    
je loop2                ;jump if equal to loop2 to implement infinite loop


jmp loop1               ;jmp to loop1 label


mov ax,0x4c00
int 21h