# transform 32bit value into its code gray value

# insert value at s0 before running the program
# answer is stored at s1

.text

.globl main

main:
srl $t0, $s0, 1     # shift right to prepare for xor, logical shift 
                    # to make most significant bit of t0 0 so that
                    # after xor most significant bit of s1 is equal
                    # to most significant bit of s0
xor $s1, $s0, $t0


li $v0, 10          # exit
syscall
