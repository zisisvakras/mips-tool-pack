    .text
    .globl __start
__start:
    # start of main program
    li $a0,-10 # Initialize variables
    li $a1,-30 #
    li $a2,120 #
    li $a3,200 #

    jal MinMax

    move $t0,$v0
    move $t1,$v1
    la $a0,max
    li $v0,4
    syscall # display "Max is :"
    move $a0,$t0
    li $v0,1
    syscall # display max
    la $a0,endl
    li $v0,4
    syscall # display end of line
    la $a0,min
    li $v0,4
    syscall # display "Min is :"
    move $a0,$t1
    li $v0,1
    syscall # display min
    la $a0,endl
    li $v0,4
    syscall # display end of line
    li $v0,10
    syscall # exit
# end of main program

# start of procedure

MinMax:
    or $v0, $a0, $zero

    bge $v0, $a1, continue1
        or $v0, $a1, $zero
    continue1:

    bge $v0, $a2, continue2
        or $v0, $a2, $zero
    continue2:

    bge $v0, $a3, continue3
        or $v0, $a3, $zero
    continue3:

    or $v1, $a0, $zero

    ble $v1, $a1, continue4
        or $v1, $a1, $zero
    continue4:

    ble $v1, $a2, continue5
        or $v1, $a2, $zero
    continue5:

    ble $v1, $a3, continue6
        or $v1, $a3, $zero
    continue6:
    
    jr $ra
# end of procedure

.data
max: .asciiz "Max is : "
min: .asciiz "Min is : "
endl: .asciiz "\n"
