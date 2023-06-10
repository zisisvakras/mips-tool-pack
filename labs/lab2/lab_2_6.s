.data
	al:	.word 0xf2345678
	ah:	.word 0xff654321
	bl:	.word 0xf2345678
	bh:	.word 0xff654321
.text
	.globl main

main:   ## low section
		# load
		lw   $s0, al
		lw   $s1, bl
		addu $s2, $s1, $s0 # sum
		# si'ai + si'bi
		nor  $s2, $s2, $zero
		or   $s3, $s1, $s0
		and  $s3, $s3, $s2
		# + aibi
		and  $t0, $s1, $s0
		or   $s3, $s3, $t0
		# shift to leave 1 bit
		srl  $s3, $s3, 31
		
		## high section
		lw   $s0, ah
		addu $s0, $s0, $s3
		lw   $s1, bh
		addu $s2, $s1, $s0 # sum
		# si'ai + si'bi
		nor  $s2, $s2, $zero
		or   $s3, $s1, $s0
		and  $s3, $s3, $s2
		# + aibi
		and  $t0, $s1, $s0
		or   $s3, $s3, $t0
		# shift to leave 1 bit
		srl  $s3, $s3, 31
		# exit
		li   $v0,10
		syscall