.section .rodata
	msg_main_1:
	.string "Enter number: "

	msg_main_2:
	.string "%d"

	msg_main_3:
	.string "Number is less than 2\n"

	msg_main_4:
	.string "Number is greater than 2\n"

	msg_main_5:
	.string "Number is 2\n"

.section .text
	.globl main
	.type main, @function
	main:
		pushl	%ebp
		movl	%esp, %ebp

		subl	$4, %esp

		pushl	$msg_main_1
		call	printf
		addl	$4, %esp

		leal	-4(%ebp), %eax
		pushl	%eax
		pushl	$msg_main_2
		call	scanf
		addl	$8, %esp

		movl	-4(%ebp), %eax
		cmpl	$2, %eax   # if(no < 2)
		jnl		label_not_less

		pushl	$msg_main_3
		call	printf
		addl	$4, %esp

		jmp		label_exit

label_not_less:
		# cmpl	$2, %eax    # else if(no > 2)
		jng		label_equal

		pushl	$msg_main_4
		call 	printf
		addl	$4, %esp
		jmp		exit

label_equal:
		pushl	$msg_main_5
		call	printf
		addl	$4, %esp

label_exit:
		#addl	$4, %esp

		pushl	$0
		call	exit

		
