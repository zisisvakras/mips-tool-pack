# Reading memory 

<<<<<<< HEAD
=======
# int a=0x12, b=0x13, c=0x0;
# c = a+b;

>>>>>>> 730716c6956578349ae5d6674c78ffe91cd72358
.data 
#offset:  .word 0x10010000
a: .word 0x00000012
b: .word 0x00000013
c: .word 0x00000000

.text

.global main 
# load address of each variable
la  $t0, a
la  $t1, b
la  $t2, c
# load values fromthe  memory
lw $s1 0($t0) 
<<<<<<< HEAD
lw $s2 0($t1)
jal func  
=======
lw $s2 0($t1) 
# make operations
>>>>>>> 730716c6956578349ae5d6674c78ffe91cd72358
add $s3, $s2, $s1
# save result
sw $s3, 0($t2)

li	$v0, 10		# system call code for exit = 10
syscall		

 


