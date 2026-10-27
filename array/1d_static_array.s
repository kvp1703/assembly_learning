.section .rodata
	msg_main_req_iMAX:
	.string "Enter value of n(< %d): "

	msg_main_scan_int:
	.string "%d"

	msg_main_malloc_failed:
	.string	"Memory allocation failed\n"

	msg_main_req_element:
	.string "Enter value for index %d: "

	msg_main_print_arr:
	.string "\nEntered elements are:\n"

	msg_main_print_arr_element:
	.string "Elemets at index %d: %d\n"

.section .text
.globl	main
.type	main, @function
	main:
	pushl	%ebp
	movl	%esp, %ebp

	# iMAX, i, arr[10]
	subl	$48, %esp

	# printf("Enter value of n(< %d): ", MAX);
	pushl	$10
	pushl	$msg_main_req_iMAX
	call	printf
	addl	$4, %esp

	# scanf("%d", &MAX);
	leal	-4(%ebp), %edx
	pushl	%edx
	pushl	$msg_main_scan_int
	call	scanf
	addl	$8, %esp

	# first for loop
	movl	$0, -8(%ebp)

LABLE_FOR_ARR_INPUT:

	movl	-8(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_PRINT_ARR

	pushl	%eax
	pushl	$msg_main_req_element
	call	printf
	addl	$8, %esp

	movl	-8(%ebp), %eax
	leal	-48(%ebp), %edx
	leal 	(%edx, %eax, 4), %ecx
	pushl	%ecx
	pushl	$msg_main_scan_int
	call	scanf
	addl	$8, %esp

	addl	$1, -8(%ebp)

	jmp		LABLE_FOR_ARR_INPUT

LABEL_PRINT_ARR:
	pushl	$msg_main_print_arr
	call	printf
	addl	$4, %esp

	movl	$0, -8(%ebp)

LABEL_FOR_PRINT_ARR:
	movl	-8(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_EXIT

	movl	-8(%ebp), %eax
	leal	-48(%ebp), %edx
	movl	(%edx, %eax, 4), %ecx
	pushl	%ecx
	pushl	%eax
	pushl	$msg_main_print_arr_element
	call	printf
	addl	$12, %esp

	addl	$1, -8(%ebp)

	jmp 	LABEL_FOR_PRINT_ARR

LABEL_EXIT:
	pushl	$0
	call	exit
