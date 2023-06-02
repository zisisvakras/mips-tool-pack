#  Calculate the length of string in $a0
#  Returns length in $v0 (without \0)
#  overwrites $t0
strlen:
    addi $v0, $a0, -1
strlenloop:
    lb $t0, 1($v0)
    addi $v0, $v0, 1
    bne $t0, $zero, strlenloop
    sub $v0, $v0, $a0
    jr $ra
