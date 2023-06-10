.data
    num1: .word 0x00000002
    num2: .word 0xFFFFFFFF
    nothing1: .word 69 # better visual allignment in QTspim
    nothing2: .word 69
    result1_hi: .word 2
    result1_lo: .word 1
    result2_hi: .word 4
    result2_lo: .word 3

.text
.globl main
    main:
        la $t0, num1
        lw $t1, 0($t0)
        la $t2, num2
        lw $t3, 0($t2)

        mult $t1, $t3 # This extends the sign in the high bits. Low bits are same
        mflo $t4
        sw $t4, result1_lo
        mfhi $t4
        sw $t4, result1_hi

        multu $t1, $t3
        mflo $t5
        sw $t5, result2_lo
        mfhi $t5
        sw $t5, result2_hi

        li $v0, 10
        syscall