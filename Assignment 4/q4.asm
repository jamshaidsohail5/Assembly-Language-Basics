[org 0x0100]

;;;;;;Program logic for TA;;;;;;

;Sir in this program the user gives the top left and the bottom right and y coordinates 
;of the block and i just move them to the center of the screen
;The starting coordinates of center of the screen
;are (0,10) and i convert them into offset value
;mov the whole block between top left and bottom right coordinate 
;to the center of screen
;Kindly read the instructions
 


jmp start
                ;Instructions
				;1:Sir change the input from 
				;the coordinates given below
				;2:You can change only the below 4 inputs 
               


;;;;;;;;;Change input from here;;;;;;;;;;;
;;;TA can only change the input from here;;;

top_left_x_coordinate: dw  0       
top_left_y_coordinate: dw  0
bottom_right_x_coordinate:dw 79
bottom_right_y_coordinate:dw 4

;;;; These strings will be automatically printed in the portion you want to want to move to center  ;;;;
str1:db 'MY name is jamshaid sohail',0
str2:db 'my rollno is 14-4340',0




;;;These are for storing equivalent word location of the coordinates on the screen;;;
;;;Donot change these;;;


word_offset_1:dw 0
word_offset_2:dw 0
word_offset_for_center: dw 0
center_x_coordinate: dw 0
center_y_coordinate: dw 10


move_to_center_of_screen:

push bp                      
mov bp,sp                         ;getting snapshot of sp value
push ax                           ;storing old values 
push bx
push cx
push dx
push di
push si
push es
push ds

;;;;;;;First i will convert top_left coordinate into the word offset;;;;;;;

mov al,80                         ;load al with columns per row
mul byte[bp+8]                    ;multiply with y position
add ax,[bp+10]                    ;add x position
shl ax,1                          ;turn into the byte offset
mov word[word_offset_1],ax        ;moving into the word_offset_1 label


;;;;;;;Secondly i will convert bottom right coordinate into the word offset;;;;;;;

mov al,80                        ;load al with columns per row
mul byte[bp+4]                   ;multiply with y position 
add ax,[bp+6]                    ;add x position 
shl ax,1                         ;convert into byte offset
mov word[word_offset_2],ax       ;moving into the word_offset_2 label

;;;;;Thirdly i will convert the start of center coordinates into the word offset;;;;;

mov al,80                        ;load al with columns per row
mul byte[center_y_coordinate]    ;multiply with y position
add ax,[center_x_coordinate]     ;add x position
shl ax,1                         ;convert into the byte offset
mov word[word_offset_for_center],ax;moving into the word_offset_for_center label


;;;;	Now here i will mov the data contained in top left and bottom right to center of the screen   ;;;;
                          
mov ax,0xb800                    ;moving screen memory location to ax register
mov es,ax                        ;pointing es to the memory

mov cx,[word_offset_1]           ;moving the offset value of top left coordinate to cx register
mov dx,[word_offset_2]           ;moving the offset value of bottom right coordinate to dx register
  

mov di,[word_offset_for_center]  ;moving word offset of center of screen to di register

push es                          ;pointing ds to b800 i.e video screen
pop ds

mov si,cx                        ;moving the offset of the top left coordinate into the si register


l1:
cld                              ;clear direction flag to increment si and di
lodsw                            ;[ds:si]->ax and increment si by 2
stosw                            ;ax->[es:di] and increment di by 2

cmp si,dx                        ;comparing if the word offset of top left coordinate becomes equal to bottom right coordinate
je movement_done                 ;jump if equal
jne l1
       

movement_done:

pop ds                           ;restoring old values                              
pop es
pop si
pop di
pop dx
pop cx
pop bx
pop ax
pop bx
ret 8                              ;clearing the stack


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


;;;;;;;First i will convert top_left coordinate into the word offset;;;;;;;

mov al,80                         ;load al with columns per row
mul byte[top_left_y_coordinate]   ;multiply with y position
add ax,[top_left_x_coordinate]    ;add x position
shl ax,1                          ;turn into the byte offset
mov word[word_offset_1],ax        ;moving into the word_offset_1 label


;;;;;;;Secondly i will convert bottom right coordinate into the word offset;;;;;;;

mov al,80                        ;load al with columns per row
mul byte[bottom_right_y_coordinate];multiply with y position 
add ax,[bottom_right_x_coordinate];add x position 
shl ax,1                         ;convert into byte offset
mov word[word_offset_2],ax       ;moving into the word_offset_2 label


mov si,str1              ;moving the address of str1 to si register 
mov di,[word_offset_1]   ;moving the address of top left of screen

mov ax,0xb800            ;moving the memory of screen into ax
mov es,ax                ;pointing es to memory
mov ah,1                 ;setting attribute on screen

cld                      ;clear direction flag
loop1:
lodsb                    ;[ds:si]->al 
stosw                    ;ax->[es:di]
cmp al,0x00              ;checking end of the string
jne loop1



mov si,str2              ;moving the address of str2 to si register 
mov di,[word_offset_2]   ;moving the address of bottom right of screen

mov ax,0xb800            ;moving the memory of screen into ax
mov es,ax                ;pointing es to memory
mov ah,0x2               ;setting attribute on screen

loop2:
cld                      ;clear direction flag 
lodsb                    ;[ds:si]->al
std                      ;set direction flag   
stosw                    ;ax->[es:di]
cmp al,0x00              ;checking end of the string
jne loop2


pop ds                   ;restore old values 
pop es
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret

start:

call clrscr
call print_strings

mov ax,[top_left_x_coordinate]     ;moving the topleft x coordinate into the ax regsiter
push ax                            ;pushing to the stack  
mov ax,[top_left_y_coordinate]     ;moving the topleft y coordinate into the ax register  
push ax                            ;pushing to the stack 
mov ax,[bottom_right_x_coordinate] ;moving the bottomright x coordinate into the ax register
push ax                            ;pushing to the stack        
mov ax,[bottom_right_y_coordinate] ;moving the bottomright y coordinate into the ax register 
push ax                            ;pushing to the stack 
call move_to_center_of_screen

mov ax,0x4c00
int 21h