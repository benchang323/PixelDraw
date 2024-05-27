	.file	"test_drawing_funcs.c"
	.text
	.globl	setup
	.type	setup, @function
setup:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$80, %edi
	call	malloc
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$6, %edx
	movl	$8, %esi
	movq	%rax, %rdi
	call	init_image
	movq	-8(%rbp), %rax
	addq	$16, %rax
	movl	$20, %edx
	movl	$24, %esi
	movq	%rax, %rdi
	call	init_image
	movq	-8(%rbp), %rax
	addq	$64, %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	init_image
	movq	-8(%rbp), %rax
	movq	$0, 40(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 56(%rax)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	setup, .-setup
	.globl	cleanup
	.type	cleanup, @function
cleanup:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rdi
	call	free
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, %rdi
	call	free
	movq	-8(%rbp), %rax
	movq	40(%rax), %rax
	movq	%rax, %rdi
	call	free
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, %rdi
	call	free
	movq	-8(%rbp), %rax
	movq	72(%rax), %rax
	movq	%rax, %rdi
	call	free
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	cleanup, .-cleanup
	.section	.rodata
.LC0:
	.string	"test_drawing_funcs.c"
.LC1:
	.string	"colors[i].c != 0"
	.text
	.globl	lookup_color
	.type	lookup_color, @function
lookup_color:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, %eax
	movq	%rsi, -32(%rbp)
	movb	%al, -20(%rbp)
	movl	$0, -4(%rbp)
.L8:
	movl	-4(%rbp), %eax
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L5
	movl	$__PRETTY_FUNCTION__.1, %ecx
	movl	$74, %edx
	movl	$.LC0, %esi
	movl	$.LC1, %edi
	call	__assert_fail
.L5:
	movl	-4(%rbp), %eax
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	%al, -20(%rbp)
	jne	.L6
	movl	-4(%rbp), %eax
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	4(%rax), %eax
	jmp	.L9
.L6:
	addl	$1, -4(%rbp)
	jmp	.L8
.L9:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	lookup_color, .-lookup_color
	.section	.rodata
.LC2:
	.string	"strlen(p->pic) == num_pixels"
	.align 8
.LC3:
	.string	"actual_color == expected_color"
.LC4:
	.string	"failed ASSERT %s at line %d\n"
	.text
	.globl	check_picture
	.type	check_picture, @function
check_picture:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	-40(%rbp), %rax
	movl	(%rax), %edx
	movq	-40(%rbp), %rax
	movl	4(%rax), %eax
	imull	%edx, %eax
	movl	%eax, -8(%rbp)
	movq	-48(%rbp), %rax
	movq	160(%rax), %rax
	movq	%rax, %rdi
	call	strlen
	movq	%rax, %rdx
	movl	-8(%rbp), %eax
	cmpq	%rax, %rdx
	je	.L11
	movl	$__PRETTY_FUNCTION__.0, %ecx
	movl	$85, %edx
	movl	$.LC0, %esi
	movl	$.LC2, %edi
	call	__assert_fail
.L11:
	movl	$0, -4(%rbp)
	jmp	.L12
.L14:
	movq	-48(%rbp), %rax
	movq	160(%rax), %rdx
	movl	-4(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -9(%rbp)
	movq	-48(%rbp), %rdx
	movsbl	-9(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	lookup_color
	movl	%eax, -16(%rbp)
	movq	-40(%rbp), %rax
	movq	8(%rax), %rax
	movl	-4(%rbp), %edx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -20(%rbp)
	movl	$92, tctest_assertion_line(%rip)
	movl	-20(%rbp), %eax
	cmpl	-16(%rbp), %eax
	je	.L13
	movl	$92, %edx
	movl	$.LC3, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L13:
	addl	$1, -4(%rbp)
.L12:
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jb	.L14
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	check_picture, .-check_picture
	.section	.rodata
.LC5:
	.string	"test_blend_colors"
.LC6:
	.string	"%s..."
.LC7:
	.string	"passed!"
.LC8:
	.string	"test_draw_pixel"
.LC9:
	.string	"test_draw_rect"
.LC10:
	.string	"test_draw_circle"
.LC11:
	.string	"test_draw_circle_clip"
.LC12:
	.string	"test_draw_tile"
.LC13:
	.string	"test_draw_sprite"
.LC14:
	.string	"test_get_r"
.LC15:
	.string	"test_get_g"
.LC16:
	.string	"test_get_b"
.LC17:
	.string	"test_get_a"
.LC18:
	.string	"test_square"
.LC19:
	.string	"test_in_bounds"
.LC20:
	.string	"test_compute_index"
.LC21:
	.string	"test_check_rect_bounds"
.LC22:
	.string	"test_blend_components"
.LC23:
	.string	"test_draw_rect_2"
.LC24:
	.string	"test_draw_rect_3"
.LC25:
	.string	"test_draw_pixel_2"
.LC26:
	.string	"All tests passed!"
.LC27:
	.string	"%d test(s) failed\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$176, %rsp
	movl	%edi, -164(%rbp)
	movq	%rsi, -176(%rbp)
	cmpl	$1, -164(%rbp)
	jle	.L16
	movq	-176(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, tctest_testname_to_execute(%rip)
.L16:
	call	tctest_register_signal_handlers
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L17
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC5, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L18
.L17:
	movq	$0, -8(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L20
	call	setup
	movq	%rax, -8(%rbp)
	movl	$.LC5, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	test_blend_colors
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L21
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC5, %edi
	call	*%rax
	jmp	.L21
.L20:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L21
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC5, %edi
	call	*%rax
.L21:
	cmpq	$0, -8(%rbp)
	je	.L18
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L18:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L22
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC8, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L23
.L22:
	movq	$0, -16(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L24
	call	setup
	movq	%rax, -16(%rbp)
	movl	$.LC8, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	test_draw_pixel
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L25
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC8, %edi
	call	*%rax
	jmp	.L25
.L24:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L25
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC8, %edi
	call	*%rax
.L25:
	cmpq	$0, -16(%rbp)
	je	.L23
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L23:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L26
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC9, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L27
.L26:
	movq	$0, -24(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L28
	call	setup
	movq	%rax, -24(%rbp)
	movl	$.LC9, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	test_draw_rect
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L29
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC9, %edi
	call	*%rax
	jmp	.L29
.L28:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L29
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC9, %edi
	call	*%rax
.L29:
	cmpq	$0, -24(%rbp)
	je	.L27
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L27:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L30
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC10, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L31
.L30:
	movq	$0, -32(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L32
	call	setup
	movq	%rax, -32(%rbp)
	movl	$.LC10, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	test_draw_circle
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L33
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC10, %edi
	call	*%rax
	jmp	.L33
.L32:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L33
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC10, %edi
	call	*%rax
.L33:
	cmpq	$0, -32(%rbp)
	je	.L31
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L31:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L34
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC11, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L35
.L34:
	movq	$0, -40(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L36
	call	setup
	movq	%rax, -40(%rbp)
	movl	$.LC11, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	test_draw_circle_clip
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L37
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC11, %edi
	call	*%rax
	jmp	.L37
.L36:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L37
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC11, %edi
	call	*%rax
.L37:
	cmpq	$0, -40(%rbp)
	je	.L35
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L35:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L38
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC12, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L39
.L38:
	movq	$0, -48(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L40
	call	setup
	movq	%rax, -48(%rbp)
	movl	$.LC12, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	test_draw_tile
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L41
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC12, %edi
	call	*%rax
	jmp	.L41
.L40:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L41
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC12, %edi
	call	*%rax
.L41:
	cmpq	$0, -48(%rbp)
	je	.L39
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L39:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L42
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC13, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L43
.L42:
	movq	$0, -56(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L44
	call	setup
	movq	%rax, -56(%rbp)
	movl	$.LC13, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	test_draw_sprite
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L45
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC13, %edi
	call	*%rax
	jmp	.L45
.L44:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L45
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC13, %edi
	call	*%rax
.L45:
	cmpq	$0, -56(%rbp)
	je	.L43
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L43:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L46
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC14, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L47
.L46:
	movq	$0, -64(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L48
	call	setup
	movq	%rax, -64(%rbp)
	movl	$.LC14, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	test_get_r
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L49
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC14, %edi
	call	*%rax
	jmp	.L49
.L48:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L49
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC14, %edi
	call	*%rax
.L49:
	cmpq	$0, -64(%rbp)
	je	.L47
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L47:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L50
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC15, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L51
.L50:
	movq	$0, -72(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L52
	call	setup
	movq	%rax, -72(%rbp)
	movl	$.LC15, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	test_get_g
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L53
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC15, %edi
	call	*%rax
	jmp	.L53
.L52:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L53
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC15, %edi
	call	*%rax
.L53:
	cmpq	$0, -72(%rbp)
	je	.L51
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L51:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L54
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC16, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L55
.L54:
	movq	$0, -80(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L56
	call	setup
	movq	%rax, -80(%rbp)
	movl	$.LC16, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	test_get_b
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L57
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC16, %edi
	call	*%rax
	jmp	.L57
.L56:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L57
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC16, %edi
	call	*%rax
.L57:
	cmpq	$0, -80(%rbp)
	je	.L55
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L55:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L58
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC17, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L59
.L58:
	movq	$0, -88(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L60
	call	setup
	movq	%rax, -88(%rbp)
	movl	$.LC17, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-88(%rbp), %rax
	movq	%rax, %rdi
	call	test_get_a
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L61
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC17, %edi
	call	*%rax
	jmp	.L61
.L60:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L61
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC17, %edi
	call	*%rax
.L61:
	cmpq	$0, -88(%rbp)
	je	.L59
	movq	-88(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L59:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L62
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC18, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L63
.L62:
	movq	$0, -96(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L64
	call	setup
	movq	%rax, -96(%rbp)
	movl	$.LC18, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	test_square
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L65
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC18, %edi
	call	*%rax
	jmp	.L65
.L64:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L65
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC18, %edi
	call	*%rax
.L65:
	cmpq	$0, -96(%rbp)
	je	.L63
	movq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L63:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L66
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC19, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L67
.L66:
	movq	$0, -104(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L68
	call	setup
	movq	%rax, -104(%rbp)
	movl	$.LC19, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-104(%rbp), %rax
	movq	%rax, %rdi
	call	test_in_bounds
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L69
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC19, %edi
	call	*%rax
	jmp	.L69
.L68:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L69
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC19, %edi
	call	*%rax
.L69:
	cmpq	$0, -104(%rbp)
	je	.L67
	movq	-104(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L67:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L70
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC20, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L71
.L70:
	movq	$0, -112(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L72
	call	setup
	movq	%rax, -112(%rbp)
	movl	$.LC20, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	test_compute_index
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L73
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC20, %edi
	call	*%rax
	jmp	.L73
.L72:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L73
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC20, %edi
	call	*%rax
.L73:
	cmpq	$0, -112(%rbp)
	je	.L71
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L71:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L74
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC21, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L75
.L74:
	movq	$0, -120(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L76
	call	setup
	movq	%rax, -120(%rbp)
	movl	$.LC21, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-120(%rbp), %rax
	movq	%rax, %rdi
	call	test_check_rect_bounds
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L77
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC21, %edi
	call	*%rax
	jmp	.L77
.L76:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L77
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC21, %edi
	call	*%rax
.L77:
	cmpq	$0, -120(%rbp)
	je	.L75
	movq	-120(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L75:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L78
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC22, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L79
.L78:
	movq	$0, -128(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L80
	call	setup
	movq	%rax, -128(%rbp)
	movl	$.LC22, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	test_blend_components
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L81
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC22, %edi
	call	*%rax
	jmp	.L81
.L80:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L81
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC22, %edi
	call	*%rax
.L81:
	cmpq	$0, -128(%rbp)
	je	.L79
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L79:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L82
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC23, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L83
.L82:
	movq	$0, -136(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L84
	call	setup
	movq	%rax, -136(%rbp)
	movl	$.LC23, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-136(%rbp), %rax
	movq	%rax, %rdi
	call	test_draw_rect_2
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L85
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC23, %edi
	call	*%rax
	jmp	.L85
.L84:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L85
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC23, %edi
	call	*%rax
.L85:
	cmpq	$0, -136(%rbp)
	je	.L83
	movq	-136(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L83:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L86
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC24, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L87
.L86:
	movq	$0, -144(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L88
	call	setup
	movq	%rax, -144(%rbp)
	movl	$.LC24, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-144(%rbp), %rax
	movq	%rax, %rdi
	call	test_draw_rect_3
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L89
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC24, %edi
	call	*%rax
	jmp	.L89
.L88:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L89
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC24, %edi
	call	*%rax
.L89:
	cmpq	$0, -144(%rbp)
	je	.L87
	movq	-144(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L87:
	movq	tctest_testname_to_execute(%rip), %rax
	testq	%rax, %rax
	je	.L90
	movq	tctest_testname_to_execute(%rip), %rax
	movl	$.LC25, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L91
.L90:
	movq	$0, -152(%rbp)
	movl	tctest_num_executed(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_num_executed(%rip)
	movl	$-1, tctest_assertion_line(%rip)
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	__sigsetjmp
	testl	%eax, %eax
	jne	.L92
	call	setup
	movq	%rax, -152(%rbp)
	movl	$.LC25, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movq	-152(%rbp), %rax
	movq	%rax, %rdi
	call	test_draw_pixel_2
	movl	$.LC7, %edi
	call	puts
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L93
	movq	tctest_on_test_executed(%rip), %rax
	movl	$1, %esi
	movl	$.LC25, %edi
	call	*%rax
	jmp	.L93
.L92:
	movl	tctest_failures(%rip), %eax
	addl	$1, %eax
	movl	%eax, tctest_failures(%rip)
	movq	tctest_on_test_executed(%rip), %rax
	testq	%rax, %rax
	je	.L93
	movq	tctest_on_test_executed(%rip), %rax
	movl	$0, %esi
	movl	$.LC25, %edi
	call	*%rax
.L93:
	cmpq	$0, -152(%rbp)
	je	.L91
	movq	-152(%rbp), %rax
	movq	%rax, %rdi
	call	cleanup
.L91:
	movl	tctest_failures(%rip), %eax
	testl	%eax, %eax
	jne	.L94
	movl	$.LC26, %edi
	call	puts
	jmp	.L95
.L94:
	movl	tctest_failures(%rip), %eax
	movl	%eax, %esi
	movl	$.LC27, %edi
	movl	$0, %eax
	call	printf
.L95:
	movq	tctest_on_complete(%rip), %rax
	testq	%rax, %rax
	je	.L96
	movq	tctest_on_complete(%rip), %rdx
	movl	tctest_num_executed(%rip), %eax
	movl	tctest_num_executed(%rip), %ecx
	movl	tctest_failures(%rip), %esi
	subl	%esi, %ecx
	movl	%eax, %esi
	movl	%ecx, %edi
	call	*%rdx
.L96:
	movl	tctest_failures(%rip), %eax
	testl	%eax, %eax
	setg	%al
	movzbl	%al, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC28:
	.string	"objs->small.data[SMALL_IDX(3, 2)] == 0x000000FFU"
	.align 8
.LC29:
	.string	"objs->small.data[SMALL_IDX(5, 4)] == 0x000000FFU"
	.align 8
.LC30:
	.string	"objs->small.data[SMALL_IDX(3, 2)] == 0xFF0000FF"
	.align 8
.LC31:
	.string	"objs->small.data[SMALL_IDX(5, 4)] == 0x800080FF"
	.align 8
.LC32:
	.string	"objs->small.data[SMALL_IDX(3, 2)] == 0x7F8000FF"
	.align 8
.LC33:
	.string	"objs->small.data[SMALL_IDX(4, 2)] == 0x000040FF"
	.text
	.globl	test_draw_pixel
	.type	test_draw_pixel, @function
test_draw_pixel:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$155, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	addq	$76, %rax
	movl	(%rax), %eax
	cmpl	$255, %eax
	je	.L99
	movl	$155, %edx
	movl	$.LC28, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L99:
	movl	$156, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	addq	$148, %rax
	movl	(%rax), %eax
	cmpl	$255, %eax
	je	.L100
	movl	$156, %edx
	movl	$.LC29, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L100:
	movq	-8(%rbp), %rax
	movl	$-16776961, %ecx
	movl	$2, %edx
	movl	$3, %esi
	movq	%rax, %rdi
	call	draw_pixel
	movl	$160, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	addq	$76, %rax
	movl	(%rax), %eax
	cmpl	$-16776961, %eax
	je	.L101
	movl	$160, %edx
	movl	$.LC30, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L101:
	movq	-8(%rbp), %rax
	movl	$-2147450625, %ecx
	movl	$4, %edx
	movl	$5, %esi
	movq	%rax, %rdi
	call	draw_pixel
	movl	$162, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	addq	$148, %rax
	movl	(%rax), %eax
	cmpl	$-2147450625, %eax
	je	.L102
	movl	$162, %edx
	movl	$.LC31, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L102:
	movq	-8(%rbp), %rax
	movl	$16711808, %ecx
	movl	$2, %edx
	movl	$3, %esi
	movq	%rax, %rdi
	call	draw_pixel
	movl	$166, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	addq	$76, %rax
	movl	(%rax), %eax
	cmpl	$2139095295, %eax
	je	.L103
	movl	$166, %edx
	movl	$.LC32, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L103:
	movq	-8(%rbp), %rax
	movl	$65344, %ecx
	movl	$2, %edx
	movl	$4, %esi
	movq	%rax, %rdi
	call	draw_pixel
	movl	$168, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	addq	$80, %rax
	movl	(%rax), %eax
	cmpl	$16639, %eax
	je	.L105
	movl	$168, %edx
	movl	$.LC33, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L105:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	test_draw_pixel, .-test_draw_pixel
	.section	.rodata
	.align 8
.LC34:
	.string	"                  rrr     rnnb    rnnb     bbb  "
	.text
	.globl	test_draw_rect
	.type	test_draw_rect, @function
test_draw_rect:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$240, %rsp
	movq	%rdi, -232(%rbp)
	movl	$2, -32(%rbp)
	movl	$2, -28(%rbp)
	movl	$3, -24(%rbp)
	movl	$3, -20(%rbp)
	movl	$3, -48(%rbp)
	movl	$3, -44(%rbp)
	movl	$3, -40(%rbp)
	movl	$3, -36(%rbp)
	movq	-232(%rbp), %rax
	leaq	-32(%rbp), %rcx
	movl	$-16776961, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	draw_rect
	movq	-232(%rbp), %rax
	leaq	-48(%rbp), %rcx
	movl	$65408, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	draw_rect
	movl	$-16776961, -4(%rbp)
	movl	$33023, -8(%rbp)
	movl	$2130739455, -12(%rbp)
	movl	$255, -16(%rbp)
	leaq	-224(%rbp), %rdx
	movl	$0, %eax
	movl	$21, %ecx
	movq	%rdx, %rdi
	rep stosq
	movb	$114, -224(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, -220(%rbp)
	movb	$98, -216(%rbp)
	movl	-8(%rbp), %eax
	movl	%eax, -212(%rbp)
	movb	$110, -208(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -204(%rbp)
	movb	$32, -200(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -196(%rbp)
	movq	$.LC34, -64(%rbp)
	movq	-232(%rbp), %rax
	leaq	-224(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	check_picture
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	test_draw_rect, .-test_draw_rect
	.section	.rodata
	.align 8
.LC35:
	.string	"   x      xxx    xxxxx    xxx      x            "
	.text
	.globl	test_draw_circle
	.type	test_draw_circle, @function
test_draw_circle:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$192, %rsp
	movq	%rdi, -184(%rbp)
	leaq	-176(%rbp), %rdx
	movl	$0, %eax
	movl	$21, %ecx
	movq	%rdx, %rdi
	rep stosq
	movb	$32, -176(%rbp)
	movl	$255, -172(%rbp)
	movb	$120, -168(%rbp)
	movl	$16711935, -164(%rbp)
	movq	$.LC35, -16(%rbp)
	movq	-184(%rbp), %rax
	movl	$16711935, %r8d
	movl	$2, %ecx
	movl	$2, %edx
	movl	$3, %esi
	movq	%rax, %rdi
	call	draw_circle
	movq	-184(%rbp), %rax
	leaq	-176(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	check_picture
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	test_draw_circle, .-test_draw_circle
	.section	.rodata
	.align 8
.LC36:
	.string	" xxxxxxx xxxxxxxxxxxxxxx xxxxxxx xxxxxxx  xxxxx "
	.text
	.globl	test_draw_circle_clip
	.type	test_draw_circle_clip, @function
test_draw_circle_clip:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$192, %rsp
	movq	%rdi, -184(%rbp)
	leaq	-176(%rbp), %rdx
	movl	$0, %eax
	movl	$21, %ecx
	movq	%rdx, %rdi
	rep stosq
	movb	$32, -176(%rbp)
	movl	$255, -172(%rbp)
	movb	$120, -168(%rbp)
	movl	$16711935, -164(%rbp)
	movq	$.LC36, -16(%rbp)
	movq	-184(%rbp), %rax
	movl	$16711935, %r8d
	movl	$4, %ecx
	movl	$2, %edx
	movl	$4, %esi
	movq	%rax, %rdi
	call	draw_circle
	movq	-184(%rbp), %rax
	leaq	-176(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	check_picture
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	test_draw_circle_clip, .-test_draw_circle_clip
	.section	.rodata
.LC37:
	.string	"img/PrtMimi.png"
	.align 8
.LC38:
	.string	"read_image(\"img/PrtMimi.png\", &objs->tilemap) == IMG_SUCCESS"
	.align 8
.LC39:
	.ascii	"                                                            "
	.ascii	" a     b                a      b                a     ab    "
	.ascii	"           ac      b               ac a    b          a a  a"
	.ascii	"d  a   b         a  a aad  aa ab         a  "
	.string	"a acd aaacab        aa  cdacdaddaadb         aa cdaddaaddadb         da ccaddcaddadb        adcaacdaddddcadb       aaccacadcaddccaab       aacdacddcaadcaaab       aaaddddaddaccaacb       aaacddcaadacaaadb        bbbbbbbbbbbbbbbb        bbbbbbbbbbbbbbbb    "
	.text
	.globl	test_draw_tile
	.type	test_draw_tile, @function
test_draw_tile:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$224, %rsp
	movq	%rdi, -216(%rbp)
	movl	$229, tctest_assertion_line(%rip)
	movq	-216(%rbp), %rax
	addq	$32, %rax
	movq	%rax, %rsi
	movl	$.LC37, %edi
	call	read_image
	testl	%eax, %eax
	je	.L110
	movl	$229, %edx
	movl	$.LC38, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L110:
	movl	$4, -16(%rbp)
	movl	$2, -12(%rbp)
	movl	$16, -8(%rbp)
	movl	$18, -4(%rbp)
	movq	-216(%rbp), %rax
	leaq	16(%rax), %rcx
	leaq	-16(%rbp), %rax
	movl	$270586111, %edx
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	draw_rect
	movl	$0, -32(%rbp)
	movl	$16, -28(%rbp)
	movl	$16, -24(%rbp)
	movl	$16, -20(%rbp)
	movq	-216(%rbp), %rax
	leaq	32(%rax), %rdx
	movq	-216(%rbp), %rax
	addq	$16, %rax
	leaq	-32(%rbp), %rcx
	movq	%rcx, %r8
	movq	%rdx, %rcx
	movl	$2, %edx
	movl	$3, %esi
	movq	%rax, %rdi
	call	draw_tile
	leaq	-208(%rbp), %rdx
	movl	$0, %eax
	movl	$21, %ecx
	movq	%rdx, %rdi
	rep stosq
	movb	$32, -208(%rbp)
	movl	$255, -204(%rbp)
	movb	$97, -200(%rbp)
	movl	$1387090687, -196(%rbp)
	movb	$98, -192(%rbp)
	movl	$270586111, -188(%rbp)
	movb	$99, -184(%rbp)
	movl	$628837119, -180(%rbp)
	movb	$100, -176(%rbp)
	movl	$206715647, -172(%rbp)
	movq	$.LC39, -48(%rbp)
	movq	-216(%rbp), %rax
	leaq	16(%rax), %rdx
	leaq	-208(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	check_picture
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	test_draw_tile, .-test_draw_tile
	.section	.rodata
.LC40:
	.string	"img/NpcGuest.png"
	.align 8
.LC41:
	.string	"read_image(\"img/NpcGuest.png\", &objs->spritemap) == IMG_SUCCESS"
	.align 8
.LC42:
	.ascii	"                         aaaaaaaaaaaaaa          aaaaaaaaaaa"
	.ascii	"aaa          aaaaaaaaaaaaaa          aaaaaaabccccccbc       "
	.ascii	" aaaaacccccccccccc       aaaacbddcccddcbccc      aaacbbbeccc"
	.ascii	"cedbccc      aaacbbceccccebbbccc     aaabbbc"
	.string	"cccccccbbccc     aaaabbbcccccccb ccb     aaaabaaaaabbaa  cb      aaaaaaaaafffea          aaaaaaaaaffeea          aaaaaaacffffcc                 cffffccb                 bbbbbbb                                                                                "
	.text
	.globl	test_draw_sprite
	.type	test_draw_sprite, @function
test_draw_sprite:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$224, %rsp
	movq	%rdi, -216(%rbp)
	movl	$271, tctest_assertion_line(%rip)
	movq	-216(%rbp), %rax
	addq	$48, %rax
	movq	%rax, %rsi
	movl	$.LC40, %edi
	call	read_image
	testl	%eax, %eax
	je	.L112
	movl	$271, %edx
	movl	$.LC41, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L112:
	movl	$1, -16(%rbp)
	movl	$1, -12(%rbp)
	movl	$14, -8(%rbp)
	movl	$14, -4(%rbp)
	movq	-216(%rbp), %rax
	leaq	16(%rax), %rcx
	leaq	-16(%rbp), %rax
	movl	$-2147450625, %edx
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	draw_rect
	movl	$128, -32(%rbp)
	movl	$136, -28(%rbp)
	movl	$16, -24(%rbp)
	movl	$15, -20(%rbp)
	movq	-216(%rbp), %rax
	leaq	48(%rax), %rdx
	movq	-216(%rbp), %rax
	addq	$16, %rax
	leaq	-32(%rbp), %rcx
	movq	%rcx, %r8
	movq	%rdx, %rcx
	movl	$2, %edx
	movl	$4, %esi
	movq	%rax, %rdi
	call	draw_sprite
	leaq	-208(%rbp), %rdx
	movl	$0, %eax
	movl	$21, %ecx
	movq	%rdx, %rdi
	rep stosq
	movb	$32, -208(%rbp)
	movl	$255, -204(%rbp)
	movb	$97, -200(%rbp)
	movl	$-2147450625, -196(%rbp)
	movb	$98, -192(%rbp)
	movl	$-1666334209, -188(%rbp)
	movb	$99, -184(%rbp)
	movl	$-269819137, -180(%rbp)
	movb	$100, -176(%rbp)
	movl	$268435711, -172(%rbp)
	movb	$101, -168(%rbp)
	movl	$642547967, -164(%rbp)
	movb	$102, -160(%rbp)
	movl	$827232511, -156(%rbp)
	movq	$.LC42, -48(%rbp)
	movq	-216(%rbp), %rax
	leaq	16(%rax), %rdx
	leaq	-208(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	check_picture
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	test_draw_sprite, .-test_draw_sprite
	.section	.rodata
.LC43:
	.string	"get_r(0x12345678) == 0x12"
.LC44:
	.string	"get_r(0x00000000) == 0x00"
.LC45:
	.string	"get_r(0xFFFFFFFF) == 0xFF"
	.text
	.globl	test_get_r
	.type	test_get_r, @function
test_get_r:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$317, tctest_assertion_line(%rip)
	movl	$305419896, %edi
	call	get_r
	cmpb	$18, %al
	je	.L114
	movl	$317, %edx
	movl	$.LC43, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L114:
	movl	$318, tctest_assertion_line(%rip)
	movl	$0, %edi
	call	get_r
	testb	%al, %al
	je	.L115
	movl	$318, %edx
	movl	$.LC44, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L115:
	movl	$319, tctest_assertion_line(%rip)
	movl	$-1, %edi
	call	get_r
	cmpb	$-1, %al
	je	.L117
	movl	$319, %edx
	movl	$.LC45, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L117:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	test_get_r, .-test_get_r
	.section	.rodata
.LC46:
	.string	"get_g(0x12345678) == 0x34"
.LC47:
	.string	"get_g(0x00000000) == 0x00"
.LC48:
	.string	"get_g(0xFFFFFFFF) == 0xFF"
	.text
	.globl	test_get_g
	.type	test_get_g, @function
test_get_g:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$326, tctest_assertion_line(%rip)
	movl	$305419896, %edi
	call	get_g
	cmpb	$52, %al
	je	.L119
	movl	$326, %edx
	movl	$.LC46, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L119:
	movl	$327, tctest_assertion_line(%rip)
	movl	$0, %edi
	call	get_g
	testb	%al, %al
	je	.L120
	movl	$327, %edx
	movl	$.LC47, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L120:
	movl	$328, tctest_assertion_line(%rip)
	movl	$-1, %edi
	call	get_g
	cmpb	$-1, %al
	je	.L122
	movl	$328, %edx
	movl	$.LC48, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L122:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	test_get_g, .-test_get_g
	.section	.rodata
.LC49:
	.string	"get_b(0x12345678) == 0x56"
.LC50:
	.string	"get_b(0x00000000) == 0x00"
.LC51:
	.string	"get_b(0xFFFFFFFF) == 0xFF"
	.text
	.globl	test_get_b
	.type	test_get_b, @function
test_get_b:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$335, tctest_assertion_line(%rip)
	movl	$305419896, %edi
	call	get_b
	cmpb	$86, %al
	je	.L124
	movl	$335, %edx
	movl	$.LC49, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L124:
	movl	$336, tctest_assertion_line(%rip)
	movl	$0, %edi
	call	get_b
	testb	%al, %al
	je	.L125
	movl	$336, %edx
	movl	$.LC50, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L125:
	movl	$337, tctest_assertion_line(%rip)
	movl	$-1, %edi
	call	get_b
	cmpb	$-1, %al
	je	.L127
	movl	$337, %edx
	movl	$.LC51, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L127:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	test_get_b, .-test_get_b
	.section	.rodata
.LC52:
	.string	"get_a(0x12345678) == 0x78"
.LC53:
	.string	"get_a(0x00000000) == 0x00"
.LC54:
	.string	"get_a(0xFFFFFFFF) == 0xFF"
	.text
	.globl	test_get_a
	.type	test_get_a, @function
test_get_a:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$344, tctest_assertion_line(%rip)
	movl	$305419896, %edi
	call	get_a
	cmpb	$120, %al
	je	.L129
	movl	$344, %edx
	movl	$.LC52, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L129:
	movl	$345, tctest_assertion_line(%rip)
	movl	$0, %edi
	call	get_a
	testb	%al, %al
	je	.L130
	movl	$345, %edx
	movl	$.LC53, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L130:
	movl	$346, tctest_assertion_line(%rip)
	movl	$-1, %edi
	call	get_a
	cmpb	$-1, %al
	je	.L132
	movl	$346, %edx
	movl	$.LC54, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L132:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	test_get_a, .-test_get_a
	.section	.rodata
.LC55:
	.string	"square(5) == 25"
.LC56:
	.string	"square(-5) == 25"
.LC57:
	.string	"square(0) == 0"
.LC58:
	.string	"square(1) == 1"
	.align 8
.LC59:
	.string	"square(1000000) == 1000000000000"
	.align 8
.LC60:
	.string	"square(-1000000) == 1000000000000"
	.text
	.globl	test_square
	.type	test_square, @function
test_square:
.LFB21:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$353, tctest_assertion_line(%rip)
	movl	$5, %edi
	call	square
	cmpq	$25, %rax
	je	.L134
	movl	$353, %edx
	movl	$.LC55, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L134:
	movl	$354, tctest_assertion_line(%rip)
	movq	$-5, %rdi
	call	square
	cmpq	$25, %rax
	je	.L135
	movl	$354, %edx
	movl	$.LC56, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L135:
	movl	$357, tctest_assertion_line(%rip)
	movl	$0, %edi
	call	square
	testq	%rax, %rax
	je	.L136
	movl	$357, %edx
	movl	$.LC57, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L136:
	movl	$358, tctest_assertion_line(%rip)
	movl	$1, %edi
	call	square
	cmpq	$1, %rax
	je	.L137
	movl	$358, %edx
	movl	$.LC58, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L137:
	movl	$361, tctest_assertion_line(%rip)
	movl	$1000000, %edi
	call	square
	movabsq	$1000000000000, %rdx
	cmpq	%rdx, %rax
	je	.L138
	movl	$361, %edx
	movl	$.LC59, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L138:
	movl	$362, tctest_assertion_line(%rip)
	movq	$-1000000, %rdi
	call	square
	movabsq	$1000000000000, %rdx
	cmpq	%rdx, %rax
	je	.L140
	movl	$362, %edx
	movl	$.LC60, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L140:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	test_square, .-test_square
	.section	.rodata
	.align 8
.LC61:
	.string	"in_bounds(&objs->small, 0, 0) == 1"
	.align 8
.LC62:
	.string	"in_bounds(&objs->small, 7, 5) == 1"
	.align 8
.LC63:
	.string	"in_bounds(&objs->small, 0, 5) == 1"
	.align 8
.LC64:
	.string	"in_bounds(&objs->empty, 0, 0) == 0"
	.align 8
.LC65:
	.string	"in_bounds(&objs->large, 0, 0) == 1"
	.align 8
.LC66:
	.string	"in_bounds(&objs->large, 23, 19) == 1"
	.align 8
.LC67:
	.string	"in_bounds(&objs->large, 0, 19) == 1"
	.align 8
.LC68:
	.string	"in_bounds(&objs->small, 8, 5) == 0"
	.align 8
.LC69:
	.string	"in_bounds(&objs->small, 7, 6) == 0"
	.align 8
.LC70:
	.string	"in_bounds(&objs->small, -1, -1) == 0"
	.align 8
.LC71:
	.string	"in_bounds(&objs->small, -1, 5) == 0"
	.align 8
.LC72:
	.string	"in_bounds(&objs->small, 8, -1) == 0"
	.text
	.globl	test_in_bounds
	.type	test_in_bounds, @function
test_in_bounds:
.LFB22:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$369, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	in_bounds
	cmpl	$1, %eax
	je	.L142
	movl	$369, %edx
	movl	$.LC61, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L142:
	movl	$370, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$5, %edx
	movl	$7, %esi
	movq	%rax, %rdi
	call	in_bounds
	cmpl	$1, %eax
	je	.L143
	movl	$370, %edx
	movl	$.LC62, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L143:
	movl	$371, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$5, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	in_bounds
	cmpl	$1, %eax
	je	.L144
	movl	$371, %edx
	movl	$.LC63, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L144:
	movl	$374, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	addq	$64, %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	in_bounds
	testl	%eax, %eax
	je	.L145
	movl	$374, %edx
	movl	$.LC64, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L145:
	movl	$377, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	addq	$16, %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	in_bounds
	cmpl	$1, %eax
	je	.L146
	movl	$377, %edx
	movl	$.LC65, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L146:
	movl	$378, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	addq	$16, %rax
	movl	$19, %edx
	movl	$23, %esi
	movq	%rax, %rdi
	call	in_bounds
	cmpl	$1, %eax
	je	.L147
	movl	$378, %edx
	movl	$.LC66, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L147:
	movl	$379, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	addq	$16, %rax
	movl	$19, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	in_bounds
	cmpl	$1, %eax
	je	.L148
	movl	$379, %edx
	movl	$.LC67, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L148:
	movl	$382, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$5, %edx
	movl	$8, %esi
	movq	%rax, %rdi
	call	in_bounds
	testl	%eax, %eax
	je	.L149
	movl	$382, %edx
	movl	$.LC68, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L149:
	movl	$383, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$6, %edx
	movl	$7, %esi
	movq	%rax, %rdi
	call	in_bounds
	testl	%eax, %eax
	je	.L150
	movl	$383, %edx
	movl	$.LC69, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L150:
	movl	$386, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$-1, %edx
	movl	$-1, %esi
	movq	%rax, %rdi
	call	in_bounds
	testl	%eax, %eax
	je	.L151
	movl	$386, %edx
	movl	$.LC70, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L151:
	movl	$387, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$5, %edx
	movl	$-1, %esi
	movq	%rax, %rdi
	call	in_bounds
	testl	%eax, %eax
	je	.L152
	movl	$387, %edx
	movl	$.LC71, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L152:
	movl	$390, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$5, %edx
	movl	$-1, %esi
	movq	%rax, %rdi
	call	in_bounds
	testl	%eax, %eax
	je	.L153
	movl	$390, %edx
	movl	$.LC71, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L153:
	movl	$391, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$-1, %edx
	movl	$8, %esi
	movq	%rax, %rdi
	call	in_bounds
	testl	%eax, %eax
	je	.L155
	movl	$391, %edx
	movl	$.LC72, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L155:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	test_in_bounds, .-test_in_bounds
	.section	.rodata
	.align 8
.LC73:
	.string	"compute_index(&objs->small, 0, 0) == 0"
	.align 8
.LC74:
	.string	"compute_index(&objs->small, 7, 5) == 47"
	.align 8
.LC75:
	.string	"compute_index(&objs->small, 7, 0) == 7"
	.align 8
.LC76:
	.string	"compute_index(&objs->small, 0, 5) == 40"
	.text
	.globl	test_compute_index
	.type	test_compute_index, @function
test_compute_index:
.LFB23:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$398, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	compute_index
	testl	%eax, %eax
	je	.L157
	movl	$398, %edx
	movl	$.LC73, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L157:
	movl	$399, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$5, %edx
	movl	$7, %esi
	movq	%rax, %rdi
	call	compute_index
	cmpl	$47, %eax
	je	.L158
	movl	$399, %edx
	movl	$.LC74, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L158:
	movl	$400, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movl	$7, %esi
	movq	%rax, %rdi
	call	compute_index
	cmpl	$7, %eax
	je	.L159
	movl	$400, %edx
	movl	$.LC75, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L159:
	movl	$401, tctest_assertion_line(%rip)
	movq	-8(%rbp), %rax
	movl	$5, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	compute_index
	cmpl	$40, %eax
	je	.L161
	movl	$401, %edx
	movl	$.LC76, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L161:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	test_compute_index, .-test_compute_index
	.section	.rodata
	.align 8
.LC77:
	.string	"check_rect_bounds(&objs->small, &s1) == 1"
	.align 8
.LC78:
	.string	"check_rect_bounds(&objs->small, &s2) == 0"
	.align 8
.LC79:
	.string	"check_rect_bounds(&objs->small, &s3) == 0"
	.align 8
.LC80:
	.string	"check_rect_bounds(&objs->small, &s4) == 1"
	.align 8
.LC81:
	.string	"check_rect_bounds(&objs->empty, &rand) == 0"
	.text
	.globl	test_check_rect_bounds
	.type	test_check_rect_bounds, @function
test_check_rect_bounds:
.LFB24:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -88(%rbp)
	movl	$1, -16(%rbp)
	movl	$1, -12(%rbp)
	movl	$6, -8(%rbp)
	movl	$4, -4(%rbp)
	movl	$409, tctest_assertion_line(%rip)
	movq	-88(%rbp), %rax
	leaq	-16(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	check_rect_bounds
	cmpl	$1, %eax
	je	.L163
	movl	$409, %edx
	movl	$.LC77, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L163:
	movl	$6, -32(%rbp)
	movl	$4, -28(%rbp)
	movl	$3, -24(%rbp)
	movl	$3, -20(%rbp)
	movl	$413, tctest_assertion_line(%rip)
	movq	-88(%rbp), %rax
	leaq	-32(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	check_rect_bounds
	testl	%eax, %eax
	je	.L164
	movl	$413, %edx
	movl	$.LC78, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L164:
	movl	$8, -48(%rbp)
	movl	$6, -44(%rbp)
	movl	$2, -40(%rbp)
	movl	$2, -36(%rbp)
	movl	$417, tctest_assertion_line(%rip)
	movq	-88(%rbp), %rax
	leaq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	check_rect_bounds
	testl	%eax, %eax
	je	.L165
	movl	$417, %edx
	movl	$.LC79, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L165:
	movl	$0, -64(%rbp)
	movl	$0, -60(%rbp)
	movl	$8, -56(%rbp)
	movl	$6, -52(%rbp)
	movl	$421, tctest_assertion_line(%rip)
	movq	-88(%rbp), %rax
	leaq	-64(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	check_rect_bounds
	cmpl	$1, %eax
	je	.L166
	movl	$421, %edx
	movl	$.LC80, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L166:
	movl	$0, -80(%rbp)
	movl	$0, -76(%rbp)
	movl	$1, -72(%rbp)
	movl	$1, -68(%rbp)
	movl	$425, tctest_assertion_line(%rip)
	movq	-88(%rbp), %rax
	leaq	64(%rax), %rdx
	leaq	-80(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	check_rect_bounds
	testl	%eax, %eax
	je	.L168
	movl	$425, %edx
	movl	$.LC81, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L168:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	test_check_rect_bounds, .-test_check_rect_bounds
	.section	.rodata
	.align 8
.LC82:
	.string	"                      gg      gg                "
	.text
	.globl	test_draw_rect_2
	.type	test_draw_rect_2, @function
test_draw_rect_2:
.LFB25:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$224, %rsp
	movq	%rdi, -216(%rbp)
	movl	$6, -32(%rbp)
	movl	$2, -28(%rbp)
	movl	$4, -24(%rbp)
	movl	$2, -20(%rbp)
	movq	-216(%rbp), %rax
	leaq	-32(%rbp), %rcx
	movl	$16711935, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	draw_rect
	movl	$16711935, -4(%rbp)
	movl	$255, -8(%rbp)
	leaq	-208(%rbp), %rdx
	movl	$0, %eax
	movl	$21, %ecx
	movq	%rdx, %rdi
	rep stosq
	movb	$103, -208(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, -204(%rbp)
	movb	$32, -200(%rbp)
	movl	-8(%rbp), %eax
	movl	%eax, -196(%rbp)
	movq	$.LC82, -48(%rbp)
	movq	-216(%rbp), %rax
	leaq	-208(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	check_picture
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	test_draw_rect_2, .-test_draw_rect_2
	.section	.rodata
	.align 8
.LC83:
	.string	"                                                "
	.text
	.globl	test_draw_rect_3
	.type	test_draw_rect_3, @function
test_draw_rect_3:
.LFB26:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$224, %rsp
	movq	%rdi, -216(%rbp)
	movl	$10, -32(%rbp)
	movl	$10, -28(%rbp)
	movl	$5, -24(%rbp)
	movl	$5, -20(%rbp)
	movq	-216(%rbp), %rax
	leaq	-32(%rbp), %rcx
	movl	$-65281, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	draw_rect
	movl	$255, -4(%rbp)
	leaq	-208(%rbp), %rdx
	movl	$0, %eax
	movl	$21, %ecx
	movq	%rdx, %rdi
	rep stosq
	movb	$32, -208(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, -204(%rbp)
	movq	$.LC83, -48(%rbp)
	movq	-216(%rbp), %rax
	leaq	-208(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	check_picture
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	test_draw_rect_3, .-test_draw_rect_3
	.section	.rodata
	.align 8
.LC84:
	.string	"objs->small.data[SMALL_IDX(SMALL_W - 1, SMALL_H - 1)] == color"
	.text
	.globl	test_draw_pixel_2
	.type	test_draw_pixel_2, @function
test_draw_pixel_2:
.LFB27:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$16711935, -4(%rbp)
	movq	-24(%rbp), %rax
	movl	-4(%rbp), %edx
	movl	%edx, %ecx
	movl	$5, %edx
	movl	$7, %esi
	movq	%rax, %rdi
	call	draw_pixel
	movl	$475, tctest_assertion_line(%rip)
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	addq	$188, %rax
	movl	(%rax), %eax
	cmpl	%eax, -4(%rbp)
	je	.L173
	movl	$475, %edx
	movl	$.LC84, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L173:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	test_draw_pixel_2, .-test_draw_pixel_2
	.section	.rodata
	.align 8
.LC85:
	.string	"blend_components(0xFF, 0x00, 0xFF) == 0xFF"
	.align 8
.LC86:
	.string	"blend_components(0xFF, 0x00, 0x00) == 0x00"
	.align 8
.LC87:
	.string	"blend_components(0xFF, 0x00, 0x80) == 0x80"
	.text
	.globl	test_blend_components
	.type	test_blend_components, @function
test_blend_components:
.LFB28:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$481, tctest_assertion_line(%rip)
	movl	$255, %edx
	movl	$0, %esi
	movl	$255, %edi
	call	blend_components
	cmpb	$-1, %al
	je	.L175
	movl	$481, %edx
	movl	$.LC85, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L175:
	movl	$482, tctest_assertion_line(%rip)
	movl	$0, %edx
	movl	$0, %esi
	movl	$255, %edi
	call	blend_components
	testb	%al, %al
	je	.L176
	movl	$482, %edx
	movl	$.LC86, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L176:
	movl	$483, tctest_assertion_line(%rip)
	movl	$128, %edx
	movl	$0, %esi
	movl	$255, %edi
	call	blend_components
	cmpb	$-128, %al
	je	.L178
	movl	$483, %edx
	movl	$.LC87, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L178:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.size	test_blend_components, .-test_blend_components
	.section	.rodata
	.align 8
.LC88:
	.string	"blend_colors(0xFFFFFFFF, 0x00FFFFFF) == 0xFFFFFFFF"
	.align 8
.LC89:
	.string	"blend_colors(0x00FFFFFF, 0x00FFFFFF) == 0x00FFFFFF"
	.text
	.globl	test_blend_colors
	.type	test_blend_colors, @function
test_blend_colors:
.LFB29:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$489, tctest_assertion_line(%rip)
	movl	$16777215, %esi
	movl	$-1, %edi
	call	blend_colors
	cmpl	$-1, %eax
	je	.L180
	movl	$489, %edx
	movl	$.LC88, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L180:
	movl	$490, tctest_assertion_line(%rip)
	movl	$16777215, %esi
	movl	$16777215, %edi
	call	blend_colors
	cmpl	$16777215, %eax
	je	.L182
	movl	$490, %edx
	movl	$.LC89, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %esi
	movl	$tctest_env, %edi
	call	siglongjmp
.L182:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.size	test_blend_colors, .-test_blend_colors
	.section	.rodata
	.align 8
	.type	__PRETTY_FUNCTION__.1, @object
	.size	__PRETTY_FUNCTION__.1, 13
__PRETTY_FUNCTION__.1:
	.string	"lookup_color"
	.align 8
	.type	__PRETTY_FUNCTION__.0, @object
	.size	__PRETTY_FUNCTION__.0, 14
__PRETTY_FUNCTION__.0:
	.string	"check_picture"
	.ident	"GCC: (GNU) 13.2.1 20231011 (Red Hat 13.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
