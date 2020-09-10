#project

                .data
ap:        .word       1	                #Exit(or making another operation) control variable.
st_result: .word       0			#previous operation result.
name:      .asciiz     "null"	                #previous Operation name . 
result:    .word       0 			#Current operation result.
R:         .word       0			#(Using last operation result as input) control variable.   
                 #Outline strings .
Welcome:      .asciiz       "Welcome to basic calculator.\n\n\n"
string1:      .asciiz       "Please enter the number of the operation you desire:\n1-Addition\n2-Subtraction\n3-Multiplication\n4-Division\n5-Power\n6-Factorization\n7-Maximum\n8-Minimum\n9-Show previous operations\n"
string2:      .asciiz       "Please enter a valid number (between 1 and 9)\n"
string3:      .asciiz       "Please enter input value\n"
string4:      .asciiz       "please enter a number greater than zero...\n"
string5:      .asciiz       "Please enter the input values\n"
string6:      .asciiz       "please enter a divisible number (Not zero)\n"
string7:      .asciiz       "the last operation is :\n"
string8:      .asciiz       "the last result is :\n"
string9:      .asciiz       "Please enter the number of input values (Then enter the values)\n"
val_name1:    .asciiz       "addition\n"
val_name2:    .asciiz       "subtract\n"
val_name3:    .asciiz	    "multiply\n"
val_name4:    .asciiz       "division\n"
val_name5:    .asciiz       "power\n"
val_name6:    .asciiz       "factorial\n"
val_name7:    .asciiz       "maximum\n"
val_name8:    .asciiz       "minimum\n"
string10:     .asciiz       "The result is :\n"
string11:     .asciiz       "\nEnter 0 to exit or Enter any other number to continue... \n"
string12:     .asciiz       "if you want to use the previous result in another operation enter 1...\n"
len:          .word     2		                        # Fixed size for the scanned array in division and power . 	
array:        .space    1000				        #Array beginning (Fixed size: 1000).
v:            .word     0					#Loop initial counter (1 or 0).
op:           .word     0				        #Operation choice number.
	          


                  .text
		  .globl main
	
		  
main:
		   
           li  $v0,4
           la  $a0,Welcome
           syscall	
		        #Assigning variables to registers.
           la  $s0,array
           la  $t0,ap
           la  $t1,st_result
           la  $t2,result
           la  $t3,R
           la  $t4,len  
	   la  $t5,v
           la  $t6,op
           la  $s4,name
		   
con_while1:  
		        #Checking if user chose to exit or no.
	  lw   $s2,0($t0)
          beq  $s2,0,finally
	  li   $v0,4
          la   $a0,string1			#Preview instructions to user.
          syscall 
	  li  $v0,5				#Scanning operation.
          syscall
          sw  $v0,0($t6)                        #store in memory of t6 from v0 (value of op).	   
          lw  $s1,0($t6)                        #load from memory of t6 in s1 (value of op).
          li $t7,1
          li $t8,9
				 
con_while2:  #Checking if the operation is valid or not,if not branch for while2 .
	  bgt  $s1,$t8,while2                   #checking if op greater than 9.  
          blt  $s1,$t7,while2                   #checing if op less than 1.
          j exit_while2			 
while2:	   
			#Asking user to enter a valid operation.
           li   $v0,4
           la   $a0,string2
           syscall 
	   li  $v0,5
           syscall		   
           sw  $v0,0($t6)
           lw  $s1,0($t6)
           j con_while2
exit_while2:

#Checking if the the operation is factorial and if the previous result is used or not.
           li   $t8,6
	   li   $t7,1
con1_if1:    	
           beq  $s1,$t8,con2_if1
           j exit_if1
con2_if1:   
	  lw   $t9,0($t3)
          bne  $t9,$t7,if1
          j    Final_exit
##################################################
if1:
	#Scanning factorial input.
           li   $v0,4
           la   $a0,string3
           syscall 
	   li  $v0,5
           syscall		   
           sw  $v0,0($s0)
           lw  $t7,0($s0)
           li  $t8,0

      #Checking if the number is less than 1.
con_while3: 
          blt  $t7,$t8,while3     
          j exit_while3	

 #Keep scanning till user enters a valid number.		 
while3:	        
           li   $v0,4
           la   $a0,string4
           syscall 
	   li  $v0,5
           syscall		   
           sw  $v0,0($s0)
           lw  $t7,0($s0)
           j con_while3
