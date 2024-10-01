.text
li $s0, 0x12345678		#khoi tao $s0
andi $s1,$s0,0xff000000	
sra $s2,$s1,24		#Extract MSB of $s0
andi $s3,$s0,0xffffff00		#Clear LSB of $s0		
andi $s4,$s0,0x000000ff		#Set LSB of $s0	
xor $s5,$s0,$s0			#Clear $s0