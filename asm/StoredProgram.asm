#   MIPS stored programm

	addi $t0, $s0, 0x2000	# initialize t0 with the Data memory offset 0x00002000
	li $s0, 10		# load s0 register with the value 10
	add $s1, $s0, $s0       # make the sum 
	sw  $s1, 0($t0)         # store data in data memory 
	
	lw  $s2, 0($t0)		# get data from data memory 
	sll $s3, $s2, 2		# shift left s2 one position 
	sw  $s3, 4($t0)         # store data in data memory 