exit_while3: 
           j Final_exit     #if true call the wanted opertion

#################################################
#If the operation is not factorial then check if it's power or division.

exit_if1:    
             li   $t7,4
             li   $t8,5 
             beq  $s1,$t7,if2 
             beq  $s1,$t8,if2
	     j exit_if2
if2:         
			
             li   $v0,4
             la   $a0,string5
             syscall 
	     lw   $t9,0($t5)
	     li   $t7,2
	     li   $t8,1
	     sw   $t8,4($s0)
	     li   $s5,4

	   #Scanning for the first input.
for_loop1:
	     sll $s7,$t9,2
             add $s6,$s0,$s7	
	     li  $v0,5
             syscall
             sw $v0,0($s6)
	     addi $t9,$t9,1
	   #An if condition which checks second number to not equal zero for division.
con1: 
	     lw $t8,4($s0)
	     beq $t8,$zero,con2 
	     j exit_con
con2:  
             beq $s1,$s5,if_con	
             j exit_con		
if_con: 	
	    li   $v0,4
            la   $a0,string6
            syscall 
            sub $t9,$t9,1             #Loop counter -1 to keep scanning
exit_con:		
	   bge $t9,$t7,Final_exit
           j for_loop1	
##################################################
      #check if the user want the previous operation.
exit_if2: 
          li   $t7,9
          bne $s1,$t7,ELSE	  
          li  $v0,4
          la  $a0,string7
          syscall	
          li  $v0,4
          move  $a0,$s4
          syscall
	  li  $v0,4
          la  $a0,string8
          syscall	
	  li  $v0,1
          lw  $a0,0($t1)
          syscall
	  j Final_exit
##################################################
 #check if the user want to any other operation (enter the number of inputs).
ELSE:
               
	  li   $v0,4
          la   $a0,string9
          syscall 
          li  $v0,5
          syscall
	  move  $t7,$v0
	  sw $v0,0($t4)
	  lw   $t9,0($t5)
for_loop2:
	   sll $s7,$t9,2
           add $s6,$s0,$s7	
	   li  $v0,5
           syscall
           sw $v0,0($s6)
	   addi $t9,$t9,1
	   bge $t9,$t7,Final_exit
           j for_loop2	
##############################################
    #choose the function that the user wanted
Final_exit:

	li $t7,1
	beq $s1,$t7,add_call
	li $t7,2
	beq $s1,$t7,sub_call
	li $t7,3
	beq $s1,$t7,mult_call
	li $t7,4
	beq $s1,$t7,div_call
	li $t7,5
	beq $s1,$t7,pow_call
	li $t7,6
	beq $s1,$t7,fact_call
	li $t7,7
	beq $s1,$t7,max_call
	li $t7,8
	beq $s1,$t7,min_call

####################################
#if the function the the user wanted to call is addition
add_call:
		move $a0,$s0          #store the first address of array
		lw $a1,0($t4)         #load the size of array from memory
		jal addition
		sw $v0,0($t2)         #the result
		la $s4,val_name1      #the operation's name
		j Finish_call


#if the function the the user wanted to call is substract
sub_call:
                move $a0,$s0          #store the first address of array
	        lw $a1,0($t4)         #load the size of array from memory
		jal subtract
		sw $v0,0($t2)
		la $s4,val_name2
		j Finish_call


#if the function the the user wanted to call is multiply
mult_call:
                move $a0,$s0
		lw $a1,0($t4)
		jal Multiply
		sw $v0,0($t2)
		la $s4,val_name3
		j Finish_call



#if the function the the user wanted to call is division
div_call:
		lw $a0,0($s0)
		lw $a1,4($s0)
		jal Division
		sw $v0,0($t2)
		la $s4,val_name4
		j Finish_call


#if the function the the user wanted to call is power
pow_call:
		lw $a0,0($s0)
		lw $a1,4($s0)
		jal Power
		sw $v0,0($t2)
		la $s4,val_name5
		j Finish_call



#if the function the the user wanted to call is factorial
fact_call:
		lw $a0,0($s0)
		jal Factorial
		sw $v0,0($t2)
		la $s4,val_name6
		j Finish_call


#if the function the the user wanted to call is maximum
max_call:
                move $a0,$s0
		lw $a1,0($t4)
		jal maximum
		sw $v0,0($t2)
		la $s4,val_name7
		j Finish_call


