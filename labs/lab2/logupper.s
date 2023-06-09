.data
	w:	.word 63
.text
	.globl main

main:   # load
		lw  $s0, w
		li 	$s1, 31
		li  $s2, 32
loop:
		srl $t0, $s0, $s1
		bne $zero, $t0, exit
		addi $s1, $s1, -1
		j loop
exit:
		sllv $t0, $t0, $s1
		xor $s0, $s0, $t0
		beq $zero, $s0, exit2
		addi $s1, $s1, 1
exit2:		
		li $v0, 10
		syscall
