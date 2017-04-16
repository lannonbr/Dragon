	.file	"factorial.c"
	.text
	.globl	fact
	.type	fact, @function
fact:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	%edi, -20(%rbp)
	movl	$1, -4(%rbp)
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
	subl	$1, -20(%rbp)
.L2:
	cmpl	$0, -20(%rbp)
	jg	.L3
	movl	-4(%rbp), %eax
	popq	%rbp
	ret
	.size	fact, .-fact
	.section	.rodata
	.align 8
.LC0:
	.string	"Enter a number for factorial: "
.LC1:
	.string	"%d"
.LC2:
	.string	"The factorial of %d is %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	leaq	-8(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	movl	-8(%rbp), %eax
	movl	%eax, %edi
	call	fact
	movl	%eax, -4(%rbp)
	movl	-8(%rbp), %eax
	movl	-4(%rbp), %edx
	movl	%eax, %esi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
