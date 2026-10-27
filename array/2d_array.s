.section .rodata
	msg_main_print_int:
	.string "%p\n"

.section .text;
.globl	main
.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp

	subl	$48, %esp # 3 rows x 4 col

	# printf("%d\n", arr)
	leal	-48(%ebp), %eax
	pushl	%eax
	pushl	$msg_main_print_int
	call	printf
	addl	$8, %esp

	# printf("%d\n", &arr[2][3])
	movl	$4, %eax  				# 4 : number of col
	movl	$2, %ecx				# 2 : row to access
	mul		%ecx					# 8 : elements in 2 rows
	movl	$4, %ecx 				# 4 : size of int
	mul		%ecx					# 32: offset of ar[2][0]
	movl	$3, %ecx				# 3 : col to access
	leal	-48(%ebp), %ebx
	addl	%ebx, %eax

	leal	(%eax, %ecx, 4), %ebx
	pushl	%ebx
	pushl	$msg_main_print_int
	call 	printf
	addl	$8, %esp

	#printf("Enter arr[%d][%d] : ", 2, 3);
	


	pushl	$0
	call	exit


