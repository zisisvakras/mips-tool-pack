#  MESSAGES
.data
    ReadFloating: .asciiz "Insert a float : "
    ones: .asciiz "Ones: "
    zeros: .asciiz " Zeros: "
    EOP: .asciiz "Exiting..."
    zero: .float 0.0
.text
.globl main

main:
    l.s $f2, zero
    loop:
    la $a0, ReadFloating
    jal print_string
    jal read_float
    mov.s $f12, $f0
    jal print_float
    jal print_endl
    # check for zero
    c.eq.s $f0, $f2
    bc1t end_main
    # calculate bits
    mfc1 $s0, $f0
    li $t0, 0
        innerloop:
        andi $t1, $s0, 1
        add $t0, $t0, $t1
        srl $s0, $s0, 1
        bne $s0, $zero, innerloop
    la $a0, ones
    jal print_string
    move $a0, $t0
    jal print_int
    la $a0, zeros
    jal print_string
    li $t1, 32
    sub $a0, $t1, $t0
    jal print_int
    jal print_endl
    j loop
    end_main:
    la $a0, EOP
    jal print_string
    j exit


###
#  A collection of syscalls in mips-assembly
###

#  Prints integer given in $a0
print_int:
    li $v0, 1
    syscall
    jr $ra

#  Prints float given in $f12
#  Use "mov.s $f12, $???" to move float to reg
print_float:
    li $v0, 2
    syscall
    jr $ra

#  Prints string given in $a0
#  Use "la $a0, label" to specify string address
print_string:
    li $v0, 4
    syscall
    jr $ra

#  Read float from input
#  Float will be in $f0
read_float:
    li $v0, 6
    syscall
    jr $ra

# Exits the program
exit:
    li $v0, 10
    syscall

#  Prints new line, overwrites $a0
print_endl:
    li $a0, 10
    li $v0, 11
    syscall
    jr $ra