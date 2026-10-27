.section .rodata
	msg_main_1:
	.string "obj1 is:\n"

	msg_main_2:
	.string "obj2 is:\n"

	msg_main_3:
	.string "obj3 is:\n"

	msg_main_obj:
	.string "{c: %c, no1: %d, no2: %hd}\n\n"

	msg_main_cmp_1_2_print:
	.string "obj1 & obj2 comparison is: "

	msg_main_cmp_2_3_print:
	.string "obj2 & obj3 comparison is: "

	msg_main_cmp_result_equal:
	.string "Equal\n"

	msg_main_cmp_result_unequal:
	.string "Unequal\n"

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

		subl	$24, %esp			# Size of the struct


		movb	$'B', -12(%ebp)
		movl	$30, -8(%ebp)
		movw	$40, -4(%ebp)

		movb	$'B', -24(%ebp)
		movl	$30, -20(%ebp)
		movw	$40, -16(%ebp)

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

		leal	-12(%ebp), %ebx	  # Fetch address if obj2 to ebx
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

		# ----- PRINTING obj3 ------- 

		pushl	$msg_main_3
		call	printf
		addl	$4, %esp

		leal	-24(%ebp), %ebx	  # Fetch address if obj3 to ebx
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

		pushl	$msg_main_cmp_1_2_print
		call	printf
		addl	$4, %esp

		# ----- Compare obj1 and obj2 -----
		leal 	-12(%ebp), %ebx
		leal 	obj1, %ecx

		movb	(%ecx), %al
		cmpb 	%al, (%ebx)
		jne		label_obj_1_2_unequal
		movl	4(%ecx), %eax
		cmpl 	%eax, 4(%ebx)
		jne		label_obj_1_2_unequal
		movw	8(%ecx), %ax
		cmpw 	%ax, 8(%ebx)
		jne 	label_obj_1_2_unequal

		pushl	$msg_main_cmp_result_equal
		call	printf
		addl	$4, %esp

		jmp 	label_next_comparison

label_obj_1_2_unequal:
		pushl	$msg_main_cmp_result_unequal
		call	printf
		addl	$4, %esp

label_next_comparison:
		pushl	$msg_main_cmp_2_3_print
		call	printf
		addl	$4, %esp

		# ---- Compare obj2 and obj3 -----
		leal 	-12(%ebp), %ebx
		leal 	-24(%ebp), %ecx

		movb	(%ecx), %al
		cmpb 	%al, (%ebx)
		jne		label_obj_2_3_unequal

		movl	4(%ecx), %eax
		cmpl 	%eax, 4(%ebx)
		jne		label_obj_2_3_unequal

		movw	8(%ecx), %ax
		cmpw 	%ax, 8(%ebx)
		jne 	label_obj_2_3_unequal

		pushl	$msg_main_cmp_result_equal
		call	printf
		addl	$4, %esp

		jmp 	label_exit

label_obj_2_3_unequal:
		pushl	$msg_main_cmp_result_unequal
		call	printf
		addl	$4, %esp

label_exit:
		pushl	$0
		call	exit







