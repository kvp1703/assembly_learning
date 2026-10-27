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
	addl	$3, %eax				# 11 : elemets to skip

	leal	-48(%ebp), %ebx

	leal	(%ebx, %eax, 4), %ebx
	pushl	%ebx
	pushl	$msg_main_print_int
	call 	printf
	addl	$8, %esp

#	movl	$4, %ecx  				# 4 : number of col
#	movl	$4, %eax 				# 4 : size of int
#	mul		%ecx					# 16: size of 1D array
#	movl 	$2, %ecx				# 2 : row to access
#	movl	-48(%ebp), %ebx			# addr of ar[0][0] / ar
#
#	leal	(%ebx, %ecx, %eax), %edx # Addr of ar[2][0]
#
#	movl	$3, %ecx				# 3 : col to access
#	movl	$4, %eax				# 4 : size of 
#
#	leal	(%edx, %ecx, %eax), %ebx
#
#	pushl	%ebx
#	pushl	$msg_main_print_int
#	call 	printf
#	addl	$8, %esp

	pushl	$0
	call	exit


