# Sum and Difference of 2 integers

.globl __start

__start: 

    li $v0, 5         # read the first integer
    syscall

    move $t0, $v0     # move the integer that was read from $v0, to $t0

    li $v0, 5         # read the second integer
    syscall

    move $t1, $v0     # move the integer that was read from $v0, to $t1

    add $s0, $t0, $t1 # add the two given integers

    sub $s1, $t0, $t1 # subtract the two given integers

    move $a0, $s0     # move the sum of the two integers to $a0, so it is printed

    li $v0, 1         # print integer for sum
    syscall 

    la $a0, endl      # move the address of label "endl", so the new line character "\n" is printed

    li $v0, 4         # print string "\n"
    syscall 

    move $a0, $s1     # move the difference of the two integers to $a0, so it is printed

    li $v0, 1         # print integer
    syscall 



    li $v0, 10      #exit
    syscall

.data
endl: .asciiz "\n"
