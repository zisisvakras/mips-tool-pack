    .text
    .globl __start

__start:
    la t0, num1
    lw t1, 0(t0)            # Load num1 into t1
    lw t2, 4(t0)            # Load num2 into t2
    fmv.w.x ft1, t1         # Move IEEE 754 representation of num1 to ft1
    fmv.w.x ft2, t2         # Move IEEE 754 representation of num2 to ft2
    
    # flt.s   t3, ft1, ft2    # if (ft1 < ft2) ? t3=1 : t3=0
    jal flt

    mv a0, t3
    jal PrintInt
    li a7, 10
    ecall

# Using integer comparison to compare IEEE 754 single precision floats.
# https://stackoverflow.com/a/46995665
flt:
    addi sp, sp, -8
    sw ra, 4(sp)
    fsw ft1, 0(sp)

    jal fcmpi
    mv t0, a0
    
    fmv.s ft1, ft2
    jal fcmpi
    mv t1, a0

    bgt t0, t1, .flt_lt

    xor t3, t3, t3
  .flt_done:
    flw ft1, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8
    jr ra

  .flt_lt:
    addi t3, t3, 1
    j .flt_done
    
fcmpi:
    fmv.x.w t6, ft1
    
    li t4, 1
    slli t4, t5, 31
    and t5, t6, t4
    bnez t5, .fcmpi_neg
    
  .fcmpi_pos:
    li t5, 0xFF800000
    sub a0, t5, t6
    j .fcmpi_done
    
  .fcmpi_neg:
    addi t4, t4, -1
    add a0, t6, t4

  .fcmpi_done:
    jr ra
    

PrintInt:
    li a7, 1
    ecall
    jr ra

    .data
num1:   .word 0x6f800000
num2:   .word 0x4f800200
