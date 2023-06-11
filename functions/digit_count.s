#  Returns the digit length 
#  input: $a0, digits: $v0
#  overwrites $a0, $v0, $v1
digit_count:
    li $v0, 0
    li $v1, 10
    digit_count_loop:
    div $a0, $v1
    mflo $a0
    addi $v0, $v0, 1
    bne $a0, $zero, digit_count_loop
    jr $ra