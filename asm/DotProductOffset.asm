# Dot product implementation on MIPS
# Author K.Herman
# 2018

# static vector in RAM memory which starts at 0x10010000
.data 
x: .word 0x00000001, 0x00000002, 0x00000003, 0x00000004
y: .word 0x00000002, 0x00000004, 0x00000001, 0x00000005
res: .word 0x00000000
# assembly section 
.text
.global main 
	add $t4, $t4, 4           # set loop counter to 4
loop:   
        lw $v0, x($t7)            # load  value of x  using address with offset
        lw $v1, y($t7)		  # load  value of y  using address with offset
	mul $t5, $v1, $v0	  # multiply v1*v0 and save in t5 
	add $t6, $t6, $t5         # accumulate res = res + mul;
	addi $t7, $t7, 0x4        # increment offset
	subi $t4, $t4, 0x1        # decrement loop counter  
	bnez $t4,  loop           # verify loop condition 
	sw  $t6, res 	          # save result in RAM



  
