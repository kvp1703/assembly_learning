.section .rodata
	msg_main_1:
	.string "%d\n"

.section .text
	.globl main
	.type main, @function
	main:
		push %ebp
		movl %esp, %ebp

		pushl $10

		pushl  $-100
		pushl $msg_main_1
		call  printf
		addl  $8, %esp

		pushl -4(%ebp)
		pushl $msg_main_1
		call  printf
		addl  $8, %esp

		movl  -4(%ebp), %ebx     
		movl  $0, %eax
		subl  %ebx, %eax        # 0 - no = -no
		pushl %eax
		pushl $msg_main_1
		call  printf
		addl  $8, %esp

		negl  -4(%ebp)
		pushl -4(%ebp)
		pushl $msg_main_1
		call  printf
		addl  $8, %esp

		pushl $0
		call  exit

