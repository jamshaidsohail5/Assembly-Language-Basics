[org 0x0100]

                 ;;;;;;;;;LOGIC FOR TA;;;;;;;;;


;Sir in this question the movement i find a match of 
;first character of my substr1 in str1 i apply 
;a loop of lenght=lenght of substr1 and copy the
;characters in str1 to a separate memory location named samplespace
;then i compare the samplespace with substr1
;if they are same then print found and terminate
;if they are not same then again start traversing 
;str1 until end of str1 is found and print 
;not found on screen if end has come 
;and no match is found 
    
                   ;;;;Hope you understand the logic;;;;

jmp start




          ;;;;;;inputs to be changed by TA to check;;;;;;
          ;;;change the following labels;;;           




          ;1:str1       (Enter here the string you want)        
          ;2:substr1    (Enter here the substring you want to search in str1)
          ;3:samplespace(Please Please enter spaces here according to the length of substr1)
          ;4:length_of_substr1 (Enter the length of substr1 accordingly)


          
;;;;;;;;;;;Please change above labels and check instructions in brackets above if you want to check your inputs;;;;;;;;;;;

                     

flag_end_reached:dw 0                              ;flag to check end of array
message:    db 'Substring found',0                 ;messages to be printed on screen
message1:   db 'Substring not found',0
found:dw 0
             

;;;;;;;;;;;;;;;;;TA can change the following labels;;;;;;;;;;;;;;;;;;;;

str1:       db 'Marry has a little lamb',0         ;main string which is to be traversed
substr1:    db 'little lamb',0                     ;substring which is to be searched in str1   
samplespace:db '           ',0                     ;samplespace of spaces equivalent to no of characters in substr1
lenght_of_substr1:dw 11                            ;length of substr1


findsubstr:                                        ;in this label i check for ocurrence of substr1 in str1

push bp                                            ;storing old values
mov bp,sp
push ax
push bx
push cx
push dx
push si
push di
push es
push ds



mov si,[bp+8]                                      ;moving the address of str1 into si  
mov bx,[bp+6]                                      ;moving the address of substr1 into 
                                                   ;bx which is to be searched
cld                                                ;setting direction flag
loop1:

cmp byte[si],0x00                                  ;checking end of string
je check_second_condition  

lodsb                                              ;loading into al the thing of ds:si and increment si
cmp al,byte[bx]                                    ;comparing the str with with substr1
je moving_more                                     ;jump if equal to moving more label
jne loop1                                          ;jump if not equal to loop1 lable 


check_second_condition:
cmp word[found],0                                  ;comparing if substr1 is not found
je take_long_found 
jne take_long_not_found

take_long_found:
jmp print_found

take_long_not_found:
jmp print_not_found

moving_more:
push si                                            ;to keep a record of where in the str was
mov di,samplespace
mov byte[di],al                                    ;moving the first byte from str which is matched with substr1
add di,1  
mov cx,[bp+4]                                      ;moving the lenght to cx register

sub cx,1                                           ;subtracting one from lenght of substr


loop2: 
cmp cx,0                                           ;checking if the whole string has been moved
je to_pop_and_compare


mov al,byte[ds:si]                                 ;moving more elements from str to samplespace 
mov byte[di],al                                        
add si,1                                           ;incrementing the memory pointers
cmp byte[ds:si],0x00                               ;checking if the end of string has come
je to_pop_and_compa                                     
add di,1                                           
sub cx,1                                           ;decrementing the counter
jmp loop2    

to_pop_and_compa:
mov word[flag_end_reached],1                       ;moving  1 to flag_end_reached to indicate end of the str1
add di,1                            
mov byte[di],0                                     
pop si 
jmp to_compare

to_pop_and_compare:
pop si
jmp to_compare


to_compare:
push si                                            ;storing old values od  
push di
push cx
                                        
push es                                            ;storing old values of extra segment and data segment
push ds

;;;;;now calculate the lenght of string which is extracted from the str;;;;;;;;;;;;;;;;;

mov si,samplespace                                 ;moving the address of sample space to si
mov cx,0                                           ;i will store the length of samplespace in cx register


