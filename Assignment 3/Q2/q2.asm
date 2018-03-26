[org 0x0100]

jmp start

check_array:

push bp                          ;storing old value of bp
mov bp,sp                        ;moving the value of sp in bp  

push ax                          ;storing old value of ax  
push bx                          ;storing old value of bx
push cx                          ;storing old value of cx
push dx                          ;storing old value of dx
push si                          ;storing old value of si
push di                          ;storing old value of di

;we have to check the array2 in  array1 in order



mov si,[bp+14]                      ;moving the starting address of array1
mov di,[bp+10]                      ;moving the starting address of array2
mov cx,[bp+12]                      ;moving the address of element which is after the last element of array1
mov dx,[bp+8]                       ;moving the address of element which is after the last element of array2
mov ax,[bp+6]                       ;moving the size of array1
mov bx,[bp+4]                       ;moving the size of array2 
   


cmp ax,bx                           ;comparing the sizes of two arrays 
jb end                              ;jump if size of array1 is less than the size of array2  
                                    ;then there is no need to check the elements of array2 in array1
                                    ;simply return 0

je check_common


check_common:

mov ax,[di]                         ;moving the address of element of array2 to ax
mov bx,[si]                         ;moving the address of element of array1 to bx
cmp ax,bx                           ;comparing the element of array2 with the element of array1
je increment_count
jne increment_si

increment_si:
add si,2
cmp si,cx
je end
jne check_common


increment_count:
add di,2                            ;pointing di to next element in array2
add si,2                            ;pointing si to next element in array1  
add word[counter],1                 ;increment the counter
mov ax,[bp+4];                      ;mov the size of array2 to ax
cmp [counter],ax                    ;comparing the counter with the size of array2
je end1                             ;jump if size of array2 is equal to the counter 
jne check_ends


check_ends:
cmp si,cx
je end
jne check_ends1

check_ends1:

cmp di,dx
je end
jne check_common


end1:

mov word[return_value],1

end:

pop di
pop si
pop dx
pop cx
pop bx
pop ax
pop bp
ret 12



arr1: dw 1,1,2,3,4,4,5
arr2: dw 4,4,4,5
size1: dw 7
size2: dw 4
return_value: dw 0
counter:dw 0


start:
mov bx,arr1                     ;pushing the adress of arr1 into the stack as parameter
push bx

mov bx,arr1+14                  ;pushing the adress of element after the last element in array1
push bx                    

mov bx,arr2                     ;pushing the adress of arr2 into the stack as a parameter 
push bx

mov bx,arr2+6                   ;pushing the adddress of element after the last element in array2
push bx

mov ax,[size1]                  ;pushing the size 1 to the stack as parameter
push ax

mov ax,[size2]                  ;pushing the size 2 to the stack as parameter
push ax

call check_array








mov ax,0x4c00
int 21h