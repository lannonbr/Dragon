	.file	"empty.c"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp ; Push base pointer
	movq	%rsp, %rbp ; move stack pointer
	movl	$0, %eax ; put return value of main into %eax
	popq	%rbp ; pop the base pointer
	ret ; return
	.size	main, .-main
	.ident	"GCC: (GNU) 6.3.1 20170306"
	.section	.note.GNU-stack,"",@progbits
