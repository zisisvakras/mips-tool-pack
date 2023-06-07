#          Factorial with Floats                

.text
.globl __start

__start:
    la $a0,n
    lw $t0, 0($a0)   # $t0 = n
    li $t2, 1    # $t2 index i=1..n
    li $t1, 1    # $t1 contains i!

    mtc1 $t1, $f1       # move to coprocessor the value of $t1 to floating point register $f1

    cvt.s.w $f3, $f1    # convert the integer value of $f1 to floating point value in $f3
 
    loop: 
        mtc1 $t2, $f2
        cvt.s.w $f4, $f2

        mul.s $f3, $f3, $f4   # multiply 2 floats

        mov.s $f12, $f4      #move the value of $f4 to $f12 so it is prinnted by syscall
        li $v0,2
        syscall # display i

        la $a0,msg1
        li $v0,4
        syscall # display "! is :"

        mov.s $f12,$f3      #move the value of $f3 to $f12 so it is prinnted by syscall

        li $v0,2
        syscall # display i!

        la $a0,endl
        li $v0,4
        syscall # print end of line

        addi $t2,$t2,1 # i=i+1
        cvt.w.s $f1, $f3
        mfc1 $t1, $f3
        ble $t2, $t0, loop

    li $v0,10 # exit
    syscall


.data
n: .word 25
msg1: .asciiz "! is :"
endl: .asciiz "\n"


