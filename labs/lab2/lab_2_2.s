# Little Endian to Big Endian

.text
.globl __start

__start: 

    lw $t5, w1          # load the word (4 bytes) from address of label "w1", in $t5

    # Least Significant Byte in place of Most Significant Byte
    sll $t0, $t5, 24    # shift left logical by 24 bits in the value that is stored in $t5,
                        #  so the 24 Most Significant Bits are lost

    # Most Significant Byte in place of Least Significant Byte
    srl $t1, $t5, 24    # shift right logical by 24 bits in the value that is stored in $t5, 
                        # so the 24 Least Significant Bits are lost

    # Second Most Significant Byte to Second Least Significant Byte
    sll $t2, $t5, 8     # shift left logical the value of $t5 by 8 bits, so the
                        # 8 Most Significant Bits are lost
    srl $t2, $t2, 24    # shift right logical the value of $t2, which has the value
                        # of $t5 after the sll, so the 24 Least Significant Bits are lost
    sll $t2, $t2, 8     # shift left logical the value of $t2 by 8 bits, so the Second Most
                        # Significant Byte gets in the place of the Second Least Significant Byte

    # Second Least Significant Byte to Second Most Significant Byte
    sll $t3, $t5, 16    # shift left logical the value of $t5 by 16 bits, so the 16 
                        # Most Significant Bits are lost
    srl $t3, $t3, 24    # shift right logical so the 24 Least Significant Bits are lost
    sll $t3, $t3, 16    # shift left logical so the Second Least Significant Byte is in the place
                        # of the Second Most Significant Byte

    or $t4, $t0, $t1    # or between $t0 and $t1, so we make the new MSB and LSB
    or $t6, $t2, $t3    # or between $t2 and $t3, so we make the 2 middle Bytes

    or $t7, $t4, $t6    # or $t3 and $t6 to "build" the new reversed word


    li $v0, 10          # exit
    syscall

.data

w1: .word 0x12345678
