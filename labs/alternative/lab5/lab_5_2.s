#          "Special" Float Numbers   

.text
.globl     __start	
											
__start:

	# load the addresses from the labels of the special numbers in .data, in temporary registers
	la $t0, x		
	la $t1, y
	la $t2, zero
	la $t3, plus
	la $t4, minus
	la $t5, NaN
	
	# load the "special" numbers in registers, from the addresses of the labels		
	l.s $f5, 0($t0)			
	l.s $f6, 0($t1)
	l.s $f7, 0($t2)
	l.s $f8, 0($t3)
	l.s $f9, 0($t4)
	l.s $f10, 0($t5)
	
	mul.s $f0, $f5, $f6		#multiply 2 floats
	
	mov.s	$f12, $f0		#move the result to $f12 so it can be printed with syscall
		
	print_float:		li $v0, 2
						syscall
	
	print_endl:			li		$a0, 10			# char of newline
						li		$v0, 11 		# system call to print
						syscall					
						
						 
	mul.s $f0, $f5, $f9	
	
	mov.s	$f12, $f0
		
	print_float2:		li $v0, 2
						syscall
		
	print_endl2:		li		$a0, 10			# char of newline
						li		$v0, 11 		# system call to print
						syscall
			
	div.s $f0, $f6, $f7		#divide 2 floats
	
	mov.s	$f12, $f0
		
	print_float3:		li $v0, 2
						syscall
		
	print_endl3:		li		$a0, 10			# char of newline
						li		$v0, 11 		# system call to print
						syscall
						
	div.s $f0, $f7, $f7
	
	mov.s	$f12, $f0
		
	print_float4:		li $v0, 2
						syscall
		
	print_endl4:		li		$a0, 10			# char of newline
						li		$v0, 11 		# system call to print
						syscall			
	
	mul.s $f0, $f7, $f8
	
	mov.s $f12, $f0
		
	print_float5:		
		li $v0, 2
		syscall
		
	print_endl5:		
		li	$a0, 10			# char of newline
		li	$v0, 11 		# system call to print
		syscall			
	
	div.s $f0, $f8, $f9
	
	mov.s $f12, $f0
		
	print_float6:		
		li $v0, 2
		syscall
		
	print_endl6:		
		li	$a0, 10			# char of newline
		li	$v0, 11 		# system call to print
		syscall	
	
	add.s $f0, $f8, $f9		#add 2 floats
	
	mov.s $f12, $f0
		
	print_float7:		
	    li $v0, 2
		syscall
		
	print_endl7:		
		li	$a0, 10			# char of newline
		li	$v0, 11 		# system call to print
		syscall	
	
	add.s $f0, $f5, $f10
	
	mov.s $f12, $f0
		
	print_float8:		
		li $v0, 2
		syscall
		
	print_endl8:
		li	$a0, 10			# char of newline
		li	$v0, 11 		# system call to print
		syscall	
	
	
	Exit:				
		li 	$v0, 10
		syscall				#au revoir...
	
.data

endl: 					.asciiz 	"\n"
x: .float 2.5 # $f5
y: .float -2.0 # $f6
zero: .float 0.0
plus: .word 0x7F800000
minus: .word 0xFF800000
NaN: .word 0x7FBFFFFF
