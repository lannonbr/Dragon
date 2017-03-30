#include <stdio.h>
#include "gencode.h"
#include "tree.h"
#include "pascal.tab.h"

extern int num_registers;

tree_t * tree_label(tree_t *tree) {
	tree_t * curr_tree = tree;

	if(curr_tree->leaf) {
		if(curr_tree->side == S_LEFT) {
			curr_tree->label = 1;
		} else {
			curr_tree->label = 0;
		}
		return curr_tree;
	}

	int left_label = label_aux(curr_tree->left);
	int right_label = label_aux(curr_tree->right);

	if(left_label == right_label) {
		curr_tree->label = left_label + 1;
	} else {
		curr_tree->label = (left_label >= right_label) ? left_label : right_label;
	}
	return curr_tree;
}

int label_aux(tree_t *tree) {
	tree_t * curr_tree = tree;

	if(curr_tree->leaf) {
		if(curr_tree->side == S_LEFT) {
			return 1;
		} else {
			return 0;
		}
	}

	int left_label = label_aux(curr_tree->left);
	int right_label = label_aux(curr_tree->right);

	if(left_label == right_label) {
		return left_label + 1;
	} else {
		return (left_label >= right_label) ? left_label : right_label;
	}
}

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
	statement_t *stmt = list;
	
	switch(stmt->type) {
		case ST_ASSIGN:
			stmt->stmt.assign_stmt.tree = tree_label(stmt->stmt.assign_stmt.tree);
			gen_code_expr(stmt->stmt.assign_stmt.tree);
			printf("\tmovq\t%%rax, %d(%%rbp)\n", -4*stmt->stmt.assign_stmt.ident->offset);
			break;
		default:
			printf("Nope, don't care yet\n");
			break;
	}

	if(stmt->next != NULL)
		gen_code_stmt_list(stmt->next);
}

void gen_code_expr(tree_t *tree) {
	// GENCODE Algorithm from class
	if(tree->leaf && tree->side == S_LEFT) {
		// CASE 0
		printf("\tmovq\t%s, %s\n", get_val(tree), "%rax");
	} else if(tree->right->leaf) {
		// CASE 1
	} else if(tree->right->label > tree->left->label && num_registers > tree->left->label) {
		// CASE 2
	} else if(tree->left->label >= tree->right->label && num_registers > tree->right->label) {
		// CASE 3
	} else {
		// CASE 4
		printf("This shouldn't run. If it does, oh dear\n");
		exit(-1);
	}
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

char* get_val(tree_t *tree) {
	char str[50];
	
	switch(tree->type) {
		case T_INT: 
			sprintf(str, "$%d", tree->attribute.ival);
			break;
		case T_ID:
			sprintf(str, "%d(%%rbp)", -4*(tree->attribute.sval->offset));
			break;
	}

	return str;
}
