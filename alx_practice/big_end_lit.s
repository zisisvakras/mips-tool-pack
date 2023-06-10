.data

ghdjs: .word 0x30313233
alxword: .asciiz "ABCD"

.text
.globl _start

_start:

    la $a0, ghdjs
    lw $a1, 0($a0)

    move $a0, $a1
    jal little_endian_to_big
    move $s0, $v0

    li $v0, 10
    syscall

## INTEL'S DEFAULT IS LITTLE ENDIAN AND MIPS SIMULATOR IS FOLLOWING IT
little_endian_to_big: ## word $a0, result $v0

    li $t0, 0x000000FF
    li $t1, 0x0000FF00
    li $t2, 0x00FF0000
    li $t3, 0xFF000000

    and $t4, $a0, $t0
    and $t5, $a0, $t1
    and $t6, $a0, $t2
    and $t7, $a0, $t3

    sll $t4, $t4, 24
    sll $t5, $t5, 8
    srl $t6, $t6, 8
    srl $t7, $t7, 24

    li $v0, 0
    or $v0, $v0, $t4
    or $v0, $v0, $t5
    or $v0, $v0, $t6
    or $v0, $v0, $t7

    jr $ra

