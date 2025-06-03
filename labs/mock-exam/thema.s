.text
.globl __start

__start:
	jal read_numbers
	
	la a0, NUMBERS
	li a1, 20
	jal sum

	jal PrintIntUnsigned
	jal Exit

# void read_numbers()
#
# Reads 20 numbers into the `NUMBERS` array.
read_numbers:
	mv t6, ra
	la t0, NUMBERS
	li t1, 20
	
	.read_numbers_read_next:
	beqz t1, .read_numbers_read_done

	jal ReadInt
	ble a0, x0, .read_numbers_read_done
	sw a0, (t0)

	addi t0, t0, 4
	addi t1, t1, -1
	j .read_numbers_read_next
	.read_numbers_read_done:
	
	.read_numbers_zeroing_next:
	beqz t1, .read_numbers_zeroing_done

	sw x0, (t0)

	addi t0, t0, 4
	addi t1, t1, -1
	j .read_numbers_zeroing_next
	.read_numbers_zeroing_done:
	
	mv ra, t6
	jr ra

# int32 sum(int32* array, int32 len)
#
# Caclulate the sum of all `int32` in `array`.
sum:
	xor t0, t0, t0
	
	.sum_next:
	beqz a1, .sum_done

	lw t1, (a0)
	add t0, t0, t1
	
	addi a0, a0, 4
	addi a1, a1, -1
	j .sum_next
	.sum_done:
	
	mv a0, t0
	jr ra

PrintIntUnsigned:
	li a7, 36
	ecall
	jr ra

ReadInt:
	li a7, 5
	ecall
	jr ra

Exit:
	li a7, 10
	ecall

.data
NUMBERS: .space 80 # 4 * 20