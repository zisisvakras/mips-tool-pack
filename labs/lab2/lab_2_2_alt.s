# Little Endian to Big Endian (on a word)

# Result is stored in s1
# bytes (in comments) are numbered according to exercise 

.data
    word: .word 0x12345678

.text
    .globl main

main:

    # you could delete these 2 instructions and data segment
    # and insert word to s0 manually from qtspim window
    la $t0, word
    lw $s0, 0($t0)  # load word from memory to register s0
    
    # byte 0
    srl $s1, $s0, 24        # only byte 0 remains, rest is 0

    #byte 3
    sll $t1, $s0, 24        # only byte 3 remains, rest is 0

    # we build the new word by combining the bytes we seperated
    or $s1, $s1, $t1 

    # byte 1
    srl $t1, $s0, 8
    andi $t1, $t1, 0xff00   # mask to only keep byte 1 reamains rest are 0

    or $s1, $s1, $t1        # combine it to bytes 0 and 3

    # byte 2
    andi $t1, $s0, 0xff00   # mask to only keep byte 2 
    sll $t1, $t1, 8
# cant shift first and then mask like byte 1
# since andi can only take 16 bit values
# its possbile though with an additional instruction (li 0xff0000 and...)

    or $s1, $s1, $t1        # combine the final byte with the rest

    li $v0, 10  # exit
    syscall
