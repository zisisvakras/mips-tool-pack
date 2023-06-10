.text
.globl main

main:
    la $a0, msg2 # "Give N"
    jal print_string 
    jal read_int # read N
    move $a0, $v0
    move $s0, $v0 # int n($s0) = N
    jal print_int # print N 


    # INPUT ARRAY
    la $a0, msg3 # "give elements of the array"
    jal print_string
    la $a0, empty_array
    move $a1, $s0 # n = N
    jal read_arr
    
    # PROCESS ARRAY
    # sum
    la $a0, empty_array
    move $a1, $s0
#    jal sum_array
#
#    la $a0, summ
#    move $s3, $v0
#    jal print_string
#    move $a0, $s3
#    jal print_int
#    jal print_endl
    jal sort


    # OUTPUT ARRAY
    la $a0, msg4 # "array is"
    jal print_string
    la $a0, empty_array # now it is not empty
    move $a1, $s0 # $a1 = N
    jal print_arr 

j exit


## Functions

exit:
    li $v0, 10
    syscall


swap: # Lecture code
    sll $t1, $a1, 2
    add $t1, $a0, $t1
    lw $t0, 0($t1)
    lw $t2, 4($t1)
    sw $t2, 0($t1)
    sw $t0, 4($t1)
    jr $ra

sort: # Lecture code without modifications
    addi $sp, $sp, -20
    sw $ra, 16($sp)
    sw $s3, 12($sp)
    sw $s2, 8($sp)
    sw $s1, 4($sp)
    sw $s0, 0($sp)
    # main body

    move $s2, $a0
    move $s3, $a1
    move $s0, $zero
for1tst:
    slt $t0, $s0, $s3
    beq $t0, $zero, exit1
    addi $s1, $s0, -1
for2tst:
    slti $t0, $s1, 0
    bne $t0, $zero, exit2
    sll $t1, $s1, 2
    add $t2, $s2, $t1
    lw $t3, 0($t2)
    lw $t4, 4($t2)
    slt $t0, $t4, $t3
    beq $t0, $zero, exit2

    move $a0, $s2
    move $a1, $s1
    jal swap

    addi $s1, $s1, -1
    j for2tst

exit2:
    addi $s0, $s0, 1
    j for1tst

    # ...
exit1:
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $ra, 16($sp)
    addi $sp, $sp, 20
    jr $ra

# $a0 has the adress of the array
# $a1 has the N (length of the array)
# $tx and $v0 regesters are NOT maintainted 
# $v0 has the SUM
sum_array:
    li $v0, 0
    addi $sp, $sp, -4
    sw $s0, 0($sp)

    # int i = 0 ($s0)
    li $s0, 0 
    for_sum_arr:

        sll $t0, $s0, 2 # $t0 = 4 * $s0 (i)
        add $t0, $t0, $a0 # $t0 = $t0 + $a0 (address of array)
        # so now $t0 has the adress of a[i]

        lw $t1, 0($t0)

        # sum int
        add $v0, $v0, $t1 # v0 += a[i]


    addi $s0, $s0, 1 # ++i
    blt $s0, $a1, for_sum_arr # if (i < n) proceed to one more iteration


    lw $s0, 0($sp)
    addi $sp, $sp, 4
    jr $ra


# $a0 has the adress of the array
# $a1 has the N (length of the array)
# $tx and $v0 regesters are NOT maintainted 
print_arr: # print_arr(int *arr, int n)
    addi $sp, $sp, -4
    sw $s0, 0($sp)

    # int i = 0 ($s0)
    li $s0, 0 
    for_print_arr:
        move $t2, $a0


        sll $t0, $s0, 2 # $t0 = 4 * $s0 (i)
        add $t0, $t0, $a0 # $t0 = $t0 + $a0 (address of array)
        # so now $t0 has the adress of a[i]

        lw $t1, 0($t0)
        move $a0, $t1

        # print_int
        li $v0, 1
        syscall
        # print space 
        li $v0, 11
        li $a0, 32 # ' '/space  
        syscall

        move $a0, $t2 # restore $a0


    addi $s0, $s0, 1 # ++i
    blt $s0, $a1, for_print_arr # if (i < n) proceed to one more iteration

    move $t7, $ra
    jal print_endl
    move $ra, $t7

    lw $s0, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# a0 has the address of the array
# a1 has the N (length of the array)
# $tx and $v0 registers are NOT maintainted
read_arr: # read_arr(int *arr, int n)
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)

    # int i = 0 ($s0)
    li $s0, 0 
    for_read_arr:

        # read integer (saved in $v0)
        li $v0, 5
        syscall

        # int input; ($s1)
        # read_int(intput) 
        move $s1, $v0

        # copy $a0 (address of array)
        move $t2, $a0

        # print integer so that we can see what we typed
        li $v0, 1
        move $a0, $s1
        syscall

        move $a0, $t2 # restore $a0

        sll $t0, $s0, 2 # $t0 = 4 * $s0 (i)
        add $t0, $t0, $a0 # $t0 = $t0 + $a0 (address of array)
        # so now $t0 has the adress of a[i]

        sw $s1, 0($t0)

        # print endl
        li $v0, 11
        li $a0, 32 
        syscall

        move $a0, $t2 # restore $a0

    addi $s0, $s0, 1 # ++i
    blt $s0, $a1, for_read_arr # if (i < n) proceed to one more iteration

    move $t7, $ra
    jal print_endl
    move $ra, $t7

    lw $s0, 0($sp)
    lw $s1, 4($sp)
    addi $sp, $sp, 4
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

print_int:
    li $v0, 1
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


.data
empty_array: .space 400 # 400 bytes = 100 * 4 => 100 integers 

msg1: .asciiz ": "
msg2: .asciiz "Give the N: (up to 100)\n"
msg3: .asciiz "\nGive the elements of the array\n"
msg4: .asciiz "The array you gave is:\n"
summ: .asciiz "The sum is: "
