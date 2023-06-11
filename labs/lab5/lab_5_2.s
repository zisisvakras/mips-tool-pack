# Infinity/NaN Showcase

.data
    x:     .float -2.0
    y:     .float 2.5
    zero:  .float 0.0
    plus:  .word 0x7F800000  # 0 11111111 00000000...
    minus: .word 0xFF800000  # 1 11111111 00000000...
    NaN:   .word 0x7FFFFFFF  # 0 11111111 11111111...

.text
.globl main

main:
    l.s $f0, x
    l.s $f1, y
    l.s $f2, zero
    l.s $f3, plus
    l.s $f4, minus
    l.s $f5, NaN
    # x*y
    mul.s $f12, $f1, $f0
    jal print_float
    jal print_endl
    # x*minus
    mul.s $f12, $f4, $f0
    jal print_float
    jal print_endl
    # y/0
    div.s $f12, $f1, $f2
    jal print_float
    jal print_endl
    # 0/0
    div.s $f12, $f2, $f2
    jal print_float
    jal print_endl
    # 0*plus
    mul.s $f12, $f3, $f2
    jal print_float
    jal print_endl
    # plus/minus
    div.s $f12, $f3, $f4
    jal print_float
    jal print_endl
    # plus + minus
    add.s $f12, $f3, $f4
    jal print_float
    jal print_endl
    # x + NaN
    add.s $f12, $f0, $f5
    jal print_float
    jal print_endl
    # exit
    j exit

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

#  Prints new line, overwrites $a0
print_endl:
    li $a0, 10
    li $v0, 11
    syscall
    jr $ra