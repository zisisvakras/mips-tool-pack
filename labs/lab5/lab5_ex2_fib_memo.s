    .text
    .globl __start
__start:
    li s0, 40                       # number of terms to compute
    li s1, 2                        # index of current term
    li s2, 1                        # const value 1
    la s3, fib_results
    sw zero, 0(s3)                  # store fib(0) in fib_results[0]
    sw s2, 4(s3)                    # store fib(1) in fib_results[1]
main_loop:
    mv a0, s1                       # compute fib(s1)
    jal fib_memo
    addi s1, s1, 1                  # increment index
    bne s0, s1, main_loop           # loop until all terms are computed

exit:
    li a7, 10
    ecall

################################################################################

# int fib_memo(int n)
fib_memo:
    # Have we memoized the value for this `n` yet?
    lw t0, _fib_memo_internal_index
    la t1, _fib_memo_internal_storage

    blt a0, t0, fib_memo_memoized
    beq a0, t0, fib_memo_can_compute

  fib_memo_not_memoized:
    addi sp, sp, -12
    sw ra, 8(sp) # return address
    sw a0, 4(sp) # n
    #      0(sp) # fib(n-1)
    
    # Compute fib(n-1)
    addi a0, a0, -1
    jal fib_memo
    sw a0, 0(sp)
    
    # Compute fib(n-2)
    lw a0, 4(sp)
    addi a0, a0, -2
    jal fib_memo
    
    # Compute fib(n-1) + fib(n-2)
    lw t3, 0(sp)
    add t3, t3, a0
    
    # Memoize the result.
    lw t0, _fib_memo_internal_index
    la t1, _fib_memo_internal_storage
    
    # Write value to storage.
    li t5, 4
    mul t5, t5, t0
    add t5, t5, t1
    sw t3, (t5)
    
    # Increment index.
    addi t0, t0, 1
    la t1, _fib_memo_internal_index
    sw t0, (t1)
    
    mv a0, t3
    jr ra

  fib_memo_memoized:
    # Load value from storage.
    li t5, 4
    mul t5, t5, a0
    add t5, t5, t1
    lw a0, (t5)
    jr ra
    
  fib_memo_can_compute:
    # Compute from memoized values.
    li t5, 4
    mul t5, t5, t0
    add t5, t5, t1

    # Load memoized values for `n-1` and `n-2`.
    lw t3, -4(t5)
    lw t4, -8(t5)

    # Compute and memoize the result.
    add a0, t3, t4
    sw a0, 0(t5)

    addi t0, t0, 1
    la t5, _fib_memo_internal_index
    sw t0, (t5)

    jr ra
    

.data
_fib_memo_internal_index:   .word 2
_fib_memo_internal_storage: .word 0, 1
                            .space 152

.text
################################################################################


    .data
fib_results:   .space 160           # space for first 40 terms of fib sequence    

    
