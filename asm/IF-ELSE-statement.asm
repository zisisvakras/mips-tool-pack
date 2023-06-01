#----------   C code ------------
#	if (i == j)	
#		f = g + h;
#	else
#		f = f – i;

#	$s0 = f, $s1 = g, $s2 = h
#   $s3 = i, $s4 = j

# init registers to compare  
	li  $s3, 10
	li  $s4, 10

# ---------- IF ELSE statement implementation BEGIN  -------------
		bne $s3, $s4, L1
		add $s0, $s1, $s2
		j done
L1:     sub $s0, $s0, $s3
done:   add $t1, $t0, $0
# ---------- IF ELSE statement implementation END  -------------

		li	$v0, 10		# system call code for exit = 10
		syscall