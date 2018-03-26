[org 0x0100]

mov bx,arr1                         ;storing address of array1
mov si,arr2                         ;storing address of array2
mov bp,re                           ;storing address of array3
mov di,arr2+5


                

loop1:
mov al,[bx]                    ;retrieving the first element of arr1
cmp al,-1
jz exit

cmp si,di
je increment


cmp al,[si]                         ;comparing the first element of arr1 with first element of array2
je pu                               ;jump if equal
jne loop2                           ;jump if not equal

pu:mov [bp],al                      ;put the common element to first index of result
add bp,1                            ;increment the index of result array
add bx,1                            ;now point to next element of array1 
;mov al,[bx]                         ;mov the next element to al register
jmp loop1                           ;repeat the procedure for this next element 
 
loop2:
add si,1                            ;point to the next element in the array2
jmp loop1                           ;now back to the loop to check out the rst of element


increment:
mov si,arr2
add bx,1
jmp loop1

arr1: db 1,45,19,5,20,35,-1
arr2: db 3,1,5,45,19,15
re:  db 0,0,0,0,0,0,0,0,0

exit:
mov ax,0x4c00
int 21h