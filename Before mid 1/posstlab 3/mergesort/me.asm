[org 0x0100]


;merge sort(merging two sorted arrays into single array)

mov bx,arr1      ;storing the address of first element of array1
mov si,arr2      ;storing the address of first element of array2
mov bp,result    ;storing the address of first element of result
mov di,result+16

loop1:
mov ax,[bx]      ;storing the first element of array1 to ax register
mov cx,[si]      ;storing the first element of array2 to cx register
 
cmp ax,cx        ;comparing the elements of two arrays
jb store         ;if the first element of array1 is smaller than the first element 
ja sto

store:

mov [bp],ax         ;moving the first element of ax to first index of result
cmp bx,arr1+6
je putandexit
  

add bx,2      ;now bx points to second element of array1
add bp,2      ;bp points to second slot in result   
cmp bp,di     ;checks whether end of result has reached or not to exit
jz exit       
jmp loop1 

sto:
mov [bp],cx   ;moving element of array2 to result
add si,2      ;pointing si register to the next element in array2
add bp,2      ;pointing bp to next empty slot in result
cmp bp,di
jz exit
jmp loop1 

putandexit:
mov [di],cx
jmp exit


arr1:dw 1,3,5,7
arr2:dw 2,4,6,8
result:dw 0,0,0,0,0,0,0,0
flag: dw 0

exit:
mov word[flag],1
mov ax,0x4c00
int 21h