.section .rodata

	msg_main_1:
	.string "Global variable b from another file: %d\n"

	msg_fun_1:
	.string "Hello from fun()\n";

.section .bss
	.comm g, 4, 4

.section .text

	.globl main
	.type main, @function
	main:
		pushl %ebp
		movl %esp, %ebp

		call fun

		pushl g
		pushl $msg_main_1
		call printf
		addl $8, %esp

		pushl $0
		call exit


	.globl fun
	.type fun, @function
	fun:
		pushl %ebp
		movl  %esp, %ebp

		movl $7, g

		pushl $msg_fun_1
		call  printf
		addl  $4, %esp

		movl  %ebp, %esp
		popl  %ebp
		ret

