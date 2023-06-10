#  MESSAGES
.data
    buffer: .space 100
    errormsg: .asciiz "Incorect input\n"
    endl: .asciiz "\n"
    bye: .asciiz "\nEnd of program...\n"
    p0: .asciiz "000"
    p1: .asciiz "001"
    p2: .asciiz "010"
    p3: .asciiz "011"
    p4: .asciiz "100"
    p5: .asciiz "101"
    p6: .asciiz "110"
    p7: .asciiz "111"


.text
.globl main

main:

    loop_main:
        la $a0, buffer
        li $a1, 90
        jal read_string
        move $s0, $a0
        jal print_string
        # jal print_endl
        move $a0, $s0
        lb $t0, 0($a0)
        # Checking the STR
        check_str:

            bge $t0, 56, error # $t0 >= '8'
            ble $t0, 47, error # $t0 <= '0'-1

            addi $a0, $a0, 1
            lb $t0, 0($a0)
        bne $t0, 10, check_str

        sub $s1, $a0, $s0
        bne $s1, 4, error
        j continue_check
        error:
            move $t9, $a0
            la $a0, errormsg
            jal print_string
            move $a0, $t9
            j loop_main
        continue_check:

        # Evaluate the STR 
        move $a0, $s0
        lb $t0, 0($a0)
        li $t7, 0 # flag = 0
        conv_bin:
            move $t9, $a0
            beq $t0, 48, print_0
            li $t7, 1 # flag = 1
            beq $t0, 49, print_1
            beq $t0, 50, print_2
            beq $t0, 51, print_3
            beq $t0, 52, print_4
            beq $t0, 53, print_5
            beq $t0, 54, print_6
            beq $t0, 55, print_7

            continue_conv:
            move $a0, $t9
            addi $a0, $a0, 1
            lb $t0, 0($a0)
        bne $t0, 10, conv_bin 
        jal print_endl
        beqz $t7, exit # if flag == 0 (only 0s) exit
        
    j loop_main
    j exit

print_0:
    la $a0, p0
    jal print_string
    j continue_conv

print_1:
    la $a0, p1
    jal print_string
    j continue_conv

print_2:
    la $a0, p2
    jal print_string
    j continue_conv

print_3:
    la $a0, p3
    jal print_string
    j continue_conv

print_4:
    la $a0, p4
    jal print_string
    j continue_conv

print_5:
    la $a0, p5
    jal print_string
    j continue_conv

print_6:
    la $a0, p6
    jal print_string
    j continue_conv

print_7:
    la $a0, p7
    jal print_string
    j continue_conv

#  Prints integer given in $a0
print_int:
    li $v0, 1
    syscall
    jr $ra

#  Prints string given in $a0
#  Use "la $a0, label" to specify string address
print_string:
    li $v0, 4
    syscall
    jr $ra

#  Read integer from input
#  Integer will be in $v0
read_int:
    li $v0, 5
    syscall
    jr $ra

#  Read string from input
#  $a0 will be buffer address and $a1 the length (including the space made for \0)
#  Remember that u can allocate space for a buffer in .data with .space (len)
read_string:
    li $v0, 8
    syscall
    jr $ra

# Exits the program
exit:
    la $a0, bye
    jal print_string
    li $v0, 10
    syscall

#  Prints char given in $a0
print_char:
    li $v0, 11
    syscall
    jr $ra

#  Read char from input
#  Char will be in $v0
read_char:
    li $v0, 12
    syscall
    jr $ra

print_endl:
    addi $sp, $sp, -4
    sw $a0, 0($sp)
    li $a0, 10
    li $v0, 11
    syscall
    lw $a0, 0($sp)
    addi $sp, $sp, 4
    jr $ra
