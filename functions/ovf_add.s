# $a0 + $a1 = $v0
# OVF_flag = $v1
ovf_add:
    addu $v0, $a1, $a0 # sum
    xor  $v1, $v0, $a0 # w0 ^ sum
    xor  $v0, $v0, $a1 # w1 ^ sum
    # calculate ovf in $v1
    and  $v1, $v1, $v0
    addu $v0, $a1, $a0 # redo sum
    jr $ra
