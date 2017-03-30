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
    statement_t *stmt = list;
    statement_t *head = list;

    if(stmt == NULL) {
        stmt = statement;
        return stmt;
    } else {
        while(stmt->next != NULL)
            stmt = stmt->next;
        stmt->next = statement;
        return head;
    }
}

void stmt_list_print(statement_t *list, int offset) {
    if(list == NULL) return;
    print_spaces(offset);
    switch(list->type) {
        case ST_ASSIGN:
            printf("[Statement]: ASSIGN %s = %d\n", list->stmt.assign_stmt.ident->name, list->stmt.assign_stmt.tree->attribute.ival);
            break;
        case ST_PROC:
            printf("[Statement]: PROCEDURE %s\n", list->stmt.proc_stmt.ident->name);
            break;
        case ST_IFTHENELSE:
            printf("[Statement]: IFTHENELSE\n");
	    printf("If Stmt:\n");
            stmt_list_print(list->stmt.if_then_else_stmt.if_stmt, offset+4);
	    printf("Else Stmt:\n");
            stmt_list_print(list->stmt.if_then_else_stmt.else_stmt, offset+4);
            break;
        case ST_WHILE:
            printf("[Statement]: WHILE\n");
	    printf("Do Stmt:\n");
            stmt_list_print(list->stmt.while_stmt.do_stmt, offset+4);
            break;
        default:
            printf("[Statement]: WAT\n%p", list);
            break;
    }
    if(list->next != NULL)
        stmt_list_print(list->next, offset);
}

void print_stmt_add(statement_t *stmt) {
    switch(stmt->type) {
        case ST_ASSIGN:
            printf("Assignment added\n");
            printf("\t%s = %d\n", stmt->stmt.assign_stmt.ident->name, stmt->stmt.assign_stmt.tree->attribute.ival);
            break;
        case ST_IFTHENELSE:
            printf("If-Then-Else added\n");
            printf("\tIF: ");
            print_stmt_add(stmt->stmt.if_then_else_stmt.if_stmt);
            printf("\tElse: ");
            print_stmt_add(stmt->stmt.if_then_else_stmt.else_stmt);
            break;
	case ST_WHILE:
	    printf("While added\n");
	    print_stmt_add(stmt->stmt.while_stmt.do_stmt);
	    break;
        case ST_PROC:
            printf("Procedure added\n");
            break;
    }
    if(stmt->next != NULL) {
        print_stmt_add(stmt->next);
    }
}
