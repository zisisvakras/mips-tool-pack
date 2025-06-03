.text
.globl __start

__start:
    li s0, -2147483647
    li s1, -2
    
    mv a0, s0
    jal PrintInt
    mv a0, s1
    jal PrintInt

    mv a0, s0
    mv a1, s1
    jal add
    
    mv s0, a1
    jal PrintInt

    bnez s0, case_overflow
    j Exit
    
  case_overflow:
    la a0, OVERFLOW_MSG
    jal PrintString
    j Exit

#####################################

# fn add(i32 a, i32 b) -> (i32, bool)
#
# Signed 32-bit addition with overflow detection.
# Returns the sum `a + b` in `a0` and 1 in `a1` if
# arithmetic overflow occurred.

add:
    add t0, a0, a1

    srli a0, a0, 31
    srli a1, a1, 31
    srli t1, t0, 31
    
    # If both operands have different signs,
    # there is no possibility of overflow.
    bne a0, a1, .add_no_overflow
    
  .add_possible_overflow:
    # If the result has the same sign as
    # the operands, then no overflow occurred.
    beq a0, t1, .add_no_overflow
    
  .add_overflow:
    mv a0, t0
    li a1, 1
    j .add_done

  .add_no_overflow:
    mv a0, t0
    xor a1, a1, a1
    
  .add_done:
    jr ra

#####################################

PrintInt:
    li a7, 1
    ecall
    la a0, NL
    li a7, 4
    ecall

PrintString:
    li a7, 4
    ecall
    jr ra

Exit:
    li a7, 10
    ecall

.data
NL: .asciz "\n"
OVERFLOW_MSG: .asciz "overflow occurred!\n"
