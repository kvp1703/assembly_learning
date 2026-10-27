.section .rodata
	msg_main_1:
	.string "no1: %d\nno2: %d\nno3: %d\n ans: %d"

.section .text
	.globl main
	.type main, @function
	main:
		pushl	%ebp
		movl	%esp, %ebp

		pushl	$10
		pushl	$20
		pushl	$30
		subl	$4, %esp

		#no1 && ++no2 && ++no3;

		movl	-4(%ebp), %eax
		movl	-8(%ebp), %edx
		movl	-12(%ebp), %ecx
		movl	$1, %ebx

		cmpl	$0, %eax
		je		label_false

		addl	$1, %edx		    #no2 will always be greater than 1
		cmpl	$0, %edx			#Hence this is always "not equal"
		jne		label_cmp_2

label_false:
		movl	$0, %ebx

label_cmp_2:

		cmpl	$0, %ebx
		je 		label_print
		
		addl	$1, %ecx			#no3 will always be greater than 1
		cmpl	$0, %ecx			#Hence this is always "not equal"
		jne   	label_print
		movl	$0, %ebx

label_print:

		pushl	%ebx
		pushl	%ecx				
		pushl	%edx				
		pushl	%eax				
		pushl	$msg_main_1
		call	printf
		addl	$20, %esp

		pushl 	$0
		call	exit
