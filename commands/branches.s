BranchFunctions:
    beq  $s0, $s1, l1   # branch on equal (s0 == s1)
    bne  $s0, $s1, l1   # branch on not-equal (s0 != s1)
    bgt  $s0, $s1, l1   # branch on bigger (s0 > s1)
    blt  $s0, $s1, l1   # branch on smaller (s0 < s1)
    ble $s0, $s1, l1    # branch on smaller or equal (s0 <= s1)
    bge $s0, $s1, l1    # branch on bigger or equal (s0 >= s1)
    beqz $s0, l1        # branch on equal to zero (s0 == 0)
    bnez $s0, l1        # branch on not-equal to zero (s0 != 0)
    bgtz $s0, l1        # branch on bigger than zero (s0 > 0)
    bltz $s0, l1        # branch on smaller than zero (s0 < 0)
    bc1t l1             # branch on code cc true 
    bc1f l1             # branch on code cc false
    l1: jr $ra          # this is added to make this a valid program