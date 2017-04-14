	.file	"if.c"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$40, -4(%rbp)
	movl	$2, -8(%rbp)
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jle	.L2
	movl	$20, -12(%rbp)
	movl	$0, %eax
	jmp	.L3
.L2:
	movl	$1, %eax
.L3:
	popq	%rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
