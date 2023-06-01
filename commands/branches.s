BranchFunctions:
    beq  $s0, $s1, l1   # branch on equal
    bne  $s0, $s1, l1   # branch on not-equal
    bgt  $s0, $s1, l1   # branch on bigger (s0 > s1)
    blt  $s0, $s1, l1   # branch on smaller (s0 < s1)
    beqz $s0, l1        # branch on equal to zero
    bnez $s0, l1        # branch on not-equal to zero
    bgtz $s0, l1        # branch on bigger than zero
    bltz $s0, l1        # branch on smaller than zero
    bc1t l1             # branch on code cc true
    bc1f l1             # branch on code cc false
    l1: jr $ra          # this is added to make this a valid program