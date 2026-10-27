.section .rodata
	msg_main_req_rows_cols:
	.string "Enter value of rows & columns:\t"

	msg_main_scan_two_int:
	.string "%d%d"
    
	msg_main_malloc_fail:
	.string "Memory allocation FAILED"

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

	# Allocate space for local variables
	# -4(%ebp)  = rows
	# -8(%ebp)  = columns
	# -12(%ebp) = counter1
	# -16(%ebp) = counter2
	# -20(%ebp) = ppPtr
	subl	$24, %esp

	# printf("Enter value of rows & columns:\t");
	pushl	$msg_main_req_rows_cols
	call	printf
	addl	$4, %esp

	# scanf("%d%d", &rows, &columns);
	leal	-8(%ebp), %eax
	leal	-4(%ebp), %edx
	pushl	%eax
	pushl	%edx
	pushl	$msg_main_scan_two_int
	call	scanf
	addl	$12, %esp

	# ppPtr = (int **) malloc (rows * sizeof(int *));
	movl	-4(%ebp), %eax		# eax = rows
	movl	$4, %edx			# edx = 4 (size of int pointer)
	mull	%edx				# eax = eax * edx
	pushl	%eax
	call	malloc
	addl	$4, %esp
	movl	%eax, -20(%ebp)		# Store base address in ppPtr
	
	# if(NULL == ppPtr)
	cmpl	$0, -20(%ebp)
	jne		LABEL_ALLOC1_SUCCESS
	pushl	$msg_main_malloc_fail
	call	puts
	addl	$4, %esp
	jmp		LABEL_EXIT
    
LABEL_ALLOC1_SUCCESS:
	# for(counter1 = 0; counter1 < rows; counter1++)
	movl	$0, -12(%ebp)

LABEL_OUTER_INPUT_LOOP:
	movl	-12(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_PRINT_SECTION

	# ppPtr[counter1] = (int *) malloc (columns * sizeof(int));
	movl	-8(%ebp), %eax		# eax = columns
	movl	$4, %edx			# edx = 4 (size of int)
	mull	%edx				# eax = eax * edx
	pushl	%eax
	call	malloc
	addl	$4, %esp
	
	# store the malloced address in ppPtr[counter1]
	movl	-12(%ebp), %edx		# edx = counter1
	movl	-20(%ebp), %ebx		# ebx = ppPtr
	movl	%eax, (%ebx, %edx, 4)

	# if(NULL == ppPtr[counter1])
	cmpl	$0, (%ebx, %edx, 4)
	jne		LABEL_ALLOC2_SUCCESS
	pushl	$msg_main_malloc_fail
	call	puts
	addl	$4, %esp
	jmp		LABEL_EXIT

LABEL_ALLOC2_SUCCESS:
	# for(counter2 = 0; counter2 < columns; counter2++)
	movl	$0, -16(%ebp)

LABEL_INNER_INPUT_LOOP:
	movl	-16(%ebp), %eax
	movl	-8(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_OUTER_INPUT_NEXT

	# printf("Enter [%d][%d] value:\t", counter1, counter2);
	movl	-16(%ebp), %eax
	movl	-12(%ebp), %edx
	pushl	%eax
	pushl	%edx
	pushl	$msg_main_req_element
	call	printf
	addl	$12, %esp

	# scanf("%d", &ppPtr[counter1][counter2]);
	# Address Calculation: &ppPtr[counter1][counter2]
	movl	-12(%ebp), %eax		# eax = counter1
	movl	-20(%ebp), %ebx		# ebx = base addr ppPtr
	movl	(%ebx, %eax, 4), %ebx	# ebx = addr ppPtr[counter1]
	movl	-16(%ebp), %edx		# edx = counter2
	leal	(%ebx, %edx, 4), %ebx	# ebx = &ppPtr[counter1][counter2]

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

	# for(counter1 = 0; ...)
	movl	$0, -12(%ebp)

LABEL_OUTER_PRINT_LOOP:
	movl	-12(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_FREE_SECTION

	# for(counter2 = 0; ...)
	movl	$0, -16(%ebp)

LABEL_INNER_PRINT_LOOP:
	movl	-16(%ebp), %eax
	movl	-8(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_OUTER_PRINT_NEXT

	# Value retrieval: ppPtr[counter1][counter2]
	movl	-12(%ebp), %eax		# eax = counter1
	movl	-20(%ebp), %ebx		# ebx = ppPtr
	movl	(%ebx, %eax, 4), %ebx	# ebx = ppPtr[counter1]
	movl	-16(%ebp), %edx		# edx = counter2
	movl	(%ebx, %edx, 4), %ecx	# ecx = ppPtr[counter1][counter2] value

	# printf("[%d][%d] value is:\t%d\n", counter1, counter2, value);
	movl	-12(%ebp), %eax		# restore counter1 to push
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

LABEL_FREE_SECTION:
	# for(counter1 = 0; counter1 < rows; counter1++)
	movl	$0, -12(%ebp)

LABEL_FREE_LOOP:
	movl	-12(%ebp), %eax
	movl	-4(%ebp), %edx
	cmpl	%edx, %eax
	jge		LABEL_FREE_PTR

	# free(ppPtr[counter1]);
	movl	-12(%ebp), %eax
	movl	-20(%ebp), %ebx		# ebx used for base address ppPtr
	movl	(%ebx, %eax, 4), %edx	# edx = ppPtr[counter1]
	pushl	%edx
	call	free
	addl	$4, %esp

	# ppPtr[counter1] = NULL;
	movl	-12(%ebp), %eax
	movl	-20(%ebp), %ebx
	movl	$0, (%ebx, %eax, 4)

	# counter1++
	addl	$1, -12(%ebp)
	jmp		LABEL_FREE_LOOP

LABEL_FREE_PTR:
	# free(ppPtr);
	movl	-20(%ebp), %ebx		
	pushl	%ebx
	call	free
	addl	$4, %esp

	# ppPtr = NULL;
	movl	$0, -20(%ebp)

	# exit(0);
	pushl	$0
	call	exit

LABEL_EXIT:
	pushl	$-1
	call	exit

