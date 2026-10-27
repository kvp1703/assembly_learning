.section .rodata
	msg_main_1:
	.string "Enter two numbers:\t"

	msg_main_2:
	.string "%d%d"

	msg_main_3:
	.string "In main, %d, %d, %d\n"

.section .bss
	.comm no2, 4, 4

.section .data
	.globl no1
	.type  no1, @object
	.size  no1, 4
	.align 4
	no1:
		.int 1


.section .text
	.globl main
	.type main, @function
	main:
		pushl %ebp
		movl  %esp, %ebp

		subl  $4, %esp

		pushl $msg_main_1
		call  printf
		addl  $4, %esp

		leal  -4(%ebp), %eax # Loads the ADDRESS of no3
		pushl %eax # Push ADDRESS of no3 first
		pushl $no2 #push address of no2 second
		pushl $msg_main_2
		call  scanf
		addl  $12, %esp

		movl  -4(%ebp), %eax
		pushl %eax
		pushl no2
		pushl no1
		pushl $msg_main_3
		call  printf
		addl  $16, %esp

		call  fun1

		pushl $0
		call exit
