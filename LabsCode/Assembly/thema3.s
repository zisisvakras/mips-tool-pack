#################################################
#												#
#				text segment					#
#												#
#################################################
#												#
#   Check whether a Given Number is Integer     #
#												#
#################################################

	.text
	.globl     __start	
												
__start:

	loop:
		li $v0, 6	# read float, which is store in $f0 
		syscall

		la $t0, zero
		l.s $f10, 0($t0)	# load the float 0.0 from the address of "zero" label

		c.eq.s $f0, $f10	# if the given number is 0.0 the program ends
		bc1t Exit

		cvt.w.s $f1, $f0	# we convert the floating point value of $f0 to an integer 
							# and store it in $f1
		cvt.s.w $f2, $f1	# we convert the integer stored in $f1 to a float and store
							# it in $f2

		c.eq.s $f2, $f0		# if the value of $f2 is equal to $f0, it means that the integer
		bc1t is_int			# and the float of the given number is the same, which means the
							# number is an integer
		la $a0, not_int		# else the number is not an integer
		li $v0, 4			# and the correct string is printed
		syscall
		la $a0, endl		# print new line character "\n"
		li $v0, 4
		syscall

		j loop				# jump to the "loop" label

	is_int:
		la $a0, int			# prints the string for the case the given number is an integer
		li $v0, 4
		syscall

		mov.s $f12, $f0		# print the number
		li $v0, 2
		syscall

		la $a0, endl		# print the new line character "\n"
		li $v0, 4
		syscall

		j loop				# jump to the "loop" label

	Exit:
		li 	$v0, 10
		syscall				#au revoir...

#################################################
#			 									#
#     	 	data segment						#
#												#
#################################################

	.data
endl: 					.asciiz 	"\n"
int:        			.asciiz     "FOUND_INTEGER="
not_int: 				.asciiz     "NOT_INTEGER"
zero:      .float 0.0

#################################################
#			 									#
#     	 	Usefull code						#
#												#
#################################################

print_endl1:		la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
					jr $ra

print_endl2:		li		$a0, 10			# char of newline
					li		$v0, 11 		# system call to print
					syscall
					jr $ra
					
read_str:			li $v0, 8					# code to read a string
					#la $a0, ???				# ??? --> label with string
					#li $a1, ?n?				# n chars --> $a1=n+1 eg: (20+1)--> li $a1, 21
					syscall
					jr $ra

print_str:			li $v0, 4
					#la $a0, ???					# ??? --> label with string
					syscall
					jr $ra

read_int:			li $v0, 5				# $v0 <--- integer
					syscall
					jr $ra

print_int_from_reg:	#move	$a0, ???			# ???  --> register with integer
					li $v0, 1
					syscall
					jr $ra

print_immidiate:	li $v0, 1
					#li $a0, ???					# ???  --> immediate
					syscall
					jr $ra

leaf_proc_not_using_stack:  	
					#...........
					jr $ra
					
leaf_proc_using_stack:  #.....
			     		addi $sp, $sp, -16 # 4 words --> 4 word *4 byte / word = 16 bytes
						#...........
						#sw $x1, 0 ($sp)
						#...........
						#sw $x2, 4 ($sp)
						#...........
						#sw $x3, 8 ($sp)
						#...........
						#sw $x4, 12 ($sp)
						#...........
						#...........
						#lw $x1, 0 ($sp)
						#...........
						#lw $x2, 4 ($sp)
						#...........
						#lw $x3, 8 ($sp)
						#...........
						#lw $x4, 12 ($sp)
						#...........
						addi $sp, $sp, 16
						#...........
						jr $ra
						
any_procedure:			#...........
						jr $ra
							
node_proc_using_stack:  #...........
			     		addi $sp, $sp, -16 # 3 words --> 3 word *4 byte / word = 12 bytes + 4 bytes for $ra = 16 bytes
						#...........
						#sw $ra, 12 ($sp)
						#...........
						#sw $x3, 8 ($sp)
						#...........
						#sw $x2, 4 ($sp)
						#...........
						#sw $x1, 0 ($sp)
						#...........
						#...........
						jal any_procedure  # could be "node_proc_using_stack"
						#...........
						#...........
						#lw $x1, 0 ($sp)
						#...........
						#lw $x2, 4 ($sp)
						#...........
						#lw $x3, 8 ($sp)
						#...........
						lw $ra, 12 ($sp)
						#...........
						addi $sp, $sp, 16
						#...........
						jr $ra
						
switch_case_no_break:   #...........
						#move $XY, $zero     	# initialize flag register $XY
		case01:			#bXX $YY,$ZZ, case02 	# this condition/case is not valid, check next case 	
		if_case01:		#...........
						#addi $XY, $XY, 1
						
		case02:			#bXX $YY,$ZZ, case?? 	# this condition/case is not valid, check next case 	
		if_case02:		#...........
						#addi $XY, $XY, 1						

						#...........
						
		case0n:			#bXX $YY,$ZZ, case03 	# this condition/case is not valid, check next case 	
		if_case0n:		#...........
						#addi $XY, $XY, 1
						
		else_case:		#bne $XY,$zero, Exit	# non of previous conditions/cases exit, exit 	
		if_non_case:	#...........
						
switch_case_with_break: #...........
		case001:		#bXX $YY,$ZZ, case02 	# this condition/case is not valid, check next case 	
		if_case001:		#...........
						#j Exit_switch_case
						
		case002:		#bXX $YY,$ZZ, case?? 	# this condition/case is not valid, check next case 	
		if_case002:		#...........
						#j Exit_switch_case						

						#...........
						
		case00n:		#bXX $YY,$ZZ, else_case 	# this condition/case is not valid, check next case 	
		if_case00n:		#...........
						#j Exit_switch_case
						
		else_case_:		#...........	 		# non of previous conditions/cases exit 	
		if_non_case_:	#...........
		
while_do_1_condition:   #...........
						#bXX $YY,$ZZ, exit_while

						#...........
						#addi #counter, #counter, 1  #possible approach
						
						j while_do_1_condition
		
while_do_a_AND_b:   	#...........				# when !a OR !b, exit while
						#bXX $RR,$ZZ, exit_while    # if a is not valid exit while
						#bYY $WW,$TT, exit_while    # if b is not valid exit while

						#...........
						#addi #counter, #counter, 1  #possible approach
						
						j while_do_a_AND_b
		
while_do_a_OR_b_1:   	#...........				# when !a AND !b, exit while
						#bXX $RR,$ZZ, exit_while    # if !a is not valid exit while
						#bYY $WW,$TT, exit_while    # if !b is not valid exit while

						#...........
						#addi #counter, #counter, 1  #possible approach
						
						j while_do_a_OR_b_1
		
while_do_a_OR_b_2:   	#...........				# when !a AND !b exit wile
			check_a:	#bXX $RR,$ZZ, check_b    	# if a is not valid check b
						
			do:			#...........
						#addi #counter, #counter, 1  #possible approach
						#j while_do_a_OR_b_2
			
			check_b:	#bYY $WW,$TT, exit_while    # if b is not valid exit while
						
						j do
exit_while:

