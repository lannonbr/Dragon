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
	movq	%rax, -12(%rbp)
	movq	$1, %rax
	movq	%rax, -16(%rbp)
	movq	-12(%rbp), %rax
	cmp	-16(%rbp), %rax
	jle .L2
	movq	$7, %rax
	movq	%rax, %rsi
	movq	$.LC0, %rdi
	movq	$0, %rax
	call	printf
	jmp .L3
.L2:
	movq	$0, %rax
	movq	%rax, %rsi
	movq	$.LC0, %rdi
	movq	$0, %rax
	call	printf
.L3:
	movq	$100, %rax
	movq	%rax, %rsi
	movq	$.LC0, %rdi
	movq	$0, %rax
	call	printf
	movq	$0, %rax
	leave
	ret
