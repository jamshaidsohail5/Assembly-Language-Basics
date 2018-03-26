[org 0x0100]


;;;;;;;;;;;;;;;;;Program logic for TA;;;;;;;;;;;;;;

;Sir in this program in kbisr
;i have incremented keys pressed and given control back to old isr
;in timer isr 2 checks have been 
;one checks if 5 seconds has passed to print stars on the screen
;one checks if 1 to increment count of stars as it is demand of question
;simple type q1.com on dosbox 
;then type the characters the stars will appear according to noof characters 
;typed then again type and the program continues





jmp start


oldkb: dd 0                        ;label to store old segment-offset of kbisr
position_on_screen:dw 158          ;position where to print stars on screen(top right)


count_of_pressed_keys:dw 0         ;counter to store no of keys pressed
count_to_check_5_seconds:dw 0      ;counter to check 5 seconds has elapsed or not
count_to_check_1_second:dw 0       ;counter to check 1 second has passed or not

no_of_stars: dw 0                  ;no of stars to print on the screen


 
clrscr:
push ax                            ;storing old values
push bx
push cx
push dx
push si
push di
push es


mov  ax, 0xb800                   ;moving into ax the memory of video               
mov  es, ax                       ;pointing es to video memory                          
xor di,di                         ;making di 0 (economic way of making 0)
   
     
mov  ax, 0x0720                   ;moving space on the screen      
mov cx,2000                                      

cld                               ;clear direction flag 

rep stosw                         ;mov ax->[es:di] and increment di by 2 and decrement cx
                                  ;loop break condition
                                  ;cx becomes 0

pop es                            ;restoring old values
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret

print_steric:

push bp                           ;storing old values
mov bp,sp
push ax
push bx
push cx
push dx
push si
push di
push es
push ds

mov ax,0xb800                     ;moving 0xb800 to ax register
mov es,ax                         ;pointing es to screen

mov di,[bp+6]                     ;moving position on the screen to the di register
mov bx,[bp+4]                     ;moving the number of stars to ax register

shr bx,1                          ;dividing by 2 as the stars are doubled
  
mov al,'*'                        ;moving the star and its attribute to ax register
mov ah,2

looop:
cmp bx,0                          ;comparing if stars to be printed has become zero
je out1                           ;jump if equal to out of isr
sub bx,1                          ;subtracting 1 from cx register
mov word[es:di],ax                ;printing star 
add di,160                        ;incrementing di to next line
jmp looop  

out1:
mov word[cs:position_on_screen],bx
pop ds                            ;restoring old values
pop es
pop di
pop si
pop dx
pop cx
pop bx
pop ax
pop bp

ret 4

                  ;;;;;;;;;;MY timer isr;;;;;;;;;;



timer:
push ax                           ;saving old value

cmp word[cs:count_to_check_5_seconds],90;checking if 5 seconds has passed
je print_stars

cmp word[cs:count_to_check_1_second],18;checking if 1 second has passed to apply increment count each second demand
je to_record_count_of_keys

add word[cs:count_to_check_5_seconds],1;incrementing 5 second check counter
jmp out_of_isr


to_record_count_of_keys:
mov word[cs:count_to_check_1_second],0 ;resetting
mov ax,word[cs:count_of_pressed_keys]    ;moving the no of keys pressed in 1 second to ax register
add word[cs:no_of_stars],ax          ;incrementing no of stars 
mov word[cs:count_of_pressed_keys],0 ;making the counter again 0 to count for next second
add word[cs:count_to_check_5_seconds],1   ;incrementing the counter to reach 5 seconds
jmp out_of_isr       
  
 

print_stars:
call clrscr                       ;calling clear screen before printing stars
push word[cs:position_on_screen]  ;passing parameters to print_steric routine
push word[cs:no_of_stars]         ;passing no of stars to print
call print_steric                 ;calling print steric

;;;;;;;reseting the counters;;;;;;;

mov word[cs:count_to_check_5_seconds],0 
mov word[cs:count_to_check_1_second],0
mov word[cs:count_of_pressed_keys],0
mov word[cs:no_of_stars],0
mov word[cs:position_on_screen],158
jmp out_of_isr


out_of_isr:
add word[cs:count_to_check_1_second],1

mov al,0x20                      ;sending EOI signal
out 0x20,al                    
 
pop ax
iret
 


                 ;;;;;;;;;;MY keyboard isr;;;;;;;;;;
   
kbisr:

add word[cs:count_of_pressed_keys],1;incrementing the counter to store no of keys pressed
jmp far[cs:oldkb]                   ;applying the interupt chaining (giving control back to old isr)
         

start:

                                  ;;;;;;;;;;;saving old kbisr offset and segment;;;;;;;;;;;


xor ax,ax                          ;economical way of making zero
mov es,ax                          ;moving 0 (the address of ivt to es register)
mov ax,[es:9*4]                    ;retrieving old offset   
mov [oldkb],ax                     ;saving the offset 
mov ax,[es:9*4+2]                  ;retrieving old segment
mov [oldkb+2],ax                   ;saving the old segment 

                                  ;;;;;;;;;;;    Hooking the timer and kbisr    ;;;;;;;;;;;

	
cli                                ;clear the interupt flag  
mov word [es:9*4],kbisr            ;moving offset to ivt 
mov [es:9*4+2],cs                  ;moving segment to ivt 
mov word [es:8*4],timer            ;moving timer offset to ivt 
mov [es:8*4+2],cs                  ;moving segment og timer to ivt
sti                                ;setting interrupt flag

                                  ;;;;;;;;;;    Making terminate and stay resident;;;;;;;;;

mov dx,start                       ;moving label upto which terminate and stay resident
add dx,15                          ;moving 15 to ax
mov cl,4                           ;moving 4 to cl register   
shr dx,cl                          ;shiftright the dx register cl times
mov ax,0x3100                      ;terminate and stay resident 
int 0x21

