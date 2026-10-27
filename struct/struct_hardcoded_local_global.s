.section .rodata
	msg_main_1:
	.string "obj1 is:\n"

	msg_main_2:
	.string "obj2 is:\n"

	msg_main_obj:
	.string "{c: %c, no1: %d, no2: %hd}\n\n"

.section .data
	.globl	obj1
	.type	obj1, @object
	.size	obj1, 12
	.align	4
	obj1:
		.ascii	"A"
		.zero	3 		# This is padding
		.int	10
		.value	20		# value for short int

.section .text
	.globl	main
	.type	main, @function
	main:
		pushl	%ebp
		movl	%esp, %ebp

		subl	$12, %esp			# Size of the struct


		movb	$'B', -12(%ebp)
		movl	$30, -8(%ebp)
		movw	$40, -4(%ebp)

		# ----- PRINTING OBJ1 ------- 

		pushl	$msg_main_1
		call	printf
		addl	$4, %esp

		leal	obj1, %ebx	  # Fetch address if obj1 to ebx
		xorl	%eax, %eax	  # put c in eax, zero out the register
		movb	(%ebx), %al
		movl	4(%ebx), %edx # put no1 in edx
		xorl	%ecx, %ecx	  # put no2 in ecx, zero out the register
		movw	8(%ebx), %cx

		pushl	%ecx
		pushl	%edx
		pushl	%eax
		pushl	$msg_main_obj
		call	printf
		addl	$16, %esp

		# ----- PRINTING OBJ2 ------- 

		pushl	$msg_main_2
		call	printf
		addl	$4, %esp

		leal	-12(%ebp), %ebx	  # Fetch address if obj1 to ebx
		xorl	%eax, %eax	  # put c in eax, zero out the register
		movb	(%ebx), %al
		movl	4(%ebx), %edx # put no1 in edx
		xorl	%ecx, %ecx	  # put no2 in ecx, zero out the register
		movw	8(%ebx), %cx

		pushl	%ecx
		pushl	%edx
		pushl	%eax
		pushl	$msg_main_obj
		call	printf
		addl	$16, %esp

		pushl	$0
		call	exit







