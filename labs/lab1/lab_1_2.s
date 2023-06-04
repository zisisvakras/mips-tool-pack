###################################################
#                                                 #
#     Load from Address as Unsigned and Signed    #
#                                                 #
###################################################

.text
.globl __start

__start: 

    lbu $t0, b1     # load the byte from label "b1" as unsigned, in $t0
    lhu $t1, b1     # load the half word (2 bytes) from label "b1" as unsigned, in $t1
    lw  $t2, b1     # load the word (4 bytes) from label "b1", in $t2
    
    lbu $t3, b1 + 4 # load the byte from the address of label "b1" + 4 as unsigned, in $t3
    lhu $t4, b1 + 4 # load the half word (2 bytes) from the address of label "b1" + 4 as unsigned, in $t4
    lw  $t5, b1 + 4 # load the word (4 bytes) from the address of label "b1" + 4, in $t5
                    
    
    lb $t0, b1      # load the byte from label "b1" as signed, in $t0
    lh $t1, b1      # load the half word (2 bytes) from label "b1" as signed, in $t1
    lw $t2, b1      # load the word (4 bytes) from label "b1", in $t2
    
    lb $t3, b1 + 4  # load the byte from the address of label "b1" + 4 as signed, in $t3
    lh $t4, b1 + 4  # load the half word (2 bytes) from the address of label "b1" + 4 as signed, in $t4
    lw $t5, b1 + 4  # load the word (4 bytes) from the address of label "b1" + 4, in $t5
               
    lb $t6, b1 + 4  # load the byte from address of label "b1" + 4, in $t6
    
    sb $t6, b1 + 16 # store the byte that is stored in $t6, in address of label "b1" + 16
    
    li $v0, 10      # exit
    syscall

.data

b1: .byte 0x01, 0x02, 0x03, 0x04, 0x81, 0x82, 0x83, 0x84
w1: .word 0x12345678, 0x87654321
