.section .rodata
	msg_main_req_dims:
	.string "Enter value of x, y & z dimensions:\t"

	msg_main_scan_three_int:
	.string "%d%d%d"

	msg_main_malloc_fail:
	.string "Memory allocation FAILED"

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

	# Stack Layout for variables:
	# -4(%ebp)  = x (dimension 1)
	# -8(%ebp)  = y (dimension 2)
	# -12(%ebp) = z (dimension 3)
	# -16(%ebp) = counter1 (i)
	# -20(%ebp) = counter2 (j)
	# -24(%ebp) = counter3 (k)
	# -28(%ebp) = pppPtr (int ***)
	subl	$32, %esp

	# printf("Enter value of x, y & z dimensions:\t");
	pushl	$msg_main_req_dims
	call	printf
	addl	$4, %esp

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

	# pppPtr = (int ***) malloc (x * sizeof(int **));
	movl	-4(%ebp), %eax		# eax = x
	movl	$4, %edx			# edx = 4 (sizeof int**)
	mull	%edx				# eax = x * 4
	pushl	%eax
	call	malloc
	addl	$4, %esp
	movl	%eax, -28(%ebp)		# Store in pppPtr

	# if(NULL == pppPtr)
	cmpl	$0, -28(%ebp)
	jne		LABEL_ALLOC1_SUCCESS
	pushl	$msg_main_malloc_fail
	call	puts
	addl	$4, %esp
	jmp		LABEL_EXIT

LABEL_ALLOC1_SUCCESS:
	# for(counter1 = 0; counter1 < x; counter1++)
	movl	$0, -16(%ebp)

