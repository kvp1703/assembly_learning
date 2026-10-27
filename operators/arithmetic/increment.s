.section .rodata
	msg_main_1:
	.string "no1: %d\nno2: %d\nans1: %d\nans2: %d\n"

	msg_main_2:
	.string "Incremented ans2:%d\n"


.section .text
	.globl main
	.type main, @function
	main:
		push %ebp
		movl %esp, %ebp

		pushl $10
		pushl $20
		subl  $8, %esp          #Space for ans1, ans2

		addl  $1, -4(%ebp)      # increment first
		movl  -4(%ebp), %eax    # ans1 = no1
		movl  %eax, -12(%ebp)	# ans1 = no1

		movl  -8(%ebp), %ebx    # ans2 = no2
		movl  %ebx, -16(%ebp)	# ans2 = no2
		addl  $1, -8(%ebp)		# increment later 

		pushl %ebx				# already there in ebx, line 22 
		pushl %eax				# already there in eax, line 19 
		pushl -8(%ebp)
		pushl %eax				# already there in eax, line 19
		pushl $msg_main_1
		call  printf
		addl  $16, %esp

		#inc   %ebx	  	 	    # Increment calue from register
		incl -16(%ebp)			# Increment value from memory

		pushl -16(%ebp)
		pushl $msg_main_2
		call printf
		addl $8, %esp			# Not needed

		pushl $0
		call  exit

