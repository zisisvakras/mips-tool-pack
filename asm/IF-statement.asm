#----------   C code ------------
#  if (i == j)
#      f = g + h;
#
#  f = f – i;
# MIPS Assembly 
# $s0 = f, $s1 = g, $s2 = h
# $s3 = i, $s4 = j

# init registers to compare  
	li  $s3, 10
	li  $s4, 11

# ---------- IF statement implementation BEGIN  -------------
	bne $s3, $s4, L1
	add $s0, $s1, $s2
L1: sub $s0, $s0, $s3
# ---------- IF statement implementation END  -------------

	li	$v0, 10		# system call code for exit = 10
	syscall
