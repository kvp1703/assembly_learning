.section .rodata
	msg_main_1:
	.string "Number %d is even!"

.section .text
	.globl main
	.type main, @function
	main:
		pushl	%ebp
		movl	%esp, %ebp

		pushl	$10	#Evaluating 10

		movl	$1, %eax
		andl	-4(%ebp), %eax
		cmpl	$0, %eax
		jne		label_next_code 

		pushl	-4(%ebp)
		pushl	$msg_main_1
		call	printf
		addl	$8, %esp 

label_next_code:
		pushl	$0
		call 	exit
