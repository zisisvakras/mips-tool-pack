.data
    msg_goodbye:  .asciz "Goodbye!\n"
    msg_wrong:    .asciz "Wrong character!\n"
    msg_prompt_a: .asciz "Give two integers\n"
    msg_prompt_b: .asciz "Give a string\n"
    
    # 10 characters plus null terminator
    buffer:       .space 11

.text
.globl _entry

_entry:
read_loop:
    # getChar()
    li a7, 12
    ecall
    mv s0, a0           # save the input character to s0

    # printChar('\n') to declutter the output
    li a7, 11
    li a0, 10
    ecall

    # if-else to determine the input
    li t0, 'X'
    beq s0, t0, read_loop.handle_X

    li t0, 'A'
    beq s0, t0, read_loop.handle_A

    li t0, 'B'
    beq s0, t0, read_loop.handle_B

    # writeString("Wrong character!\n")
    la a0, msg_wrong
    li a7, 4
    ecall
    
    j read_loop

    read_loop.handle_A:
        # writeString("Give two integers\n")
        la a0, msg_prompt_a
        li a7, 4
        ecall
    
        # readInt()
        li a7, 5
        ecall
        # save the input number to s1
        mv s1, a0
    
        # readInt()
        li a7, 5
        ecall
    
        # setup input registers and call the function
        # (a0 already has the 2nd int, move the 1st int to a1)
        mv a1, s1
        jal calc_hypotenuse
        
        j read_loop
    
    read_loop.handle_B:
        # writeString("Give a string\n")
        la a0, msg_prompt_b
        li a7, 4
        ecall
    
        # readString(buffer, 11) -> reads up to 10 chars + \0
        la a0, buffer
        li a1, 11
        li a7, 8
        ecall
    
        # count_chars(buffer)
        jal count_chars
    
        # printInt(a0) - prints the returned count
        li a7, 1
        ecall
    
        # writeChar('\n')
        li a7, 11
        li a0, 10
        ecall
    
        j read_loop
    
    read_loop.handle_X:
        # writeString("Goodbye!\n")
        la a0, msg_goodbye
        li a7, 4
        ecall
    
        # exit()
        li a7, 10
        ecall


# calc_hypotenuse(n1: a0, n2: a1) -> void
calc_hypotenuse:
    fcvt.s.w ft0, a0  # ft0 = float(a0)
    fcvt.s.w ft1, a1  # ft1 = float(a1)

    fmul.s ft0, ft0, ft0  # ft0 = ft0 * ft0  (n1^2)
    fmul.s ft1, ft1, ft1  # ft1 = ft1 * ft1  (n2^2)

    # ft0 = ft0 + ft1  (n1^2 + n2^2)
    fadd.s ft0, ft0, ft1

    # fa0 = sqrt(ft0)
    fsqrt.s fa0, ft0

    # printFloat(fa0)
    li a7, 2
    ecall

    # printChar('\n')
    li a7, 11
    li a0, 10
    ecall

    ret

# count_chars(str: a0) -> count: a0
count_chars:
    mv t0, a0           # save the input
    
    # if the string is empty nothing has to be done
    # lbu is used instead of lb to avoid sign extension
    lbu t1, 0(t0)
    beqz t1, count_chars.empty

    mv t1, t0           # start of the string
    count_chars.find_last:
        lbu t2, 0(t0)
        # if t2 is a null byte then t1 is a pointer
        # to the last valid char
        beqz t2, count_chars.found_last
        # rars inserts the newline in the buffer
        li t5, 10
        beq t2, t5, count_chars.found_last
        
        mv t1, t0           # update pointer to the last char
        addi t0, t0, 1
        j count_chars.find_last
    
    count_chars.found_last:
        lbu t4, 0(t1)       # t4 = the actual last character
    
        # count how many t4s we can find inside the string
        mv t0, a0           # reset pointer to the start of the string
        li t5, 0            # t5 = counter
    
    count_chars.count_loop:
        lbu t2, 0(t0)
        # finished
        beqz t2, count_chars.done
        
        bne t2, t4, count_chars.skip_inc
        addi t5, t5, 1      # increment counter if char matches t4
        
    count_chars.skip_inc:
        addi t0, t0, 1      # move to next char
        j count_chars.count_loop
    
    count_chars.empty:
        li t5, 0
    
    count_chars.done:
        mv a0, t5           # set return value to count
        ret


# this exam had a lot of varients. One of the varients under option b
# was count how many lower case letters the input string have
# count_lower_case(str: a0) -> count: a0
count_lower_case:
    li t0, 0  # counter

    count_lower_case.loop:
        lbu t1, 0(a0)
        beqz t1, count_lower_case.done
        # in this case we will rely on integer underflow
        # to check the range
        # (unsigned)(char - 'a') < 26
        addi t1, t1, -97
        sltiu t1, t1, 26  # t1 = (unsigned)(char - 'a') < 26
        add t0, t0, t1

        addi a0, a0, 1
        j count_lower_case.loop
        
    count_lower_case.done:
        mv a0, t0
        ret
