.section .rodata

	msg_main_p1:
	.string "Here is the globally initialized number: %d" 


.section .data

	.globl g
	.type  g, @object
	.size  g, 4
	.align 4
	g:
		.int 10


.section .text

	.globl main
	.type main, @function
	main:
		pushl %ebp
		movl  %esp, %ebp

		movl  g, %eax
		pushl %eax 
		pushl $msg_main_p1
		call  printf
		addl  $8, %esp #No need as we will return.

		pushl $0
		call  exit


