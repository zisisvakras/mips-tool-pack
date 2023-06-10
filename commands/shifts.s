AllShiftFunctions:

    sll $t0, $t0, 1 # shift left logical ($t0 <<= 1)
    sra $t1, $t1, 1 # shift right arithmetic ($t1 >>= 1)
    srl $t2, $t2, 1 # shift right logical ($t2 >>= 1) (this treats t2 as unsigned)

    sllv $t3, $t3, $t3 # shift left logical variable ($t3 <<= $t3)
    srlv $t4, $t4, $t4 # shift right logical variable ($t4 >>= $t4)
    srav $t5, $t5, $t5 # shift right arithmetic variable ($t5 >>= $t5)

    jr $ra