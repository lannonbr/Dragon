	.file	"empty_procedure.c"
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	foo
	.type	foo, @function
foo:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$7, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	popq	%rbp
	ret
	.size	foo, .-foo
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$0, %eax
	call	foo
	popq	%rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
