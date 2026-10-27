.section .rodata

	msg_main_1:
	.string "global variable g before initialization: %d\n"

	msg_main_2:
	.string "global variable g after initialization: %d\n"


.section .bss

	.comm g, 4, 4

.section .text

	.globl main
	.type main, @function
	main:
		pushl %ebp
		movl  %esp, %ebp

		pushl g
		pushl $msg_main_1
		call printf
		addl $8, %esp

		movl $9, g

		pushl g
		pushl $msg_main_2
		call printf
		addl $8, %esp

		pushl $0
		call exit
