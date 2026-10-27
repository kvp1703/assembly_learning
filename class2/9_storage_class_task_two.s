.section .rodata
	msg_fun1_1:
	.string "Enter a number:\t"

	msg_fun1_2:
	.string "%d"

	msg_fun1_3:
	.string "In fun1, no1 is %d and no2 is %d\n"

	msg_fun2_1:
	.string "In static fun2"

.section .bss
	.lcomm no1, 4, 4

.section .data
	.type  no2, @object
	.size  no2, 4
	.align 4
	no2:
		.int 40


.section .text
	.globl fun1
	.type fun1, @function
	fun1:
		pushl %ebp
		movl  %esp, %ebp

		pushl $msg_fun1_1
		call  printf
		addl  $4, %esp

		pushl $no1 #push ADDRESS of no1 second
		pushl $msg_fun1_2
		call  scanf
		addl  $8, %esp

		pushl no2
		pushl no1
		pushl $msg_fun1_3
		call  printf
		addl  $12, %esp

		call  fun2

		movl %ebp, %esp
		popl %ebp
		ret

	.type fun2, @function
	fun2:
		pushl %ebp
		movl  %esp, %ebp

		pushl $msg_fun2_1
		call printf
		add $4, %esp

		movl %ebp, %esp
		popl %ebp
		ret

