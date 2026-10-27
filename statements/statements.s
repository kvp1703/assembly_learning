.section .rodata
	msg_main_menu:
	.string "\n1.Addition\n2.Subtraction\n3.Division\n4.Multiplication\n5.Exit\n"

	msg_main_choise_req:
	.string "Enter your choice: "

	msg_main_choice_input:
	.string "%d"

	msg_main_num_req:
	.string "Enter two numbers: "

	msg_main_num_input:
	.string "%d%d"

	msg_main_default:
	.string "Enter valid choice\n"

	msg_main_print_ans:
	.string "Answer is %d\n\n"

	msg_main_want_exit:
	.string "Do you want to continue (0/1)? "

.section .text
.globl	main
.type	main, @function
	main:
	pushl	%ebp
	movl	%esp, %ebp

	subl	$16, %esp

label_do_while_loop:
# IO begin
	pushl	$msg_main_menu
	call	printf
	addl	$4, %esp

	pushl	$msg_main_choise_req
	call	printf
	addl	$4, %esp

	leal 	-16(%ebp), %eax
	pushl	%eax
	pushl	$msg_main_choice_input
	call	scanf
	addl	$8, %esp

	movl	-16(%ebp), %eax
	cmpl	$0, %eax
	jle		label_switch_cases
	cmpl	$5, %eax
	jge		label_switch_cases

	pushl	$msg_main_num_req
	call	printf
	addl	$4, %esp

	leal 	-4(%ebp), %edx
	leal 	-8(%ebp), %ecx
	pushl	%ecx
	pushl	%edx
	pushl	$msg_main_num_input
	call 	scanf
	addl 	$12, %esp

# IO end

label_switch_cases:
	movl	-16(%ebp), %eax
	cmpl	$1, %eax
	je 		label_addition
	cmpl	$2, %eax
	je 		label_subtraction
	cmpl	$3, %eax
	je 		label_division
	cmpl	$4, %eax
	je 		label_multiplication
	cmpl	$5, %eax
	je 		label_exit
	jmp		label_default

label_addition:
	pushl	-8(%ebp)            ####### Push into register first ########
	pushl	-4(%ebp)
	call	Addition
	addl	$8, %esp
	movl	%eax, -12(%ebp)
	jmp 	label_print_ans

label_subtraction:
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	call	Subtraction
	addl	$8, %esp
	movl	%eax, -12(%ebp)
	jmp 	label_print_ans

label_division:
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	call	Division
	addl	$8, %esp
	movl	%eax, -12(%ebp)
	jmp 	label_print_ans

label_multiplication:
	pushl	-8(%ebp)
	pushl	-4(%ebp)
	call	Multiplication
	addl	$8, %esp
	movl	%eax, -12(%ebp)
	jmp 	label_print_ans

label_default:
	pushl	msg_main_default
	call 	printf
	addl	$4, %esp
	movl	$1, -4(%ebp)
	jmp 	label_do_while_loop

label_print_ans:
	pushl	-12(%ebp)
	pushl 	$msg_main_print_ans
	call	printf
	addl	$8, %esp

	pushl	$msg_main_want_exit
	call 	printf
	addl	$4, %esp

	leal 	-16(%ebp), %eax
	pushl	%eax
	pushl	$msg_main_choice_input
	call	scanf
	addl 	$8, %esp

	cmpl	$1, -16(%ebp)
	je		label_do_while_loop

label_exit:
	pushl	$0
	call 	exit

.globl	Addition
.type	Addition, @function
Addition:
	pushl	%ebp
	movl	%esp, %ebp

	movl	8(%ebp), %eax
	movl	12(%ebp), %edx
	addl	%edx, %eax

	movl	%ebp, %esp
	popl	%ebp
	ret

.globl	Subtraction
.type	Subtraction, @function
Subtraction:
	pushl	%ebp
	movl	%esp, %ebp

	movl	8(%ebp), %eax
	movl	12(%ebp), %edx
	subl	%edx, %eax

	movl	%ebp, %esp
	popl	%ebp
	ret

.globl	Division
.type	Division, @function
Division:
	pushl	%ebp
	movl	%esp, %ebp

	movl	8(%ebp), %eax   #LSB
	movl	12(%ebp), %ecx
	movl	$0, %edx		#MSB ########### Prefer XOR ########

	divl	%ecx

	movl	%ebp, %esp
	popl	%ebp
	ret

.globl	Multiplication
.type	Multiplication, @function
Multiplication:
	pushl	%ebp
	movl	%esp, %ebp

	movl	8(%ebp), %eax
	movl	12(%ebp), %ecx

	mul	%ecx

	movl	%ebp, %esp
	popl	%ebp
	ret
	