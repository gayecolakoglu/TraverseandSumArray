.data
values: .double 1.0,1.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0
dbl: .double 150.0
size: .word 14
ln: .asciiz "\n"

.text
la $s0 values # load adress of values array
l.d $f0 dbl # load double 150.0

WHILE:
l.d $f2 0($s0) #values[i]
addi $s0 $s0 8 #move pointer to the next element
l.d $f4 0($s0) #values[i+1]
c.lt.d $f4 $f0 # is f4<f0 
bc1t CONTINUE  # if above statement is true then jump CONTINUE
#else
j ELSE

CONTINUE:
add.d $f6 $f4 $f2 # f6= value[i]+value[i+1]
addi $s0 $s0 8    # move pointer to the next element
s.d $f6 0($s0)    # value[i+2] = f6 
addi $s0 $s0 -8   # move pointer to the previous element
j WHILE

ELSE:
la $t0 values    # load adress of values array

addi $s1 $zero 0 # i=> s1 = 0
lw $s4 size      # s4 = size

FOR:
bne $s1 $s4 PRINT # if s1 != s4 then jump PRINT
li $v0, 10 # terminate program
syscall

PRINT:
l.d $f2 0($t0)
li $v0 3
mov.d $f12 $f2
syscall
li $v0, 4 # system call code for printing string = 4
la $a0, ln
syscall
addi $t0 $t0 8
addi $s1 $s1 1
j FOR





