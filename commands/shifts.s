AllShiftFunctions:
    sll $t0, $t0, 1 # shift left logical ($t0 <<= 1)
    sra $t1, $t1, 1 # shift right arithmetic ($t1 >>= 1)
    srl $t2, $t2, 1 # shift right logical ($t2 >>= 1) (this treats t2 as unsigned)
    jr $ra