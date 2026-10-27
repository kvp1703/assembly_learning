.section .rodata
	msg_main_1:
	.string "Enter numerator: "

	msg_main_2:
	.string "%qd"

	msg_main_3:
	.string "Denominator: %d\nQuotient: %d\nRemainder: %d"

.section .text
	.globl main
	.type main, @function
	main:
		pushl %ebp
		movl  %esp, %ebp

		subl  $12, %ebp

		# User input for numerator
		pushl $msg_main_1
		call  printf
		addl  $4, %esp

		leal  -8(%ebp), %eax       # Store numerator: 1e10 		
		pushl %eax
		pushl $msg_main_2
		call  scanf
		addl  $8, %esp 

		movl $50000, -12(%ebp)     # Store denominator
		
		movl  -8(%ebp), %eax       # Numerator-LSB in EAX only
		movl  -4(%ebp), %edx       # Numerator-MSB in EDX only
		movl  -12(%ebp), %ecx      # Denominator
		div   %ecx

		pushl %edx		           # Remainder in edx
		pushl %eax                 # Quotient in eax
		pushl -12(%ebp)            # Denominator
		pushl $msg_main_3
		call  printf
		addl  $24, %esp

		pushl $0
		call  exit
