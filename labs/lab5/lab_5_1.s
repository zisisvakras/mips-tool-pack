#################################################
#												#
#				text segment					#
#												#
#################################################
#											    #
#            Read and Print Float               #
#                                               #
#################################################

.text
.globl     __start	
											
__start:

	read_float:
		li	$v0, 6	# read float which is stored in $f0
		syscall

		mov.s $f12, $f0		# move the value of $f0, in which the given float number is stored
							# to $f12, which stores the float that is printed with the prin float syscall

		li	$v0, 2
		syscall

	print_endl2:	
		li	$a0, 10			# char of newline		
		li	$v0, 11 		# system call to print
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


