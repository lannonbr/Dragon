	.file	"simp_proc.c"
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	print_plus_one
	.type	print_plus_one, @function
print_plus_one:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	nop
	leave
	ret
	.size	print_plus_one, .-print_plus_one
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$20, %edi
	call	print_plus_one
	movl	$0, %eax
	popq	%rbp
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 6.3.1 20170306"
	.section	.note.GNU-stack,"",@progbits
