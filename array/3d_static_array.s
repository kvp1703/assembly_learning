.section .rodata
	msg_main_req_rows_cols:
	.string "Enter value of rows & columns(< %d):\t"

	msg_main_scan_three_int:
	.string "%d%d%d"

	msg_main_scan_int:
	.string "%d"

	msg_main_req_element:
	.string "Enter [%d][%d][%d] value:\t"

	msg_main_print_arr:
	.string "Entered elements are:\n"

	msg_main_print_arr_element:
	.string "[%d][%d][%d] value is:\t%d\n"

.section .text
.globl	main
.type	main, @function
	main:
	pushl	%ebp
	movl	%esp, %ebp

	# 4024 bytes on stack for variables & 3D array
	# -4(%ebp)  : x
	# -8(%ebp)  : y
	# -12(%ebp) : z
	# -16(%ebp) : counter1
	# -20(%ebp) : counter2
	# -24(%ebp) : counter3
	# -4024(%ebp): arr[10][10][10] base address

	subl	$4024, %esp

	# printf("Enter value of rows & columns(< %d):\t", 10);
	pushl	$10
	pushl	$msg_main_req_rows_cols
	call	printf
	addl	$8, %esp

	# scanf("%d%d%d", &x, &y, &z);
	leal	-12(%ebp), %eax
	leal	-8(%ebp), %edx
	leal	-4(%ebp), %ecx
	pushl	%eax
	pushl	%edx
	pushl	%ecx
	pushl	$msg_main_scan_three_int
	call	scanf
	addl	$16, %esp

	# for(counter1 = 0; counter1 < x; counter1++)
	movl	$0, -16(%ebp)

LABEL_OUTER_INPUT_LOOP:
	movl	-16(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_PRINT_SECTION

	# for(counter2 = 0; counter2 < y; counter2++)
	movl	$0, -20(%ebp)

LABEL_MIDDLE_INPUT_LOOP:
	movl	-20(%ebp), %eax
	movl	-8(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_OUTER_INPUT_NEXT

	# for(counter3 = 0; counter3 < z; counter3++)
	movl	$0, -24(%ebp)

LABEL_INNER_INPUT_LOOP:
	movl	-24(%ebp), %eax
	movl	-12(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_MIDDLE_INPUT_NEXT

	# printf("Enter [%d][%d][%d] value:\t", counter1, counter2, counter3);
	movl	-24(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	-16(%ebp), %ecx
	pushl	%eax
	pushl	%edx
	pushl	%ecx
	pushl	$msg_main_req_element
	call	printf
	addl	$16, %esp

	# Address Calculation: &arr[counter1][counter2][counter3]
	# Addition Method + Indexed Addressing Mode
	# Offset = (counter1 * 10 * 10 * 4) + (counter2 * 10 * 4) + (counter3 * 4)
	#        = (counter1 * 400) + (counter2 * 40) + (counter3 * 4)
	movl	-16(%ebp), %eax		# counter1
	movl	$400, %ecx			# size of 2D slice (10 * 10 * 4)
	mull	%ecx				# eax = counter1 * 400
	movl	-20(%ebp), %edx		# counter2
	imull	$40, %edx			# edx = counter2 * 40
	addl	%edx, %eax			# eax = addr offset up to arr[counter1][counter2][0]
	leal	-4024(%ebp), %ebx	# ebx = base addr of arr
	addl	%ebx, %eax			# eax = addr of arr[counter1][counter2][0]
	movl	-24(%ebp), %edx		# edx = counter3
	leal	(%eax, %edx, 4), %ebx 	# ebx = addr of arr[counter1][counter2][counter3] (Indexed Mode)

	# scanf("%d", &arr[counter1][counter2][counter3]);
	pushl	%ebx
	pushl	$msg_main_scan_int
	call	scanf
	addl	$8, %esp

	# counter3++
	addl	$1, -24(%ebp)
	jmp		LABEL_INNER_INPUT_LOOP

LABEL_MIDDLE_INPUT_NEXT:
	# counter2++
	addl	$1, -20(%ebp)
	jmp		LABEL_MIDDLE_INPUT_LOOP

LABEL_OUTER_INPUT_NEXT:
	# counter1++
	addl	$1, -16(%ebp)
	jmp		LABEL_OUTER_INPUT_LOOP

LABEL_PRINT_SECTION:
	# printf("Entered elements are:\n");
	pushl	$msg_main_print_arr
	call	printf
	addl	$4, %esp

	# for (counter1 = 0; ...)
	movl	$0, -16(%ebp)

LABEL_OUTER_PRINT_LOOP:
	movl	-16(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_EXIT

	# for (counter2 = 0; ...)
	movl	$0, -20(%ebp)

LABEL_MIDDLE_PRINT_LOOP:
	movl	-20(%ebp), %eax
	movl	-8(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_OUTER_PRINT_NEXT

	# for (counter3 = 0; ...)
	movl	$0, -24(%ebp)

LABEL_INNER_PRINT_LOOP:
	movl	-24(%ebp), %eax
	movl	-12(%ebp), %ecx
	cmpl	%ecx, %eax
	jge		LABEL_MIDDLE_PRINT_NEXT

	# Value retrieval: arr[counter1][counter2][counter3]
	movl	-16(%ebp), %eax		# counter1
	movl	$400, %ecx			# size of 2D slice (10 * 10 * 4)
	mull	%ecx				# eax = counter1 * 400
	movl	-20(%ebp), %edx		# counter2
	imull	$40, %edx			# edx = counter2 * 40
	addl	%edx, %eax			# eax = addr offset up to arr[counter1][counter2][0]
	leal	-4024(%ebp), %ebx	# ebx = base addr of arr
	addl	%ebx, %eax			# eax = addr of arr[counter1][counter2][0]
	movl	-24(%ebp), %edx		# edx = counter3
	movl	(%eax, %edx, 4), %ecx 	# ecx = value of arr[counter1][counter2][counter3] (Indexed Mode)

	# printf("[%d][%d][%d] value is:\t%d\n", counter1, counter2, counter3, val);
	movl	-24(%ebp), %ebx
	movl	-20(%ebp), %edx
	movl	-16(%ebp), %eax
	pushl	%ecx
	pushl	%ebx
	pushl	%edx
	pushl	%eax
	pushl	$msg_main_print_arr_element
	call	printf
	addl	$20, %esp

	# counter3++
	addl	$1, -24(%ebp)
	jmp		LABEL_INNER_PRINT_LOOP

LABEL_MIDDLE_PRINT_NEXT:
	# counter2++
	addl	$1, -20(%ebp)
	jmp		LABEL_MIDDLE_PRINT_LOOP

LABEL_OUTER_PRINT_NEXT:
	# counter1++
	addl	$1, -16(%ebp)
	jmp		LABEL_OUTER_PRINT_LOOP

LABEL_EXIT:
	# exit(0);
	pushl	$0
	call	exit
