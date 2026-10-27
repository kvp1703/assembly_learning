.section .rodata
	msg_main_instruction_1:
	.string "Enter obj1 values\n"

	msg_main_instruction_2:
	.string "\nEnter obj2 values\n"

	msg_main_print_c:
	.string "Enter c: "

	msg_main_scan_c:
	.string "%c"

	msg_main_scan_second_c:
	.string "%c%c"

	msg_main_print_no1:
	.string "Enter no1: "

	msg_main_scan_no1:
	.string "%d"

	msg_main_print_no2:
	.string "Enter no2: "

	msg_main_scan_no2:
	.string "%hd"

	msg_main_1:
	.string "\nobj1 is:\n"

	msg_main_2:
	.string "\nobj2 is:\n"
	
	msg_main_obj:
	.string "{c: %c, no1: %d, no2: %hd}\n"

.section .bss
	.comm obj1, 12, 4

.section .text
	.globl	main
	.type	main, @function
	main:
		pushl	%ebp
		movl	%esp, %ebp

		subl	$12, %esp			# Size of the 

		# --------- IO for ojb1 ------------

		pushl	$msg_main_instruction_1
		call	printf
		addl	$4, %esp

		# scan C
		pushl	$msg_main_print_c
		call	printf
		addl	$4, %esp

		leal	obj1, %ebx
		pushl	%ebx
		pushl	$msg_main_scan_c
		call	scanf
		addl	$8, %esp

		#scan no1
		pushl	$msg_main_print_no1
		call	printf
		addl	$4, %esp

		leal	obj1, %ebx
		leal	4(%ebx), %eax
		pushl	%eax
		pushl	$msg_main_scan_no1
		call	scanf
		addl	$8, %esp

		#scan no2
		pushl	$msg_main_print_no2
		call	printf
		addl	$4, %esp

		leal	obj1, %ebx
		leal	8(%ebx), %edx
		pushl	%edx
		pushl	$msg_main_scan_no2
		call	scanf
		addl	$8, %esp

		# --------- IO for ojb2 ------------

		pushl	$msg_main_instruction_2
		call	printf
		addl	$4, %esp

		# scan C
		pushl	$msg_main_print_c
		call	printf
		addl	$4, %esp

		leal	-16(%ebp), %ecx
		leal	-12(%ebp), %ebx
		pushl	%ebx
		pushl	%ecx
		pushl	$msg_main_scan_second_c
		call	scanf
		addl	$12, %esp

		#scan no1
		pushl	$msg_main_print_no1
		call	printf
		addl	$4, %esp

		#leal	-16(%ebp), %ecx
		leal	-12(%ebp), %ebx
		leal	4(%ebx), %eax
		pushl	%eax
		#pushl	%ecx
		pushl	$msg_main_scan_no1
		call	scanf
		addl	$8, %esp

		#scan no2
		pushl	$msg_main_print_no2
		call	printf
		addl	$4, %esp

		#leal	-16(%ebp), %ecx
		leal	-12(%ebp), %ebx
		leal	8(%ebx), %edx
		pushl	%edx
		#pushl	%ecx
		pushl	$msg_main_scan_no2
		call	scanf
		addl	$8, %esp

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







