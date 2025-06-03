    .text
    .globl __start
__start:
    la a0, input_str
    li a1, 21               # maximum input length + 1
    jal read_str
    li a1, ' '              # delimiter
    la a2, A
    li s0, 0
    li s1, 20               # maximum input length
    mv s2, a0
    li s3, -1               # the smaller index - 1
    
    # BUG: This whole split implementation relies on `find` not modifying the `a0`, `a1`, `a2` registers.
    #      The calling convention makes no guarantees about preservation of the 8 function argument
    #      registers across function calls. It specifies that it is the responsibility of the caller
    #      to save them across function calls. This means a function is able to modify them internally
    #      however it wants without saving them on the stack itself. I have modified the code a bit
    #      to fix this. Diff with the original to see the changes I've made.
    #
    #      Calling convention: <https://github.com/TheThirdOne/rars/wiki/Calling-Convention#register-names>

    # We use `s10` and `s11` to preserve the values of `a0` and `a2` across the call to `find`.
    # (but not `a1` because that is returned by `find`)
    #
    # We could also push them on the stack, but this is faster since we are not using `s10` or `s11` anywhere else.
    mv s10, a0
    mv s11, a2
    jal find
    mv a2, s11
    mv a0, s10

    jal print_endl
    beqz a1, split_end      # just print the string if no delimiter found

split:
    bgt s0, s1, split_end   # characters count
    lw s4, 0(a2)
    blt s4, s3, split_end   # end loop if current index is smaller than the last one
    mv s3, s4               # store the last index
    add s5, s4, s2          # string address + index
    sb zero, 0(s5)
    jal print_str           # a0 contains the address of a portion of a string
    jal print_endl
    addi a0, s5, 1          # (string address + index) + 1
    addi a2, a2, 4
    addi s0, s0, 1
    j split

split_end:
    jal print_str
    jal print_endl
    j exit 
    
##############################

# size_t find(const char* str1, char ch, size_t* A)
find:
    addi sp, sp, -12
    sw s2, 8(sp)
    sw s1, 4(sp)
    sw s0, 0(sp)

    xor s0, s0, s0   # match count
    xor s1, s1, s1   # index in `str1`
  find_loop_next:
    add s2, a0, s1
    lbu s2, (s2)
    beqz s2, find_loop_done # stop on null byte
    bne s2, a1, find_loop_no_match
    
    # Write match index to the next slot in A.
    sw s1, (a2)
    addi a2, a2, 4
    addi s0, s0, 1
    
  find_loop_no_match:
    addi s1, s1, 1
    j find_loop_next
  
  find_loop_done:
    # Set `a1` to 0 only if there are no matches, otherwise it is left unmodified. Weird convention but ok.
    bnez s1, find_return
    xor a1, a1, a1

  find_return:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 12
    jr ra

##############################

read_str:
    li a7, 8
    ecall
    jr ra


print_str:
    li a7, 4
    ecall
    jr ra

print_endl:
    addi sp, sp, -8
    sw a0, 4(sp)
    sw ra, 0(sp)

    la a0, endl
    jal print_str

    lw ra, 0(sp)
    lw a0, 4(sp)
    addi sp, sp, 8
    jr ra    

exit:
    li a7, 10
    ecall    


    .data
input_str:      .space 21
A:              .word  0, 0, 0, 0, 0
                .word  0, 0, 0, 0, 0
                .word  0, 0, 0, 0, 0
                .word  0, 0, 0, 0, 0
                .word  0, 0, 0, 0, 0
endl:           .asciz "\n"
