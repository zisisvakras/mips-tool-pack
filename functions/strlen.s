#  Calculate the length of string in $a0
#  Returns length in $v0 (without \0)
strlen:
    addi $sp, $sp, -4    # make space in stack
    sw $t0, 0($sp)       # keep t0 in stack
    addi $v0, $a0, -1
strlenloop:
    lb $t0, 1($v0)
    addi $v0, $v0, 1
    bne $t0, $zero, strlenloop
    sub $v0, $v0, $a0    # prepare return value
    lw $t0, 0($sp)       # restore t0 from stack
    addi $sp, $sp, 4
    jr $ra
