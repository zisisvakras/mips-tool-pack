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
	la $t0, x                 # set pointer to x in the register t0
	la $t1, y                 # set pointer to y in the register t1
	add $t4, $t4, 4           # set loop counter to 4
loop:   
        lw $v0, ($t0)             # load pointer to the x  vector into v0
        lw $v1, ($t1)		  # load pointer to the y  vector into v0
	mul $t5, $v1, $v0	  # multiply v1*v0 and save in t5 
	add $t6, $t6, $t5         # accumulate res = res + mul;
	addi $t0, $t0, 0x4        # increment x array address 
	addi $t1, $t1, 0x4        # increment y array address
	subi $t4, $t4, 0x1        # decrement loop counter  
	bnez $t4,  loop           # verify loop condition 
	sw  $t6, res 	          # save result in RAM



  
