[org 0x0100]
;;;;;;Program logic for TA;;;;;;;;

;In this program first i print the 
;the 6 strings to check my program
;you can print more
;then i set ds and es to b800 
;set si to 0 and di to 3998
;then i use lodsw and stosw and cld and std commands 
;to accomplish the task
;Kindly read the instructions

;;;;;;;;Hope you understand the logic;;;;;;;;       


jmp start 

                   ;;;;Instrutions;;;;

;Please change the no of rows in order to check the running of the program;
;These strings are just to check my program;
;These strings i have added for your convenience;
;If you want to add more str's then add them and donot forget to print them on the screen starting from line 7 and so on;
;When you run the program then after executing it you will see C:\> at line 3 with green colour
 



str1:db 'My name is khan and i am not a terrorist',0
str2:db 'My name is Bilal Saleem',0
str3:db 'Check karlo',0
str4:db 'ABCD EF G HIJK Lmn',0
str5:db 'I am DON and i knew it',0 
str6:db 'YOU ARE MY TEACHER',0


no_of_rows:dw 4



clrscr:                 ;subroutine to clear the screen
push es
push ax
push cx
push di

mov  ax, 0xb800         ;getting the video start               
mov  es, ax             ;getting into the es register the phsical add of screen
xor di,di 
     
mov  ax, 0x0720         ;moving space on the screen      
mov cx,2000

cld
rep stosw 

pop di
pop cx
pop ax
pop es
ret

print_strings:

push ax                  ;storing old values of registers
push bx
push cx
push dx
push si
push di
push es
push ds


mov cx,0
mov dx,0


mov si,str1              ;moving the address of str1 to si register 
mov di,0                 ;moving the address of start line of screen

mov ax,0xb800            ;moving the memory of screen into ax
mov es,ax                ;pointing es to memory
mov ah,0x07              ;setting attribute on screen

loop1:
lodsb                    ;[ds:si]->al 
stosw                    ;ax->[es:di]
add cx,1                 ;simply to change to change attribute of some characters
cmp cx,5                 ;comparing if cx is 5
je change_attribute      ;jump if equal to change attribute
cmp cx,20                ;comparing if cx is 10
je change_attribute1     ;jump if equal to change attribute1 
jitho_aya_si:
cmp al,0x00              ;checking end of the string
jne loop1

mov si,str2              ;moving the address of str2 to si register
mov di,160               ;moving the starting address of seond line on screen

mov ah,0x07              ;moving the attribute to ah register

loop2:
lodsb                    ;[ds:si]->al
stosw                    ;ax->[es:di]
add dx,1                 ;simply to change to change attribute of some characters
cmp dx,10                ;comparing if cx is 5
je change_att            ;jump if equal to change attribute
cmp dx,25                ;comparing if cx is 10
je change_att1           ;jump if equal to change attribute1 
jitho_aya_si_1:

cmp al,0x00              ;checking the end of str2
jne loop2

jmp bar_ja

change_attribute:
mov ah,0x70
jmp jitho_aya_si   
         
change_attribute1:
mov ah,0x07
jmp jitho_aya_si

change_att:
mov ah,0x70
jmp jitho_aya_si_1

change_att1:
mov ah,0x07
jmp jitho_aya_si_1

bar_ja:
mov si,str3              ;moving the address of str3 to si register
mov di,320               ;moving the starting address of third line on screen

mov ah,1                 ;moving the attribute to ah register

l1:
lodsb                    ;[ds:si]->al
stosw                    ;ax->[es:di]
cmp al,0x00              ;checking the end of str3
jne l1

mov si,str4              ;moving the address of str4 to si register
mov di,480               ;moving the starting address of forth line on screen

mov ah,2                 ;moving the attribute to ah register

l2:
lodsb                    ;[ds:si]->al
stosw                    ;ax->[es:di]
cmp al,0x00              ;checking the end of str4
jne l2

mov si,str5              ;moving the address of str5 to si register
mov di,640               ;moving the starting address of fifth line on screen

mov ah,4                 ;moving the attribute to ah register

l3:
lodsb                    ;[ds:si]->al
stosw                    ;ax->[es:di]
cmp al,0x00              ;checking the end of str5
jne l3

mov si,str6              ;moving the address of str6 to si register
mov di,800               ;moving the starting address of sixth line on screen

mov ah,3                 ;moving the attribute to ah register

l4:
lodsb                    ;[ds:si]->al
stosw                    ;ax->[es:di]
cmp al,0x00              ;checking the end of str6
jne l4


bar_ja_v:
pop ds                   ;restoring old values of registers
pop es
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret

print_reverse_and_swap_attributes:

push bp
mov bp,sp
push ax                  ;storing old values of registers
push bx
push cx
push dx
push si
push di
push es
push ds


mov ax,0xb800            ;moving the memory of screen into ax
mov es,ax                ;pointing es to memory

push es                  ;pushing the value of es to stack
pop ds                   ;pointing ds to b800

mov si,0                 ;moving 0 to si register
mov di,3998              ;location of last word on the screen


loop3:
 
cld                      ;clear direction flag 
lodsw                    ;[ds:si]->ax and increment si by 1

rol ah,1                 ;swapping the foreground and the back ground colour
rol ah,1
rol ah,1
rol ah,1

std                      ;set direction flag 
stosw                    ;ax->[es:di] and decrement di by 2

;;;;;;;;;;;;;Here i will divide the value of si by 158 to check the quotient;;;;;;;;;
;if quotient is equal to the the no of the rows then my work is done;

push ax                  ;pushing the old values of ax and cx   
push cx                  


mov ax,si                ;moving the present value of si to ax register
xor cx, cx               ;economical way of making 0

check_and_subtract:     
cmp ax, 0x9E             ;comparing the value of si with 158    
jl to_check_q_r          ;jump if less to exit label  
sub ax, 0x9E             ;subtracting 158 from the value of si   
inc cx                   ;incrementing the number of subtractions  
jmp check_and_subtract   ;jumping above


;ax holds the remainder of the above division
;cx holds the quotient of the above division

to_check_q_r: 
            
cmp ax,0                 ;checking if ax(i.e if remainder is 0)
je check_second_condition;jump if equal to label
jne pop_and_go_back      ;jump if not equal to pop_and_go_back label         

check_second_condition:
cmp cx,[bp+4]      ;comparing the no_of_rows with the quotient
je hogya_kam             ;jump if equal to the hogya_kam label 
jne pop_and_go_back      ;jump if not equal to pop_and_go_back label 


pop_and_go_back:
pop cx                   ;pop values of cx and ax before going back 
pop ax
jmp loop3



hogya_kam:
pop cx                   ;pop values of cx and ax before leaving
pop ax
jmp exit



exit:
pop ds                   ;restoring old values of registers
pop es
pop di
pop si
pop dx
pop cx
pop bx
pop ax
pop bp
ret 2

start:

call clrscr

call print_strings

mov ax,[no_of_rows]      ;moving the number of rows into the ax register
push ax                  ;pushing on the stack 
call print_reverse_and_swap_attributes


mov ax,0x4c00
int 21h