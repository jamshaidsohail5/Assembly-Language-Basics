[org 0x0100]

;first i will convert all the times in seconds format

mov ax,[time1]
mov bx,ax
mov cx,ax
mov dx,ax

shr bx,11                           ;now i am having the binary of hours in the bx                                            
                                    ;register

shl cx,5                            ;now i am having the binary of minutes in the cx  
shr cx,10                           ;register


shl dx,11                           ;now iam having the binary of seconds in the dx   
shr dx,11                           ;register
     

mov word[tempsecond1],dx            ;making a copy of seconds in memory

mov ax,0x0F10                       ;multiplying the hours with 3600
mul bx                       

mov word[time1seconds],ax           ;storing the 32 bit seconds of hour back in memory
mov word[time1seconds+2],dx 

mov ax,0x003D                       ;multiplying the minutes by sixty
mul cx                      
  
mov word[time1seconds+4],ax         ;storing the 32 bit seconds of minutes back in memory
mov word[time1seconds+6],dx

mov dx,[tempsecond1]                ;multiplying the seconds by 2
mov ax,0x0002
mul dx
 
mov word[time1seconds+8],ax         ;moving the seconds of second back to memory
mov word[time1seconds+10],dx   

                                        ;Now i will add all the seconds of time 1
                                        ;by using the technique of extended addition




mov ax,[time1seconds]               ;now i have added the lower 16 bits of all the       
add word[time1seconds+4],ax         ;seconds of time1
mov ax,[time1seconds+8]
adc word[time1seconds+4],ax

mov dx,[time1seconds+2]             ;now i have added the upper 16 bits of all the
add word[time1seconds+6],dx         ;seconds of time1
mov dx,[time1seconds+10]
adc word[time1seconds+6],dx

                                        


                                          ;The whole above algorithm will be repeated for time2


mov ax,[time2]
mov bx,ax
mov cx,ax
mov dx,ax

shr bx,11                           ;now i am having the binary of hours in the bx                                            
                                    ;register

shl cx,5                            ;now i am having the binary of minutes in the cx  
shr cx,10                           ;register


shl dx,11                           ;now iam having the binary of seconds in the dx   
shr dx,11                           ;register
     

mov word[tempsecond2],dx            ;making a copy of seconds in memory

mov ax,0x0F10                       ;multiplying the hours with 3600
mul bx                       

mov word[time2seconds],ax           ;storing the 32 bit seconds of hour back in memory
mov word[time2seconds+2],dx 

mov ax,0x003D                       ;multiplying the minutes by sixty
mul cx                      
  
mov word[time2seconds+4],ax         ;storing the 32 bit seconds of minutes back in memory
mov word[time2seconds+6],dx

mov dx,[tempsecond2]                ;multiplying the seconds by 2
mov ax,0x0002
mul dx
 
mov word[time2seconds+8],ax         ;moving the seconds of second back to memory
mov word[time2seconds+10],dx   

                                        ;Now i will add all the seconds of time 2
                                        ;by using the technique of extended addition




mov ax,[time2seconds]               ;now i have added the lower 16 bits of all the       
add word[time2seconds+4],ax         ;seconds
mov ax,[time2seconds+8]
adc word[time2seconds+4],ax

mov dx,[time2seconds+2]             ;now i have added the upper 16 bits of all the
add word[time2seconds+6],dx         ;seconds
mov dx,[time2seconds+10]
adc word[time2seconds+6],dx
   
                                      



                                           ;The final step of this program is to subtract the two times
                                           ;this can be done by using the technique of extended subtraction
 
mov ax,[time1seconds+4]                    ;subtracting the lower 16 bits of time1 and time2
sub word[time2seconds+4],ax
mov ax,[time1seconds+6]                    ;subtracting the upper 16 bits of time1 and time2 
sbb word[time2seconds+6],ax                                               


mov word[diff],ax                          ;putting the diffrernce to the diff label
mov dx,[time2seconds+6]
mov word[diff+2],dx
jc putminusone
jnc putone


time1:dw 0x1207
time2:dw 0x4206
diff: dw 0,0
recent: db 0x00

tempsecond1: dw 0
tempsecond2: dw 0

time1seconds: dw 0,0,0,0,0,0
time2seconds: dw 0,0,0,0,0,0

putminusone:
mov byte[recent],-1
jmp exit

putone:
mov byte[recent],1
exit:
mov ax,0x4c00
int 21h