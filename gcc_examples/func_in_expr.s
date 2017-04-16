	.file	"func_in_expr.c"
	.text
	.globl	foo
	.type	foo, @function
foo:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	addl	$1, %eax
	popq	%rbp
	ret
	.size	foo, .-foo
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$16, %rsp
	movl	$6, %edi
	call	foo
	leal	(%rax,%rax), %ebx
	movl	$6, %edi
	call	foo
	movl	%eax, %edi
	call	foo
	movl	%eax, %ecx
	movl	$42, %eax
	cltd
	idivl	%ecx
	addl	%ebx, %eax
	movl	%eax, -12(%rbp)
	addq	$16, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