#if the function the the user wanted to call is minimum
min_call:
                move $a0,$s0
		lw $a1,0($t4)
		jal minimum
		sw $v0,0($t2)
		la $s4,val_name8
		j Finish_call
########################################
		
Finish_call:
		li  $t7,9
		beq $s1,$t7,Exit47
		lw  $t7,0($t2)
		sw  $t7,0($t1)
		li  $v0,4
                la  $a0,string10
                syscall
		li  $v0,1
		lw $a0,0($t2)
		syscall
Exit47:
	        li  $v0,4
                la  $a0,string11
                syscall
		li  $v0,5
		syscall
		sw $v0,0($t0)
	        lw $t7,0($t0)
	        beq $t7,$zero,finally
	        li  $v0,4
                la  $a0,string12
                syscall
		li  $v0,5
		syscall
		sw $v0,0($t3)
		li $t7,1
		bne $t7,$v0,els
		sw $t7,0($t5)
		lw $t7,0($t1)
		sw $t7,0($s0)
		j con_while1
els:
	       sw $zero,0($t5)
	       j con_while1
finally: 
               li $v0,10
	       syscall

####################################################################################
#################################### Functions #####################################
####################################################################################	
	
maximum: 
		 addi $sp, $sp, -4
		 sw $t3, 0($sp)
		 addi $sp, $sp, -4
		 sw $t7, 0($sp)
                 addi $sp, $sp, -4
		 sw $s2, 0($sp)
		 addi $sp, $sp, -4
		 sw $t0, 0($sp)
		 addi $sp, $sp, -4
		 sw $t6, 0($sp)

                 move $t3,$zero
                 addi $t3 ,$t3 ,1             #i =1 to start loop  
                 move $t7 ,$a1                #move size of array 
                 move   $s2 , $a0             #move base address to s2
                 lw   $t0 , 0($s2)            #result = array[0]
 
loop_max:

                sll $t5 ,$t3,2                #$t1 = 4*i
                add   $t5,$t5,$s2             # $t5 = address of save[i]
                lw  $t6, 0($t5)               # temp $t6 =myarray[i] and max =myarray[i]
                beq $t3,$t7, exit_max         #if i ==size exit else check
                blt $t6, $t0 , cond_max	      #if myarray[i] < max back to loop else swap 
                move $t0,$t6                  #max = array[i]


cond_max:
               addi $t3,$t3,1	               #i=i+1
               j loop_max                      #back to loop	
exit_max:
               move $v0,$t0
               lw $t6, 0($sp) 
               addi $sp, $sp, 4
               lw $t0, 0($sp) 
               addi $sp, $sp, 4
               lw $s2, 0($sp)
               addi $sp, $sp, 4
               lw $t7, 0($sp)
               addi $sp, $sp, 4
               lw $t3, 0($sp)
               addi $sp, $sp, 4
               jr $ra                           #exit function

#################################################################

minimum: 
		 addi $sp, $sp, -4
		 sw $t3, 0($sp)
		 addi $sp, $sp, -4
		 sw $t7, 0($sp)
                 addi $sp, $sp, -4
		 sw $s2, 0($sp)
		 addi $sp, $sp, -4
		 sw $t0, 0($sp)
		 addi $sp, $sp, -4
		 sw $t6, 0($sp)

                move $t3,$zero
                addi $t3 ,$t3 ,1                #i =1 to start loop
                move $t7 ,$a1                   #move size of array 
                move   $s2 , $a0                #move base address to s2
                lw   $t0 , 0($s2)               #result = array[0]
 
loop_min:
                sll $t5 ,$t3,2                  #$t1 = 4*i
                add   $t5,$t5,$s2               # $t5 = address of save[i]
                lw  $t6, 0($t5)                 # temp $t6 =myarray[i] and max =myarray[i]
                beq $t3,$t7, exit_min           #if i ==size exit else check
                bgt $t6, $t0 , cond_min	        #if myarray[i] < max back to loop else swap 
                move $t0,$t6                    #max = array[i]


cond_min:
                addi $t3,$t3,1	                #i=i+1
                j loop_min                      #back to loop	
exit_min:
                move $v0,$t0
               lw $t6, 0($sp) 
               addi $sp, $sp, 4
               lw $t0, 0($sp) 
               addi $sp, $sp, 4
               lw $s2, 0($sp)
               addi $sp, $sp, 4
               lw $t7, 0($sp)
               addi $sp, $sp, 4
               lw $t3, 0($sp)
               addi $sp, $sp, 4
               jr $ra                           #exit function

