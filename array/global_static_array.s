.section .rodata
	msg_main_req_iMAX:
	.string "Enter value of n(< %d): "

	msg_main_scan_int:
	.string "%d"

	msg_main_req_arr2_elements:
	.string "Enter arr2[%d]: "

	msg_main_print_arr1:
	.string "\narr1 is:\n"

	msg_main_print_arr1_element:
	.string "arr1[%d] = %d\n"

	msg_main_print_arr2:
	.string "\narr2 is:\n"

	msg_main_print_arr2_element:
	.string "arr2[%d] = %d\n"


.section .bss
	.comm arr2, 10, 4

.section .data
	.globl	arr1
	.type	arr1, @object
	.size	arr1, 12
	.align	4
	arr1:
		.int 10, 20, 30


.section .text
.globl	main
.type	main, @function
	main:
	pushl	%ebp
	movl	%esp, %ebp

	subl	$8, %esp

	# printf("Enter value of n(< %d): ", MAX);
	pushl	$10
	pushl	$msg_main_req_iMAX
	call	printf
	addl	$8, %esp

	# scanf("%d", &iMAX);
	leal	-4(%ebp), %edx
	pushl	%edx
	pushl	$msg_main_scan_int
	call	scanf
	addl	$8, %esp

	# first for loop
	movl	$0, -8(%ebp)

LABLE_FOR_ARR2_INPUT:

	movl	-8(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_PRINT_ARRAY1

	pushl	%eax
	pushl	$msg_main_req_arr2_elements
	call	printf
	addl	$8, %esp

	movl	-8(%ebp), %eax
	leal 	arr2(, %eax, 4), %ebx
	pushl	%ebx
	pushl	$msg_main_scan_int
	call	scanf
	addl	$8, %esp

	addl	$1, -8(%ebp)

	jmp		LABLE_FOR_ARR2_INPUT

LABEL_PRINT_ARRAY1:

	pushl	$msg_main_print_arr1
	call	printf
	addl	$4, %esp

	movl	$0, -8(%ebp)

LABEL_FOR_PRINT_ARR1:
	movl	-8(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_PRINT_ARRAY2

	movl	-8(%ebp), %eax
	movl	arr1(,%eax, 4), %edx
	pushl	%edx
	pushl	%eax
	pushl	$msg_main_print_arr1_element
	call	printf
	addl	$12, %esp

	addl	$1, -8(%ebp)

	jmp 	LABEL_FOR_PRINT_ARR1


LABEL_PRINT_ARRAY2:

	pushl	$msg_main_print_arr2
	call	printf
	addl	$4, %esp

	movl	$0, -8(%ebp)

LABEL_FOR_PRINT_ARR2:
	movl	-8(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_EXIT

	movl	-8(%ebp), %eax
	movl	arr2(,%eax, 4), %edx
	pushl	%edx
	pushl	%eax
	pushl	$msg_main_print_arr2_element
	call	printf
	addl	$12, %esp

	addl	$1, -8(%ebp)

	jmp 	LABEL_FOR_PRINT_ARR2

LABEL_EXIT:
	pushl	$0
	call	exit





