# Last Carry

.text
.globl __start

__start: 
    lw $t0, w1          # load a in $t0
    lw $t1, w2          # load b in $t1

    addu $t2, $t0, $t1  # unsigned addition of a and b 

    nor $t2, $t2, $zero # not using nor and $zero os we can reverse the bits of $t2, in
                        # which the sum a + b is stored

    srl $t0, $t0, 31    # shift right logical to $t0 by 31 bits, that a is stored to have only the Most Significant Bit
    srl $t1, $t1, 31    # shift right logical to $t1 by 31 bits, that b is stored to have only the Most Significant Bit
    srl $t2, $t2, 31    # shift right logical to $t0 by 31 bits, that the sum of a + b
                        # is stored to have only the Most Significant Bit

    and $t3, $t0, $t2   # and between the Most Significant Bit of a and the reverse MSB of the sum a + b
    and $t4, $t1, $t2   # and between the MSB of b and the reverse MSB of sum a + b
    and $t5, $t0, $t1   # and between the MSB of a and the MSB of b

    or $t6, $t3, $t4    # or between the first "and" with the second
    or $t7, $t6, $t5    # or between the above or and the third "and"


    li $v0, 10          # exit
    syscall

.data

w1: .word 0xff000000
w2: .word 0xff000000
