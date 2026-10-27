.section .rodata
	msg_main_1:
	.string "1: Addition\n2: Subtraction\n3: Multiplication\n4: Division\n"

	msg_main_2:
	.string "Enter your choise: "

	msg_main_3:
	.string "%d"

	msg_main_add:
	.string "You chose Addition\n"

	msg_main_sub:
	.string "You chose Subtraction\n"

	msg_main_mul:
	.string "You chose Multiplication\n"

	msg_main_div:
	.string "You chose Division\n"

	msg_main_invalid:
	.string "You chose invalid number\n"

	msg_main_debug:
	.string "Enter entred : %d\n"

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

		pushl	$msg_main_2
		call	printf
		addl	$4, %esp

		leal	-4(%ebp), %eax
		pushl	%eax
		pushl	$msg_main_3
		call	scanf
		addl	$8, %esp

		movl	-4(%ebp), %eax

		cmpl	$1, %eax
		jne		label_sub

		pushl	$msg_main_add
		call	printf
		addl	$4, %esp
		jmp		label_exit	

label_sub:
		#cmpl	$2, %eax   refer last comparison, it is same. No need to repeate
		jne		label_mul

		pushl	$msg_main_sub
		call	printf
		addl	$4, %esp
		jmp		label_exit	

label_mul:
		#cmpl	$3, %eax
		jne		label_div

		pushl	$msg_main_mul
		call	printf
		addl	$4, %esp
		jmp		label_exit

label_div:
		#cmpl	$4, %eax
		jne		label_invalid

		pushl	$msg_main_div
		call	printf
		addl	$4, %esp
		jmp		label_exit

label_invalid:
		pushl	$msg_main_invalid
		call	printf
		addl	$4, %esp

label_exit:
		addl	$4, %esp

		pushl	$0
		call	exit

		
