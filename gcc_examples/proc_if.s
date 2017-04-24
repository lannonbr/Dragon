	.file	"proc_if.c"
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	foo
	.type	foo, @function
foo:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movl	$20, -4(%rbp)
	cmpl	$20, -4(%rbp)
	jne	.L1
	movl	$0, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
.L1:
	leave
	ret
	.size	foo, .-foo
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movl	$52, -4(%rbp)
	movl	$11, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	call	foo
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
