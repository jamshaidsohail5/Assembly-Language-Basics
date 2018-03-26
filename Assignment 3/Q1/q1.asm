[org 0x0100]

jmp start
arr: dw 2,6,8,4,1,13,7,5
size: dw 8
range1: dw 3
range2: dw 7

reverse_in_range:

push bp                          ;save old value of bp
mov bp,sp                        ;make bp our reference point
push ax                          ;save old value of ax
push bx                          ;save old value of bx 
push cx                          ;save old value of cx
push dx                          ;save old value of dx
push si                          ;save old value of si
push di                          ;save old value of di 

;main algorithm starts from here

mov cx,[bp+6]                    ;moving the range1 to cx register 
mov dx,[bp+4]                    ;moving the range2 to dx register

mov si,[bp+10]                   ;moving the address of last element to si register
mov di,[bp+12]                   ;moving the address of first element to di register
jmp loop1

loop2:
pop di

loop1:
mov ax,[di]                   ;moving the  element of array to ax register now pointed by bx

cmp ax,cx                        ;comparing the element of array with range1
jae condition                    ;jump if number is greater or equal than range1
jb increment_front               ;jump if element is  below the range1 


increment_front:
add di,2
cmp di,si                      ;checking if si and bx points to the same memory address
jz ou                          ;jump if equal to out

push di
add di,2

cmp di,si                      ;comparing if bx and si are pointing to the consecutive memory locations
je check_last                  ;jump if equal to label check_last
jne loop2

condition:
cmp ax,dx                       ;comparing the first number with range2                        
jbe check_lastnumber            ;jump if number is below or equal to range2 
ja increment_front

check_lastnumber:
cmp [si],cx                     ;comparing the element from msb side with range1
jae condition1                  ;jump if element from msb side is above or equal to range1
jb decrement_back


decrement_back:
sub si,2
cmp di,si                      ;checking if si and bx points to the same memory address
je ou                          ;jump if equal to out

push di
add di,2

cmp di,si                      ;comparing if bx and si are pointing to the consecutive memory locations
je check_last                  ;jump if equal to label check_last
jne loop2



condition1:
cmp [si],dx                     ;comparing the  element of array from back with range2 
jbe swap                        ;jump if element of array from back is below or equal to range2 
ja decrement_back

swap:
xchg ax,[si]                   ;swapping the first and the last element 
mov [di],ax                 ;moving the last element to first position
add di,2                       ;now pointing bx to next element in array from front 
sub si,2                       ;now pointing si to next element in array from back
cmp di,si                      ;checking if si and bx points to the same memory address
je ou                         ;jump if equal to out

push di
add di,2

cmp di,si                 ;comparing if bx and si are pointing to the consecutive memory locations
je check_last                  ;jump if equal to label check_last
jmp loop2                      ;else jump to loop1       


check_last:
pop di
mov ax,[di]                 ;mov the element to ax register now pointed by the bx register   
cmp ax,cx                      ;comparing the element in array from front with range 1
jae check_secondcondition      ;jump if element in array is above or equal to range1
jb ou

check_secondcondition:                           
cmp ax,dx                      ;comparing the element from  front with range2                      
jbe check_lastcondition        ;jump if below or equal
ja ou


check_lastcondition:
cmp [si],cx                   ;comparing the element from back with range 1 
jae check_lastcondition2     
jb ou

check_lastcondition2:
cmp [si],dx                   ;comparing the element from back with range 2
jbe swap1                     ;jump if below or equal to range2
ja ou


swap1:
xchg ax,[si]
mov [di],ax
jmp ou





ou:
pop di                           ;restore old value of di
pop si                           ;restore old value of si 
pop dx                           ;restore old value of dx 
pop cx                           ;restore old value of cx
pop bx                           ;restore old value of bx 
pop ax                           ;restore old value of ax
pop bp                           ;restore old value of bp  
ret 10                           ;go back and remove 5

start:
mov bx,arr                       ;moving the address of array  in bx register
push bx                          ;pushing the address to stack as parameter   

mov bx,arr+14                    ;moving the address of last element to bx register       
push bx                          ;pushing the address of last element to stack as parameter

mov ax,[size]                    ;moving the size of arr to ax register 
push ax                          ;pushing the size of array to stack as a parameter      

mov ax,[range1]                  ;moving the range1 to ax register
push ax                          ;pushing range1 to stack as parameter  

mov ax,[range2]                  ;moving the range2 to ax register
push ax                          ;pushing range2 to stack as parameter

call reverse_in_range            ;calling the sub-routine
                                 ;call will push the offset of next instruction to stack    
                                 ;and put address of sub-routine to IP register  


mov ax,0x4c00
int 21h