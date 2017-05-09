#include <stdio.h>
#include <stdlib.h>
#include "statement.h"
#include "tree.h"
#include "node.h"
#include "enums.h"
#include "util.h"

statement_t * stmt_gen_assign(node_t *ident, tree_t *tree) {
	statement_t * stmt = (statement_t *) malloc(sizeof(statement_t));
	stmt->type = ST_ASSIGN;

	stmt->stmt.assign_stmt.ident = ident;
	stmt->stmt.assign_stmt.tree = tree;

	return stmt;
}

statement_t * stmt_gen_proc(node_t *ident, tree_list_t *proc_expr_list) {
	statement_t * stmt = (statement_t *) malloc(sizeof(statement_t));
	stmt->type = ST_PROC;

	stmt->stmt.proc_stmt.ident = ident;
	stmt->stmt.proc_stmt.proc_expr_list = proc_expr_list;

	return stmt;
}

statement_t * stmt_gen_if_then_else(tree_t *tree, statement_t *if_stmt, statement_t *else_stmt) {
	statement_t * stmt = (statement_t *) malloc(sizeof(statement_t));
	stmt->type = ST_IFTHENELSE;

	stmt->stmt.if_then_else_stmt.tree = tree;
	stmt->stmt.if_then_else_stmt.if_stmt = if_stmt;
	stmt->stmt.if_then_else_stmt.else_stmt = else_stmt;

	return stmt;
}

statement_t * stmt_gen_while(tree_t *tree, statement_t *do_stmt) {
	statement_t * stmt = (statement_t *) malloc(sizeof(statement_t));
	stmt->type = ST_WHILE;

	stmt->stmt.while_stmt.tree = tree;
	stmt->stmt.while_stmt.do_stmt = do_stmt;

	return stmt;
}

statement_t * stmt_list_append(statement_t *list, statement_t *statement) {
	// Setup local vars
	statement_t *stmt = list;
	statement_t *head = list;

	// if the current list is empty, set it to the new statement
	if(stmt == NULL) {
		stmt = statement;
		return stmt;
	} else {
		// Run to the end of list and then append the new statement to it
		while(stmt->next != NULL)
			stmt = stmt->next;
		stmt->next = statement;
		return head;
	}
}

// Debugging function to view the statement list and it's contents
void stmt_list_print(char* scope_name, statement_t *list, int offset) {
	
	// print spaces to align things for recursive calls
	print_spaces(offset);
	
	// If the list is empty, return
	if(list == NULL) {
		printf("Empty Statement\n");
		return;
	}

	// Switch on type and print some information about the statement itself
	// and then call the inner statements
	switch(list->type) {
		case ST_ASSIGN:
			printf("[%s | Statement]: ASSIGN\n", scope_name);
			print_spaces(offset+4);
			printf("id: %s\n", list->stmt.assign_stmt.ident->name);
			print_spaces(offset+4);
			printf("val: %d\n", list->stmt.assign_stmt.tree->attribute.ival);
			break;
		case ST_PROC:
			printf("[%s | Statement]: PROCEDURE %s\n", scope_name, list->stmt.proc_stmt.ident->name);
			printf("Arguments:\n");
			print_tree_list(list->stmt.proc_stmt.proc_expr_list);
			break;
		case ST_IFTHENELSE:
			printf("[%s | Statement]: IFTHENELSE\n", scope_name);
			printf("If Stmt:\n");
			stmt_list_print(scope_name, list->stmt.if_then_else_stmt.if_stmt, offset+4);
			printf("Else Stmt:\n");
			stmt_list_print(scope_name, list->stmt.if_then_else_stmt.else_stmt, offset+4);
			break;
		case ST_WHILE:
			printf("[%s | Statement]: WHILE\n", scope_name);
			printf("Do Stmt:\n");
			stmt_list_print(scope_name, list->stmt.while_stmt.do_stmt, offset+4);
			break;
		default:
			break;
	}

	// If there's another statement in the list, continue
	if(list->next != NULL)
		stmt_list_print(scope_name, list->next, offset);
}
