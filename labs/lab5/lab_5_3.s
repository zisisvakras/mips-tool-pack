# Factorial with floats

.data
    fac:  .asciiz "! = "
    endl: .asciiz "\n"
.text
.globl main

main:
    la $s0, 21         # 20!
    li $t0, 1          # move 1 to c1
    mtc1 $t0, $f12
    cvt.s.w $f12, $f12 # convert to float
    
loop:
    mtc1 $t0, $f0
    cvt.s.w $f0, $f0
    mul.s $f12, $f12, $f0
    move $a0, $t0
    jal print_int
    la $a0, fac
    jal print_str
    jal print_float
    la $a0, endl
    jal print_str
    addi $t0, $t0, 1
    bne $t0, $s0, loop
    j exit


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

# Exits the program
exit:
    li $v0, 10
    syscall

# Print string in $a0
print_str:
    li $v0, 4
    syscall
    jr $ra