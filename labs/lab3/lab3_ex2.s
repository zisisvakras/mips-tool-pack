# Lab 3 - Exercise 2

.text
.globl __start

__start:
	li t0, 0x12345678     # source      (little endian)
	li t1, 0              # destination (big endian)
	
	li t2, 4
loop:
	# Get the least significant byte of t0,
	andi t3, t0, 0xff
	srli t0, t0, 8

	# And add it as t1's new least significant byte.
	slli t1, t1, 8
	or t1, t1, t3

	addi t2, t2, -1
	bnez t2, loop

	# exit
	li a7, 10
	ecall
