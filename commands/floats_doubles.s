test:
li $t0, 5
li.s $f1, 0.5

## SINGLE PERCISION ###

# Assign a constant value to $f0

## Registers 

# Move int into float
mtc1 $t0, $f0 # Moves the value of $t0 into $f0  # NOTE: here destination is second
cvt.s.w $f0, $f0 # Converts the value of $f0 into a single precision value

# Move float into int
cvt.w.s $f0, $f0 # Converts the value of $f0 into a word
mfc1 $t0, $f0 # Moves the value of $f0 into $t0 # NOTE: here destination is first 

# Load Immediate
li.s $f0, 0.5 # Loads the value 0.5 into $f0

# Load Address
la $t0, pi_float # Loads the address of pi_float into $t0
l.s $f0, 0($t0) # Loads the value at the address stored in $t0 into $f0

# Store
s.s $f0, 0($t0) # Stores the value of $f0 into the address stored in $t0


## Arithmetic

# Add
add.s $f0, $f0, $f1 # Adds the value of $f0 and $f1 and stores it in $f0 
# Subtract
sub.s $f0, $f0, $f1 # Subtracts the value of $f1 from $f0 and stores it in $f0
# Multiply
mul.s $f0, $f0, $f1 # Multiplies the value of $f0 and $f1 and stores it in $f0
# Divide
div.s $f0, $f0, $f1 # Divides the value of $f0 by $f1 and stores it in $f0
# Square Root
sqrt.s $f0, $f0 # Stores the square root of $f0 in $f0

# Compare
c.eq.s $f0, $f1 # Compares the value of $f0 and $f1 and sets the flag if they are equal
c.lt.s $f0, $f1 # Compares the value of $f0 and $f1 and sets the flag if $f0 is less than $f1
c.le.s $f0, $f1 # Compares the value of $f0 and $f1 and sets the flag if $f0 is less than or equal to $f1

# Branch
bc1t label1 # Branches to label if the flag is set (true)
label1:
bc1f label2 # Branches to label if the flag is not set (false)
label2:




### DOUBLE PERCISION ###
li.d $f0, 0.5
li.d $f2, 0.24
# Move int into double
mtc1 $t0, $f0 # Moves the value of $t0 into $f0  # NOTE: here destination is second
cvt.d.w $f0, $f0 # Converts the value of $f0 into a double precision value

# Move double into int
cvt.w.d $f0, $f0 # Converts the value of $f0 into a word
mfc1 $t0, $f0 # Moves the value of $f0 into $t0 # NOTE: here destination is first

# Load Immediate
li.d $f0, 0.5 # Loads the value 0.5 into $f0

# Load Address
la $t0, pi_double # Loads the address of pi_double into $t0
l.d $f0, 0($t0) # Loads the value at the address stored in $t0 into $f0

# Store
s.d $f0, 0($t0) # Stores the value of $f0 into the address stored in $t0

## Arithmetic

# Add
add.d $f0, $f0, $f2 # Adds the value of $f0 and $f1 and stores it in $f0
# Subtract
sub.d $f0, $f0, $f2 # Subtracts the value of $f1 from $f0 and stores it in $f0
# Multiply
mul.d $f0, $f0, $f2 # Multiplies the value of $f0 and $f1 and stores it in $f0
# Divide
div.d $f0, $f0, $f2 # Divides the value of $f0 by $f1 and stores it in $f0
# Square Root
sqrt.d $f0, $f0 # Stores the square root of $f0 in $f0

# Compare
c.eq.d $f0, $f2 # Compares the value of $f0 and $f1 and sets the flag if they are equal (use bc1t label for branch)
c.lt.d $f0, $f2 # Compares the value of $f0 and $f1 and sets the flag if $f0 is less than $f1 (use bc1t label for branch) 
c.le.d $f0, $f2 # Compares the value of $f0 and $f1 and sets the flag if $f0 is less than or equal to $f1 (use bc1t label for branch)

# Branch (same with single precision)
bc1t label3 # Branches to label if the flag is set (true)
label3:
bc1f label4 # Branches to label if the flag is not set (false)
label4:

## REGISTERS

# $f0 - $f31
# $f0/1 - $f30/31 (double precision - use them in pairs)

## CONSTANTS

# minimum_positive_single_precision_float = 2^-126 = 1.17549435e-38
# maximum_single_precision_float = 2^128 * (2 - 2^-24) = 3.40282347e+38

# minimum_positive_double_precision_float = 2^-1022 = 2.2250738585072014e-308
# maximum_double_precision_float = 2^1024 * (2 - 2^-53) = 1.7976931348623157e+308


li $v0, 10
syscall
.data

    pi_float: .float 3.14159
    pi_double: .double 3.14159265359
    e_const: .float 2.71828
    e_double: .double 2.71828182845904

