.section .rodata
	msg_main_req_MAX:
	.string "Enter the value of lenght of array: "

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

.section .data
	.globl	ptr
	.type	ptr, @object
	.size	ptr, 4
	.align	4
	ptr:
		.int 0


.section .text
.globl	main
.type	main, @function
	main:
	pushl	%ebp
	movl	%esp, %ebp

	subl	$8, %esp

	# printf("Enter the value of lenght of array: ");
	pushl	$msg_main_req_MAX
	call	printf
	addl	$4, %esp

	# scanf("%d", &MAX);
	leal	-4(%ebp), %edx
	pushl	%edx
	pushl	$msg_main_scan_int
	call	scanf
	addl	$8, %esp

	# ptr = (int *) malloc (MAX * sizeof(int));
	# Assuming MAX will not overflow hence will ignore edx
	movl	-4(%ebp), %eax
	movl	$4, %ecx
	mul		%ecx
	pushl	%eax
	call	malloc
	addl	$4, %esp
	movl	%eax, ptr

	# if(ptr == NULL)
	cmpl 	$0, %eax
	jne		LABEL_POST_MALLOC

	pushl	$-1
	call	exit

LABEL_POST_MALLOC:

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
	movl	ptr, %edx
	leal 	(%edx, %eax, 4), %ebx

	pushl	%ebx
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
	jge		LABEL_CLEAN_UP

	movl	-8(%ebp), %eax
	movl	ptr, %edx
	movl 	(%edx, %eax, 4), %ecx
	pushl	%ecx
	pushl	%eax
	pushl	$msg_main_print_arr_element
	call	printf
	addl	$12, %esp

	addl	$1, -8(%ebp)

	jmp 	LABEL_FOR_PRINT_ARR

LABEL_CLEAN_UP:

	movl	ptr, %eax
	pushl	%eax
	call	free
	addl 	$4, %esp

	pushl	$0
	call	exit