;;;;;;;;;;;;;;;;;;;;;string lenght function;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

loop3:
lodsb                                              ;loading first byte into
add cx,1                                           ;incrementing the count
cmp byte[si],0x00                                  ;comparing the end of sample space
je start_comparing                                 ;jump if equal means the length has been calculated
jne loop3                                          ;jump if not equal means that some string to be traversed is left 

;;;;;;;;;;;;;;;;;;;length calculated now time to compare;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

start_comparing:

cmp cx,[lenght_of_substr1]                         ;comparing the lenght of string extracted from str   
jne exitfalse                                      ;and the string to be searched

mov si,samplespace                                 ;pointing si again to sample space 
mov di,substr1                                     ;pointing di to substring   
mov ax,ds                                          ;moving the es to ds
mov es,ax
add cx,1

;;;;;;;;;;;;;;;;string comparison;;;;;;;;;;;;;;;;;;;;;

mov word[found],1
repe cmpsb                                         ;comparing both strings
jcxz exitsimple                                    ;jump if cx=0                                   



exitfalse:
mov word[found],0                                 ;koi faida nai compare karna ka
pop ds
pop es
pop cx                                            ;agr lenght hi same nai ha
pop di
pop si 
cmp word[flag_end_reached],1
je print_not_found
jne loop1

exitsimple:
mov word[found],1                                 ;this means the substr is found 
pop ds
pop es
pop cx
pop di
pop si

cmp word[found],1
je print_found

print_found:
push ax
push si
push di
push ds
push es

call clrscr

mov ax,0xb800                                     ;pointing extra segment to screen
mov es,ax                                         
mov di,0                                          ;pointing to first offset of screen                 
mov si,message                                    ;pointing si to message to be printed 
mov ah,2                                          ;setting attribute on screen
cld                                               ;clear the direction flag

loop4:

lodsb                                             ;[ds:si]->al
stosw                                             ;ax->[es:di]
cmp byte[si],0x00                                 ;checking end of the message 
je pop_and_exit                                   ;jump if equal that the message has been printed 
jne loop4                                 

pop_and_exit:
pop es
pop ds
pop di
pop si
pop ax
jmp exit

print_not_found:

push ax
push si
push di
push ds
push es

call clrscr

mov ax,0xb800                                     ;pointing extra segment to screen
mov es,ax                                         
mov di,0                                          ;pointing to first offset of screen                 
mov si,message1                                   ;pointing si to message to be printed 
mov ah,4                                          ;setting attribute on screen
cld                                               ;setting the direction flag

loop5:

lodsb                                             ;[ds:si]->al
stosw                                             ;ax->[es:di]
cmp byte[si],0x00                                 ;checking end of the message 
je pop1_and_exit                                  ;jump if equal that the message has been printed 
jne loop5                                 

pop1_and_exit:
pop es
pop ds
pop di
pop si
pop ax
jmp exit

clrscr:
push ax                 ;storing old values
push bx
push cx
push dx
push si
push di
push es
push ds

mov  ax, 0xb800         ;moving into ax the memory of video               
mov  es, ax             ;pointing es to video memory                          
xor di,di               ;making di 0 (economic way of making 0)
   
     
mov  ax, 0x0720         ;moving space on the screen      
mov cx,2000                                      

cld                     ;clear direction flag 

rep stosw               ;mov ax->[es:di] and increment di by 2 and decrement cx
                        ;loop break condition
                        ;cx becomes 0

pop ds
pop es                  ;restoring old values
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret


exit:
pop ds                                             ;restoring old values
pop es
pop di
pop si
pop dx
pop cx
pop bx 
pop ax
pop bp
ret 10



start:

mov si,message                                     ;moving address to si
push si                                            ;pushing to stack

mov si,message1                                    ;moving address to si
push si                                            ;pushing to stack 

mov si,str1                                        ;moving address to si
push si                                            ;pushing to stack

mov si,substr1                                     ;moving address to si
push si                                            ;pushing to stack

mov ax,[lenght_of_substr1]                         ;mov lenght of substr1
push ax                                            ;to ax and push


call findsubstr



mov ax,0x4c00                                      ;terminate program
int 21h