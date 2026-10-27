.section .rodata
	msg_main_1:
	.string "Multiplicaton is : %qd"

.section .text
	.globl main
	.type main, @function
	main:
		pushl %ebp
		movl  %esp, %ebp

		pushl $5
		pushl $10

		subl  $8, %esp          	   # store 8 byte long long

		movl  -4(%ebp), %eax           # Store first num in EAX
		movl  -8(%ebp), %ecx		   # Choose register other than EDX
		mul   %ecx

		pushl %edx		               # MSB
		pushl %eax                     # LSB
		pushl $msg_main_1
		call  printf
		addl  $12, %esp

		pushl $0
		call  exit
