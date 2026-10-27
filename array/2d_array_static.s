.section .rodata
	msg_main_req_rows_cols:
	.string "Enter value of rows & columns(< %d):\t"

	msg_main_scan_two_int:
	.string "%d%d"

	msg_main_scan_int:
	.string "%d"

	msg_main_req_element:
	.string "Enter [%d][%d] value:\t"

	msg_main_print_arr:
	.string "Entered elements are:\n"

	msg_main_print_arr_element:
	.string "[%d][%d] value is:\t%d\n"

.section .text
.globl	main
.type	main, @function
	main:
	pushl	%ebp
	movl	%esp, %ebp

	# Allocate 416 bytes on stack for variables & 2D array
	# MAX: 10 => 10 * 10 + 4 int vars => 400 + 16
	subl	$416, %esp

	# printf("Enter value of rows & columns(< %d):\t", 10);
	pushl	$10
	pushl	$msg_main_req_rows_cols
	call	printf
	addl	$8, %esp

	# scanf("%d%d", &rows, &icolumns);
	leal	-8(%ebp), %eax
	leal	-4(%ebp), %edx
	pushl	%eax
	pushl	%edx
	pushl	$msg_main_scan_two_int
	call	scanf
	addl	$12, %esp

	# for(counter1 = 0; counter1 < rows; counter1++)
	movl	$0, -12(%ebp)

LABEL_OUTER_INPUT_LOOP:
	movl	-12(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_PRINT_SECTION

	# for(counter2 = 0; counter2 < columns; counter2++)
	movl	$0, -16(%ebp)

LABEL_INNER_INPUT_LOOP:
	movl	-16(%ebp), %eax
	movl	-8(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_OUTER_INPUT_NEXT

	# printf("Enter [%d][%d] value:\t", iCounter1, iCounter2);
	movl	-16(%ebp), %eax
	movl	-12(%ebp), %edx
	pushl	%eax
	pushl	%edx
	pushl	$msg_main_req_element
	call	printf
	addl	$12, %esp

	# Address Calculation: &arr[counter1][counter2]
	# Offset = (iCounter1 * 10 + iCounter2) * 4
	# movl	-12(%ebp), %eax
	# imull	$10, %eax
	# movl	-16(%ebp), %edx
	# addl	%edx, %eax
	# leal	-416(%ebp), %edx
	# leal	(%edx, %eax, 4), %ecx

	movl	-12(%ebp), %eax		# counter1 (row) in eax
	movl	-8(%ebp), %ecx		# col in eax
	mul 	%ecx				# no of elements before ar[counter][0]
	movl	$4, %ecx			# size of int
	mul 	%ecx				# size of elements before ar[counter][0]
	leal 	-416(%ebp), %ebx	# addr of ar
	addl	%ebx, %eax			# addr of ar[counter1][0]
	movl	-16(%ebp), %edx		# edx = counter2
	leal 	(%eax, %edx, 4), %ebx 	# addr of ar[counter1][counter2]

	# scanf("%d", &arr[counter1][counter2]);
	pushl	%ebx
	pushl	$msg_main_scan_int
	call	scanf
	addl	$8, %esp

	# counter2++
	addl	$1, -16(%ebp)
	jmp		LABEL_INNER_INPUT_LOOP

LABEL_OUTER_INPUT_NEXT:
	# counter1++
	addl	$1, -12(%ebp)
	jmp		LABEL_OUTER_INPUT_LOOP

LABEL_PRINT_SECTION:
	# printf("Entered elements are:\n");
	pushl	$msg_main_print_arr
	call	printf
	addl	$4, %esp

	# for (counter1 = 0; ...)
	movl	$0, -12(%ebp)

LABEL_OUTER_PRINT_LOOP:
	movl	-12(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_EXIT

	# for (counter2 = 0; ...)
	movl	$0, -16(%ebp)

LABEL_INNER_PRINT_LOOP:
	movl	-16(%ebp), %eax
	movl	-8(%ebp), %ecx		# col in eax
	cmpl	%ecx, %eax
	jge		LABEL_OUTER_PRINT_NEXT

	# Value retrieval: arr[counter1][counter2]
	movl	-12(%ebp), %eax		# counter1 (row) in eax
	mul 	%ecx				# no of elements before ar[counter][0]
	movl	$4, %ecx			# size of int
	mul 	%ecx				# size of elements before ar[counter][0]
	leal 	-416(%ebp), %ebx	# addr of ar
	addl	%ebx, %eax			# addr of ar[counter1][0]
	movl	-16(%ebp), %edx		# edx = counter2
	movl 	(%eax, %edx, 4), %ecx 	# addr of ar[counter1][counter2]

	# printf("[%d][%d] value is:\t%d\n", counter1, counter2, arr[counter1][counter2]);
	movl	-12(%ebp), %eax
	pushl	%ecx
	pushl	%edx
	pushl	%eax
	pushl	$msg_main_print_arr_element
	call	printf
	addl	$16, %esp

	# counter2++
	addl	$1, -16(%ebp)
	jmp		LABEL_INNER_PRINT_LOOP

LABEL_OUTER_PRINT_NEXT:
	# counter1++
	addl	$1, -12(%ebp)
	jmp		LABEL_OUTER_PRINT_LOOP

LABEL_EXIT:
	# exit(0);
	pushl	$0
	call	exit
