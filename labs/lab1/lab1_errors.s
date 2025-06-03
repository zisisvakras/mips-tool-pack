    .text
    .globl __start
__start:
    la  t2, str          # t2 points to the string
    li  t1, 0            # t7 holds the count
nextCh: 
    lb t0, 0(t2)        # get a byte from string
    beqz t0, strEnd     # zero means end of string
    addi t1, t1, 1      # increment count
    addi t2, t2, 1       # move pointer one character
    j nextCh            # go round the loop again
strEnd:
    la a0, ans          # system call to print out
    li a7, 4            # a message
    ecall
    mv a0, t2           # system call to print out 
    li a7, 1            # the length
    ecall
    la a0, endl         # system call to print out
    li a7, 4            # end of line
    ecall
    li a7, 10           # au revoir ...
    ecall


    .data
str:    .asciz "hello world"
ans:    .asciz "Length is "
endl:   .asciz "\n"
