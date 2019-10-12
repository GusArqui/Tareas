#Gustavo Alejandro Sánchez Arvizu ie716000
#Guillermo Alexis García Ramirez  ie715902
.data 

.text
addi $s0, $zero, 8		#N number of discs

add $s1, $zero, 0x1001	 	#s1 will be the source tower (org)
sll $s1, $s1, 16 		#Shift 1001 to the left 16 times 
addi $s2, $s1, 0x20 		#s2 will be the auxiliary tower and it'll be placed on the address 10010020 (aux)
addi $s3, $s2, 0x20 		#s3 will be the destination tower and it'll be placed on the address 10010020 (dest)

add $t5, $s0, $zero		#temporary variable to save n

for: # starts org tower
	sw $t5, 0($s1)			#Put disc in org
	addi $s1, $s1, 4		#increase position of org
	addi $t5, $t5, -1		#Decrease temporary variable
	bne $t5, $zero, for		#check if all the numbers are in the tower 
	
	add $s1, $zero, 0x1001	 	#return s1 to its original address 
	sll $s1, $s1, 16 		#shift to get the high part
	
	jal hanoi			#call hanoi
	j exit				#end of program

hanoi:
	addi $sp,$sp,-20		#Make space in the stack for 5 words
	sw $ra,0($sp)			#store return address in stack
	sw $s1,4($sp)			#store org in stack
	sw $s2,8($sp)			#store aux in stack
	sw $s3,12($sp)			#store dest in stack
	sw $s0,16($sp)			#store n in stack
	bne $s0, 1, casoGeneral		#while n!=1 it'll jump to casoGeneral
	lw $t0, ($s1)			#loads disc 
	sw $t0, 0($s3)			#store disc in dest
	sw $zero, ($s1)			#clear disc in org
	j finHanoi			#jump to finHanoi

casoGeneral:
	addi $s0, $s0, -1	#n-1
	addi $s1,$s1,4		#move org to next position
	lw $s2,12($sp)		#load aux with dest 
	lw $s3,8($sp) 		#load dest with aux
	jal  hanoi		#call hanoi
	lw $s1,4($sp)		#load org address
	lw $s3,12($sp)		#load dest address
	lw $t2,0($s1)		#load disc in org
	sw $t2,0($s3) 		#store disc in dest
	sw $zero, ($s1)		#clear disc in org
	addi $s3,$s3,4		#move dest to next position
	lw $s2,4($sp)		#load aux with org address
	lw $s1,8($sp)		#load org with aux address
	jal hanoi		#call hanoi
	
finHanoi:
	lw $ra,0($sp)		#Load return address
	lw $s1,4($sp)		#Load org
	lw $s2,8($sp)		#Load aux
	lw $s3,12($sp)		#Load dest
	lw $s0,16($sp)		#Load n
	addi $sp,$sp,20		#return sp to its address before hanoi
	jr $ra			#jump to return address
	
exit:
