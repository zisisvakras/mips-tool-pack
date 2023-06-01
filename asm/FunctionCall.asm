# Function call
#  High level C code 
#	  int sum(int a, int b){
#		return a+b;
#	  }

# arguments
# a = $a0
# b = $a1
# ret value $v0

	.text
	.global main 
        li $a0, 22		# initialize a
        li $a1, 4		# initialize b
        li $s0, 255		# initialize $s0 to observe the stack
        li $s1, 127		# initialize $s1 to observe the stack
	jal func	    	# call the function 
	move $s4, $v0  		# move result to the s4 register 
	sw $s4, 0($0)		# save s4 into the memory
	
	move $a0, $s4	   	# move result to the a0 reg to display it    
	li	$v0, 1		# configure syscall to print int from a0 register  
	syscall			# call syscall
	

	li	$v0, 10		# system call code for exit = 10
	syscall			# call syscall

	func: 
	addi $sp, $sp, -12	# allocate space for 3 variables
	sw $ra, 8($sp)		# save return address in case of nested function call
	sw $s0, 4($sp)		# save the s0 and s1 regs
	sw $s1, 0($sp)		
	add $s0, $a0, $a1	# perform the operations using s0 reg !!!!!!
	move $v0, $s0 		# move the result to the  v0 reg 
	lw $ra, 8($sp)		# recall the orginal register state 
	lw $s0, 4($sp)	
	lw $s1, 0($sp)
	addi $sp, $sp, 12	# deallocate stac memory 	
	jr $ra			# jump to the caller
 


