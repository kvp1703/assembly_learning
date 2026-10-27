.section .rodata
	msg_main_print_counter:
	.string "counter = %d\n"

	msg_main_1:
	.string "Enter number: "

	msg_main_2:
	.string "%d"



.section .text
	.globl	main
	.type	main, @function
	main:

		pushl	%ebp
		movl	%esp, %ebp

		subl	$8, %esp

		#--------- IO ----------
		pushl	$msg_main_1
		call	printf
		addl	$4, %esp
 
		leal 	-4(%ebp), %eax	#no
		pushl	%eax
		pushl	$msg_main_2
		call	scanf
		addl	$8, %esp
		#-----------------------

		movl	$0,	-8(%ebp) 		# counter = 0 
		jmp 	label_for_condition

label_for:
		pushl	%eax
		pushl	$msg_main_print_counter
		call	printf
		addl	$8, %esp

		movl	-8(%ebp), %eax	#counter
		movl	-4(%ebp), %edx	#no		#If counter == 3 , break;
		cmpl	$3, %eax
		je		label_exit

		addl	$1, -8(%ebp)

label_for_condition:
		movl	-8(%ebp), %eax	#counter
		movl	-4(%ebp), %edx	#no
		cmpl	%edx, %eax
		jl		label_for

label_exit:
		pushl	$0
		call	exit