###################################################################
Division: 
               addi $sp, $sp, -4
               sw $t7, 0($sp)
	       add $t7,$0,$a0  
               div $t7,$a1
	       mflo $t7
	       move $v0,$t7
	       lw $t7, 0($sp)
               addi $sp, $sp, 4
	       jr  $ra 

###################################################################

Multiply:
               addi $sp, $sp, -4
               sw $t0, 0($sp)
	       addi $sp, $sp, -4
               sw $t5, 0($sp)
	       addi $sp, $sp, -4
               sw $t4, 0($sp)
	       addi $sp, $sp, -4
               sw $t1, 0($sp)

	       move $t0,$a0 
	       addi $t5,$0,1
	       li $t4,0
Loop2:  
		beq $t4,$a1,done_mult
		lw $t1,0($t0)
                mult $t5,$t1
		mflo $t5
 		addi $t4,$t4,1
		addi $t0,$t0,4
		j Loop2
	
done_mult:
	        move $v0,$t5
	        lw $t1, 0($sp)
                addi $sp, $sp, 4
	        lw $t4, 0($sp)
                addi $sp, $sp, 4
        	lw $t5, 0($sp)
                addi $sp, $sp, 4
	        lw $t0, 0($sp)
                addi $sp, $sp, 4
	        jr $ra     

######################################################
	
Factorial: 
               addi $sp, $sp, -4
               sw $t7, 0($sp)
	       addi $t7,$0,1  
Loop:  
		beq $a0,$0,Exit
		mult $t7,$a0
		mflo $t7
		addi $a0,$a0,-1
		j Loop
Exit:   
		move $v0,$t7
		lw $t7, 0($sp)
                addi $sp, $sp, 4
	        jr  $ra 

##########################################################

Power: 
                addi $sp, $sp, -4
		sw $t7, 0($sp)
	        add $t7,$0,$a0 
		blt $a1,$zero,fin1
		beq $a1,$zero,fin2
                addi $a1,$a1,-1 
Loop1:  
		beq $a1,$0,Exit1
		mult $t7,$a0
		mflo $t7
		addi $a1,$a1,-1
		j Loop1	
 	        j x
fin1:
	        li $t7,0
x:
	        j xx
fin2:
	        li  $t7,1
xx:
Exit1:   
		move $v0,$t7
		lw $t7, 0($sp)
                addi $sp, $sp, 4
	        jr  $ra 	


####################################################################


addition:
               addi $sp, $sp, -4
               sw $t0, 0($sp)
	       addi $sp, $sp, -4
               sw $t5, 0($sp)
	       addi $sp, $sp, -4
               sw $t4, 0($sp)
	       addi $sp, $sp, -4
               sw $t1, 0($sp)

	       move $t0,$a0 
	       move $t5,$0
	       li $t4,0
Loop20:  
		beq $t4,$a1,done_add
		lw $t1,0($t0)
                add $t5,$t5,$t1
 		addi $t4,$t4,1
		addi $t0,$t0,4
		j Loop20
	
done_add:
	        move $v0,$t5
	        lw $t1, 0($sp)
                addi $sp, $sp, 4
	        lw $t4, 0($sp)
                addi $sp, $sp, 4
        	lw $t5, 0($sp)
                addi $sp, $sp, 4
	        lw $t0, 0($sp)
                addi $sp, $sp, 4
	        jr $ra   


####################################################################


subtract:
               addi $sp, $sp, -4
               sw $t0, 0($sp)
	       addi $sp, $sp, -4
               sw $t5, 0($sp)
	       addi $sp, $sp, -4
               sw $t4, 0($sp)
	       addi $sp, $sp, -4
               sw $t1, 0($sp)

	       move $t0,$a0 
	       lw $t5,0($t0)
	       li $t4,1
               addi $t0,$t0,4
Loop30:  
		beq $t4,$a1,done_sub
		lw $t1,0($t0)
                sub $t5,$t5,$t1
 		addi $t4,$t4,1
		addi $t0,$t0,4
		j Loop30
	
done_sub:
	        move $v0,$t5
	        lw $t1, 0($sp)
                addi $sp, $sp, 4
	        lw $t4, 0($sp)
                addi $sp, $sp, 4
        	lw $t5, 0($sp)
                addi $sp, $sp, 4
	        lw $t0, 0($sp)
                addi $sp, $sp, 4
	        jr $ra                                                          