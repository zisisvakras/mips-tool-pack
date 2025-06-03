# Lab 3 - Exercise 1

.text
.globl __start

__start:
	li t0, 5
		
	# Fast way to compute Gray code.
	# We XOR with the same number shifted right by 1.
	# This follows from the mathematical definition.
	srli t1, t0, 1	
	xor t1, t0, t1
	
	# exit
	li a7, 10
	ecall
