.section .rodata
	msg_main_1:
	.string "\nCalling fun1\n"

	msg_main_2:
	.string "\nCalling fun2\n"

	msg_fun_1:
	.string "In fun1, no = %d\n"

	msg_fun_2:
	.string "In fun2, no = %d\n"

.section .data
	.type	no, @object
	.size	no, 4
	.align  4
	no:
	.int 10


.section .text
	.globl	main
	.type   main, @function
	main:
		pushl	%ebp
		movl	%esp, %ebp

		subl	$4, %esp

		pushl	$msg_main_1
		call 	printf
		addl	$4, %esp

# for begins here
		movl	$0, -4(%ebp)			
		jmp		lable_for1_condition
label_for1:
		call 	fun1

		addl	$1, -4(%ebp)
lable_for1_condition:
		movl	-4(%ebp), %eax
		cmpl	$3, %eax
		jl		label_for1
# for ends here	

		pushl	$msg_main_2
		call 	printf
		addl	$4, %esp

# for begins here
		movl	$0, -4(%ebp)
		jmp		lable_for2_condition
label_for2:
		call 	fun2

		addl	$1, -4(%ebp)
lable_for2_condition:
		movl	-4(%ebp), %eax
		cmpl	$3, %eax
		jl		label_for2
# for ends here

		pushl	$0
		call 	exit


	.globl	fun1
	.type	fun1, @function
	fun1:
		pushl	%ebp
		movl	%esp, %ebp

		pushl	$10
		addl	$1, -4(%ebp)
		movl	-4(%ebp), %eax

		pushl	%eax
		pushl	$msg_fun_1
		call 	printf
		addl 	$8, %esp

		subl	$4, %esp
		movl	%ebp, %esp
		popl	%ebp
		ret


	.globl	fun2
	.type	fun2, @function
	fun2:
		pushl	%ebp
		movl	%esp, %ebp

		addl	$1, no
		movl	no, %eax

		pushl	%eax
		pushl	$msg_fun_1
		call 	printf
		addl 	$8, %esp

		movl	%ebp, %esp
		popl	%ebp
		ret
