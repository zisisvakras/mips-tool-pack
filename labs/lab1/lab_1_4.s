.text

.globl main

main:

li $v0, 8	# read string
li $a1, 20	# specify length to read
la $a0, buffer	# store read string in buffer
syscall		

li $v0, 4	# print string
la $a0, newl	# print new line
syscall

ulh $t0, newl	# unalligned since its not a multiple of 4
ush $t0, buffer + 5	# add new line characther and null byte after 5th char
			# to only print the first 5 characthers
			# (MIPS prints whats in memory until it reaches
			# a NULL byte (\0) so by placing one we tell it stop printing)

la $a0, buffer	# print buffer	
# no need to li $a0, 4 , its already there
syscall		# print string

li $v0, 10	# exit
syscall





.data
buffer: .space 21	# pilot said to read up to 20 chars
newl: .asciiz "\n"	# asciiz adds a NULL byte after the string