.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	$10, %rax
	movq	%rax, -8(%rbp)
	movq	$0, %rax
	popq	%rbp
	ret
