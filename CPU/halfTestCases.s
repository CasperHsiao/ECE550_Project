nop

addi $1, $0, 65535      	# r1 = 65535 = 0x0000FFFF
bex 4				# should not jump
sll $2, $1, 15			# r2 = r1 << 15 = 0x7FFF8000 = 2147450880(decimal)
add $3, $2, $2			# r3 = r2 + r2 (Tests overflow add)
bex 7				# jump to nop
nop
nop
addi $3, $2, 65535		# r3 = r2 + 65535 (Tests overflow addi)
addi $4, $0, 1			# r4 = 1
add $6, $1, $4			# r6 = 65535 + 1 = 65536  (normal addition) (then how about overflow addition?)
sll $7, $4, 31			# r7 = r4 << 31 = 0x80000000(hex) = -2147483648(decimal)
sub $9, $7, $6			# r9 = r7 - r6 (Tests overflow sub)
setx 0
bex 2				# should not jump
and $10, $1, $2			# r10 = r1 & r2 = 0x0000FFFF & 0x7FFF8000 = 0x00008000(hex) = 32768(decimal)
or $12, $1, $2			# r12 = r1 | r2 = 0x0000FFFF | 0x7FFF8000 = 0x7FFFFFFF(hex) = 2147483647(decimal)

j 20			# jump to add (insn 20)
nop
nop
nop
addi $20, $0, 2         # r20 = 2
add $21, $4, $20        # r21 = 3
sub $22, $20, $4        # r22 = 1
bne $21, $22, 3		# branch to or 
nop
nop		
and $23, $22, $21       # r23 = 1 & 3 = 1
or $24, $20, $23        # r24 = 2 | 1 = 3
jal 32			# jump to addi (insn 32)
sll $25, $23, 1          # r25 = 1 << 1 = 2
sra $26, $25, 1          # r26 = 2 >> 1 = 1 

addi $20, $0, 2         # r20 = 2
and $23, $22, $21       # r23 = 1 & 3 = 1
addi $27, $0, 36	# r27 = 36
jr $27			# jr (insn 36)

nop
addi $20, $0, 2         # r20 = 2
blt $20, $21, 2
nop
nop
add $21, $4, $20

 
