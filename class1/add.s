.section .rodata
		msg_main_print1:
		.string "Enter two numbers:\t"
		
		msg_main_scan:
		.string "%d%d"
		
		msg_main_print2:
		.string "Answer is %d\n"
		
.section .text
.globl main
.type main, @function
main:
		pushl        %ebp
		movl         %esp, %ebp
		
		subl         $12, %esp #Space for num1, num2, result
		
		pushl        $msg_main_print1
		call         printf
		addl         $4, %esp
		
		leal         -4(%ebp), %eax # Loads the ADDRESS of the 1st local to pass to scanf
		leal         -8(%ebp), %edx # Loads the ADDRESS of the 2nd local to pass to scanf
		pushl        %edx # Push second address
		pushl        %eax # Push first address
		pushl        $msg_main_scan # Push address of format string
		call         scanf
		addl         $12, %esp # Remove the 3 addresses
		
		movl         -4(%ebp), %eax
		movl         -8(%ebp), %edx
		pushl        %edx
		pushl        %eax
		call         addition
		addl         $8, %esp
		
		movl         %eax, -12(%ebp)
		
		pushl        %eax
		pushl        $msg_main_print2
		call         printf
		addl         $8, %esp
		
		pushl        $0
		call         exit
		
		
.globl addition
.type   addition, @function
addition:
		pushl        %ebp
		movl         %esp, %ebp
		
		subl         $4, %esp
		movl         8(%ebp), %eax
		movl         12(%ebp), %edx
		addl         %edx, %eax
		
		movl         %eax, -4(%ebp)
		
		movl         %ebp, %esp
		popl         %ebp
		ret
