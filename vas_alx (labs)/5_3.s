.text
.globl     __start

#a0 - f0
#t1 - f1
#t2 -f2
#t0 - f3
#$f11 - 1
__start:
    lwc1 $f0, n
    cvt.s.w $f0, $f0

    lwc1 $f11, one
    cvt.s.w $f11, $f11

    #lw $t0,0($a0) # $t0 = n
    mov.s $f3, $f0

    #li $t2,1 # $t2 index i=1..n
    mov.s $f2, $f11 
    #li $t1,1 # $t1 contains i!
    mov.s $f1, $f11

loop: mul.s $f1, $f1, $f2
    mov.s $f0, $f2
    li $v0, 1
    syscall # display i

    la $a0, msg1
    li $v0, 4
    syscall # display "! is :"
    
    move $a0, $t1
    li $v0, 1
    syscall # display i!
    
    la $a0, endl
    li $v0, 4
    syscall # print end of line
    
    add.s $f2, $f2, $f11 # i=i+1
    c.le.s $f2, $f3 # repeat if i<=n
    bc1t loop
    li $v0,10 # exit
    syscall


li $v0, 10
syscall #au revoir


.data
n: .word 25
one: .word 1
msg1: .asciiz "! is :"
endl: .asciiz "\n"
