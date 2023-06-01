 .text
 .globl __start
__start:
 la $a0,n
 lw $t0,0($a0) # $t0 = n
 li $t2,1 # $t2 index i=1..n
 li $t1,1 # $t1 contains i!
 l.s $f0, ns
 l.s $f1, ns
 mov.s $f3, $f0
 mtc1 $t0, $f2
 cvt.s.w $f2, $f2
 
 
loop: mul.s $f0,$f1,$f0
 mov.s $f12, $f1
 li $v0,2
 syscall # display i
 la $a0,msg1
 li $v0,4
 syscall # display "! is :"
 mov.s $f12, $f0
 li $v0,2
 syscall # display i!
 la $a0,endl
 li $v0,4
 syscall # print end of line
 add.s $f1,$f1,$f3 # i=i+1
 c.eq.s  $f1, $f2
 bc1f loop# repeat if i<=n

 
 
 
 
 li $v0,10 # exit
 syscall



newl:
	la $a0, endl
	li $v0, 4
	syscall
	jr $ra

printf:
	 

 .data
n: .word 25
ns: .word 0x3f800000
msg1: .asciiz "! is :"
endl: .asciiz "\n" 
