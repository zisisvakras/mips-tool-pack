 .text
 .globl __start
__start:
 la $a0,n
 lw $t0,0($a0) # $t0 = n
 li $t2,1 # $t2 index i=1..n
 li $t1,1 # $t1 contains i!
 l.s $f12, ns
 l.s $f1, ns
 
 
loop: mul.s $f12,$f1,$f12
 move $a0,$t2
 li $v0,1
 syscall # display i
 la $a0,msg1
 li $v0,4
 syscall # display "! is :"
 li $v0,2
 syscall # display i!
 la $a0,endl
 li $v0,4
 syscall # print end of line
 addi $t2,$t2,1 # i=i+1
 mtc1 $t2, $f1
 cvt.s.w $f1, $f1
 ble $t2,$t0,loop # repeat if i<=n
 
 
 
 
 
 li $v0,10 # exit
 syscall



newl:
	la $a0, endl
	li $v0, 4
	syscall
	jr $ra

 .data
n: .word 25
ns: .word 0x3f800000
msg1: .asciiz "! is :"
endl: .asciiz "\n" 
