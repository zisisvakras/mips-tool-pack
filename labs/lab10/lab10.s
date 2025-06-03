.text
.globl _start

_start:
    la s0, array
    li s1, 6

    mv a0, s0
    mv a1, s1
    jal PrintArray

    mv a0, s0
    mv a1, s1
    jal bubblesort
            
    mv a0, s0
    mv a1, s1
    jal PrintArray

    jal Exit

# bubblesort(int32* array, uint32 len)
bubblesort:
    xor t0, t0, t0
  .bubblesort_loop_outer:
    beq t0, a1, .bubblesort_loop_outer_done
    
    xor t1, t1, t1
    addi t2, a1, -1
    sub t2, t2, t0
    mv t3, a0
  .bubblesort_loop_inner:
    beq t1, t2, .bubblesort_loop_inner_done
    
    lw t5, 0(t3)
    lw t6, 4(t3)
    
    # The "swap" path is relatively uncommon compared to
    # the "no swap" path. We will help the branch predictor
    # initially by putting the least common path out of the
    # way.
    bgt t5, t6, .bubblesort_swap

  .bubblesort_loop_inner_next:
    addi t1, t1, 1
    addi t3, t3, 4
    j .bubblesort_loop_inner

  
  .bubblesort_loop_inner_done:
    addi t0, t0, 1
    j .bubblesort_loop_outer
  
  .bubblesort_loop_outer_done:
    jr ra
    
  .bubblesort_swap:
    sw t6, 0(t3)
    sw t5, 4(t3)
    j .bubblesort_loop_inner_next

# PrintArray(int32* array, uint32 len)
PrintArray:
    addi sp, sp, -12
    sw ra, 8(sp)
    sw s1, 4(sp)
    sw s0, 0(sp)

    mv s0, a0
    mv s1, a1

    la a0, BOPEN
    jal PrintString

  .PrintArray_print_next_elem:
    beqz s1, .PrintArray_done

    lw a0, 0(s0)
    jal PrintInt

    la a0, SEP
    jal PrintString

    addi s0, s0, 4
    addi s1, s1, -1
    j .PrintArray_print_next_elem

  .PrintArray_done:
    la a0, BCLSE
    jal PrintString

    lw s0, 0(sp)
    lw s1, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12
    jr ra

PrintInt:
    li a7, 1
    ecall
    jr ra

PrintString:
    li a7, 4
    ecall
    jr ra

Exit:
    li a7, 10
    ecall

.data

array: .word 0, 4, 6, 1, 2, 3

BOPEN: .asciz "[ "
BCLSE: .asciz "]\n"
SEP: .asciz " "
