.text
.globl main

main:

li $a0, 0xFFFFFFF4 
li $a1, 0x00000001

jal ovf_add

j exit


# $a0 + $a1 = $v0
# OVF_flag = $v1
ovf_add:
    move $t1, $a0
    move $t2, $a1

    addu $t0, $t1, $t2
    xor $t3, $t1, $t2
    slt $t3, $t3, $zero
    bne $t3, $zero, no_ovf

    xor $t3, $t0, $t1
    slt $t3, $t3, $zero
    bne $t3, $zero, ovf

    move $v0, $t0
    ovf:
        li $v1, 1
        jr $ra
    no_ovf:
        li $v1, 0
        jr $ra



print_int:
    li $v0, 1
    syscall
    jr $ra

exit: 
    li $v0, 10
    syscall