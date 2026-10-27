.section .rodata
	msg_main_1:
	.string "Enter three numbers: "

	msg_main_2:
	.string "%d%d%d"

	msg_main_3:
	.string "Answer is %d\n";

.section .text
	.globl main
	.type main, @function
	main:
		pushl	%ebp
		movl	%esp, %ebp

		subl	$16, %esp

		pushl	$msg_main_1
		call	printf
		addl	$4, %esp

		leal	-12(%ebp), %eax
		leal	-8(%ebp), %edx
		leal	-4(%ebp), %ecx
		pushl	%eax
		pushl	%edx
		pushl	%ecx
		pushl	$msg_main_2
		call	scanf
		addl	$16, %esp

		movl	-4(%ebp), %eax
		movl	-8(%ebp), %edx
		movl	-12(%ebp), %ecx

		cmpl	%edx, %eax  #compares second operand with first one.
		movl	$1, %ebx	#Assume no1 < no2 and hence store true
		jl		label_next_comp
		movl	$0, %ebx    #Assumption went wrong!

label_next_comp:
		cmpl 	%ebx, %ecx
		movl	$0, %ebx	#Assume (no1 < no2) == no3, but its != in c code
		jne		label_not_equal
		jmp		label_print_result

label_not_equal:
		movl	$1, %ebx

label_print_result:
		pushl	%ebx
		pushl 	$msg_main_3
		call	printf
		addl	$8, %esp

		addl	$12, %esp

		pushl	$0
		call exit

