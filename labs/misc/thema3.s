#   Check whether a Given Number is Integer     

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

.data
endl: 					.asciiz 	"\n"
int:        			.asciiz     "FOUND_INTEGER="
not_int: 				.asciiz     "NOT_INTEGER"
zero:      .float 0.0

