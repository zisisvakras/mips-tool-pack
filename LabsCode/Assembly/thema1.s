#################################################
#												#
#				text segment					#
#												#
#################################################
#                                               #
#  Find the powers of ten of a 3-digit number   #
#                                               #
#################################################

.text
.globl     __start	
												
__start:

	loop:
		li $v0, 5		# read first int and move it to a temp reg	
		syscall
		move $t0, $v0

		li $t1, 100		# initialize $t1 with 100

		div $t0, $t1	# divide the given number with 100
		
		mflo $t2		# move the quotient from the "lo" register to $t2

		la $a0, res		# print the string of label "res"
		li $v0, 4
		syscall

		move $a0, $t2	# print the quotient of the division as the hundreds
		li $v0, 1
		syscall

		la $a0, ten_sq	# print the string in label "ten_sq"
		li $v0, 4
		syscall

		la $a0, add_sym	# print the "+" symbol
		li $v0, 4
		syscall

		mfhi $t0	# move the remainder from the previous division from "hi" register, to $t0
		
		li $t1, 10	# the value of $t1 is now 10

		div $t0, $t1	# division between the remainder of the first division and 10

		mflo $t2		# print the quotient of the second division as the tens
		move $a0, $t2
		li $v0, 1
		syscall

		la $a0, ten		# print the string in "ten" label
		li $v0, 4
		syscall

		la $a0, add_sym	# print the "+" symbol
		li $v0, 4
		syscall

		mfhi $t0		# print the remainder of the second division as ones
		move $a0, $t0
		li $v0, 1
		syscall

		la $a0, one		# print the string in label "one"
		li $v0, 4
		syscall

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
res:        			.asciiz     "POWERS_SUM="
ten_sq:                 .asciiz     "*10^2"
ten:                    .asciiz     "*10^1"
one:                    .asciiz     "*10^0"
add_sym:                .asciiz     "+"
zero:      .float 0.0