LABEL_OUTER_ALLOC_LOOP:
	movl	-16(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_INPUT_SECTION

	# pppPtr[counter1] = (int **) malloc (y * sizeof(int *));
	movl	-8(%ebp), %eax		# eax = y
	movl	$4, %edx			# edx = 4 (sizeof int*)
	mull	%edx				# eax = y * 4
	pushl	%eax
	call	malloc
	addl	$4, %esp

	# pppPtr[counter1] = eax
	movl	-16(%ebp), %edx		# edx = counter1
	movl	-28(%ebp), %ebx		# ebx = pppPtr
	movl	%eax, (%ebx, %edx, 4)

	# if(NULL == pppPtr[counter1])
	cmpl	$0, (%ebx, %edx, 4)
	jne		LABEL_ALLOC2_SUCCESS
	pushl	$msg_main_malloc_fail
	call	puts
	addl	$4, %esp
	jmp		LABEL_EXIT

LABEL_ALLOC2_SUCCESS:
	# for(counter2 = 0; counter2 < y; counter2++)
	movl	$0, -20(%ebp)

LABEL_MIDDLE_ALLOC_LOOP:
	movl	-20(%ebp), %eax
	movl	-8(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_OUTER_ALLOC_NEXT

	# pppPtr[counter1][counter2] = (int *) malloc (z * sizeof(int));
	movl	-12(%ebp), %eax		# eax = z
	movl	$4, %edx			# edx = 4 (sizeof int)
	mull	%edx				# eax = z * 4
	pushl	%eax
	call	malloc
	addl	$4, %esp

	# Dereference pppPtr[counter1] and store in pppPtr[counter1][counter2]
	movl	-16(%ebp), %ecx		# ecx = counter1
	movl	-28(%ebp), %ebx		# ebx = pppPtr
	movl	(%ebx, %ecx, 4), %ebx	# ebx = pppPtr[counter1]
	movl	-20(%ebp), %edx		# edx = counter2
	movl	%eax, (%ebx, %edx, 4)	# pppPtr[counter1][counter2] = eax

	# if(NULL == pppPtr[counter1][counter2])
	cmpl	$0, (%ebx, %edx, 4)
	jne		LABEL_MIDDLE_ALLOC_NEXT
	pushl	$msg_main_malloc_fail
	call	puts
	addl	$4, %esp
	jmp		LABEL_EXIT

LABEL_MIDDLE_ALLOC_NEXT:
	# counter2++
	addl	$1, -20(%ebp)
	jmp		LABEL_MIDDLE_ALLOC_LOOP

LABEL_OUTER_ALLOC_NEXT:
	# counter1++
	addl	$1, -16(%ebp)
	jmp		LABEL_OUTER_ALLOC_LOOP

LABEL_INPUT_SECTION:
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

	# Address Calculation: &pppPtr[counter1][counter2][counter3]
	movl	-16(%ebp), %eax		# eax = counter1
	movl	-28(%ebp), %ebx		# ebx = pppPtr
	movl	(%ebx, %eax, 4), %ebx	# ebx = pppPtr[counter1]
	movl	-20(%ebp), %edx		# edx = counter2
	movl	(%ebx, %edx, 4), %ebx	# ebx = pppPtr[counter1][counter2]
	movl	-24(%ebp), %ecx		# ecx = counter3
	leal	(%ebx, %ecx, 4), %ebx	# ebx = &pppPtr[counter1][counter2][counter3]

	# scanf("%d", &pppPtr[counter1][counter2][counter3]);
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

	# for(counter1 = 0; ...)
	movl	$0, -16(%ebp)

LABEL_OUTER_PRINT_LOOP:
	movl	-16(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_FREE_SECTION

	# for(counter2 = 0; ...)
	movl	$0, -20(%ebp)

LABEL_MIDDLE_PRINT_LOOP:
	movl	-20(%ebp), %eax
	movl	-8(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_OUTER_PRINT_NEXT

	# for(counter3 = 0; ...)
	movl	$0, -24(%ebp)

LABEL_INNER_PRINT_LOOP:
	movl	-24(%ebp), %eax
	movl	-12(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_MIDDLE_PRINT_NEXT

	# Value retrieval: pppPtr[counter1][counter2][counter3]
	movl	-16(%ebp), %eax		# eax = counter1
	movl	-28(%ebp), %ebx		# ebx = pppPtr
	movl	(%ebx, %eax, 4), %ebx	# ebx = pppPtr[counter1]
	movl	-20(%ebp), %edx		# edx = counter2
	movl	(%ebx, %edx, 4), %ebx	# ebx = pppPtr[counter1][counter2]
	movl	-24(%ebp), %ecx		# ecx = counter3
	movl	(%ebx, %ecx, 4), %esi	# esi = value of pppPtr[counter1][counter2][counter3]

	# printf("[%d][%d][%d] value is:\t%d\n", counter1, counter2, counter3, val);
	movl	-24(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	-16(%ebp), %ecx
	pushl	%esi
	pushl	%eax
	pushl	%edx
	pushl	%ecx
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

LABEL_FREE_SECTION:
	# for(counter1 = 0; counter1 < x; counter1++)
	movl	$0, -16(%ebp)

LABEL_FREE_OUTER_LOOP:
	movl	-16(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_FREE_PTR_ARRAY

	# for(counter2 = 0; counter2 < y; counter2++)
	movl	$0, -20(%ebp)

LABEL_FREE_MIDDLE_LOOP:
	movl	-20(%ebp), %eax
	movl	-8(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_FREE_OUTER_NEXT

	# free(pppPtr[counter1][counter2]);
	movl	-16(%ebp), %eax
	movl	-28(%ebp), %ebx
	movl	(%ebx, %eax, 4), %ebx	# ebx = pppPtr[counter1]
	movl	-20(%ebp), %edx
	movl	(%ebx, %edx, 4), %ecx	# ecx = pppPtr[counter1][counter2]
	pushl	%ecx
	call	free
	addl	$4, %esp

	# counter2++
	addl	$1, -20(%ebp)
	jmp		LABEL_FREE_MIDDLE_LOOP

LABEL_FREE_OUTER_NEXT:
	# free(pppPtr[counter1]);
	movl	-16(%ebp), %eax
	movl	-28(%ebp), %ebx
	movl	(%ebx, %eax, 4), %edx
	pushl	%edx
	call	free
	addl	$4, %esp

	# counter1++
	addl	$1, -16(%ebp)
	jmp		LABEL_FREE_OUTER_LOOP

LABEL_FREE_PTR_ARRAY:
	# free(pppPtr);
	movl	-28(%ebp), %ebx
	pushl	%ebx
	call	free
	addl	$4, %esp

	# pppPtr = NULL;
	movl	$0, -28(%ebp)

	# exit(0);
	pushl	$0
	call	exit

LABEL_EXIT:
	pushl	$-1
	call	exit
