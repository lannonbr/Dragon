	.section .rodata
.LC0:
	.string "%d\n"
.LC1:
	.string "%d"
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	$2, %rax
	imul	$10, %rax
	movq	%rax, -12(%rbp)
	movq	-12(%rbp), %rax
	movq	%rax, %rsi
	movq	$.LC0, %rdi
	movq	$0, %rax
	call	printf
	movq	$2, %rax
	movq	$5, %rax
	sub	$3, %rax
	imul	%rax, %rax
	add	$7, %rax
	movq	%rax, -12(%rbp)
	movq	-12(%rbp), %rax
	movq	%rax, %rsi
	movq	$.LC0, %rdi
	movq	$0, %rax
	call	printf
	movq	$0, %rax
	leave
	ret
