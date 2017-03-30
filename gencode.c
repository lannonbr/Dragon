#include <stdio.h>
#include "gencode.h"
#include "tree.h"

void gen_code_main_preamble() {
    printf(".globl\tmain\n");
    printf("main:\n");
    // Push base pointer
    printf("\tpushq\t%%rbp\n");
    // move stack pointer
    printf("\tmovq\t%%rsp, %%rbp\n");
}

void gen_code_main_ending() {
	// Move return value to %rax
    printf("\tmovq\t$0, %%rax\n");
	// Pop base pointer
    printf("\tpopq\t%%rbp\n");
	// Quit
    printf("\tret\n");
}

void gen_code_stmt_list(statement_t *list) {
	// Go through each statement and generate the code depending on the statement type
}

void gen_code_expr(tree_t *tree) {
	// GENCODE Algorithm from class
}

void gen_code_write(tree_list_t *expr_list) {
	// When generating a call to write, you can assume that it has one parameter,
	// if none, quit. if more, discard them

    // Empty expr_list
    if(expr_list->head != NULL) {
		fprintf(stderr, "[Error]: No parameter to write\n");
		exit(-1);
    }

	// gencode the top of the expr_list which is the only parameter
	gen_code_expr(expr_list->head);

	// move this value which is now in %rax into a parameter for printf

    // Push string into register

    // Call printf
}
