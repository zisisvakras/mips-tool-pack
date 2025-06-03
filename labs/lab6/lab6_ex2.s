.text
.globl __start

__start:
    la a0, A
    la a1, B
    la a2, C
    jal add64
    j Exit
    
#####################################

# fn add64(i64* a, i64* b, i64* result) -> bool
#
# Signed 64-bit addition with overflow detection.
# Writes the sum `a + b` at `result` returns 1
# in `a0` if arithmetic overflow occurred.

add64:
  mv s0, a0
  mv s1, a1
  
  # result[0:31] := a[0:31] + b[0:31]
  lw a0, 0(s0)
  lw a1, 0(s1)
  add t0, a0, a1
  sw t0, 0(a2)
  
  # Detect overflow in the lower 32 bits. (t3)
  srli a0, a0, 31
  srli a1, a1, 31
  srli t0, t0, 31
  xor t1, a0, a1
  not t1, t1
  xor t2, a0, t0
  and t3, t1, t2
  
  # t0 := a[32:63] + b[32:63]
  lw a0, 4(s0)
  lw a1, 4(s1)
  add t0, a0, a1

  # Add the carry from the lower 32 bits.
  add t0, t0, t3
  
  # result[32:63] := t0
  sw t0, 4(a2)
  
  # Detect overflow in the 64-bit operation.
  srli a0, a0, 31
  srli a1, a1, 31
  srli t0, t0, 31
  xor t1, a0, a1
  not t1, t1
  xor t2, a0, t0
  and a0, t1, t2

  jr ra
  
#####################################

Exit:
    li a7, 10
    ecall

.data
A: .word 14, 0
B: .word 11, 0
C: .word 0x00000000, 0x00000000