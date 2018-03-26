[org 0x0100]

jmp start

multiplicand:  dw 0,0,20,0               ;32-bit multiplicand 64 bit space 
multiplier:    dd 5                      ;32-bit multiplier
result:        dw 0,0,0,0                ;32-bit result

start:

mov cl,32                         ;initialize bit count to 32 
                     
;;;;;;;;;;;;;;;;;;Now i will perform 32 bit shift right operation on ax and the dx which is the extended shifting operation;;;;;;;;;;;;;;;;;;

checkbit:

shr word[multiplier+2],1                              ;applying shift right operation on the multiplier 
rcr word[multiplier],1                                ;32bit multiplier
jnc skip                                              ;jump if no carry


;;;;;;;;;;;;;;;;;Now i will add the multiplicand and the result;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


mov dx,[multiplicand+6]
add [result+6],dx
mov dx,[multiplicand+4]
adc [result+4],dx
mov dx,[multiplicand+2]
adc [result+2],dx
mov dx,[multiplicand]
adc [result],dx

;;;;;;;;;;;;;;;;;;;Shift lefting the multiplicand;;;;;;;;;;;;;;;;;;;;;;;;;;

skip:

shl word[multiplicand+6],1                            ;Now shift lefting the 64 bit multiplicand  
rcl word[multiplicand+4],1
rcl word[multiplicand+2],1
rcl word[multiplicand],1
dec cl                                                ;decrement the shift count
jnz checkbit                                          ;repeat if bits left


mov ax,0x4c00
int 21h




     



mov ax,0x4c00
int 21h