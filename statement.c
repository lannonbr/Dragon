#include <stdio.h>
#include <stdlib.h>
#include "statement.h"
#include "tree.h"
#include "node.h"
#include "enums.h"

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
    statement_t * curr_stmt = list;
    statement_t * head = list;
    
    if(curr_stmt != NULL) {
        while(curr_stmt->next != NULL) {
            curr_stmt = curr_stmt->next;
        }
        curr_stmt->next = statement;
    } else {
        head = curr_stmt = statement;
    }
    
    return head;
}

void stmt_list_print(statement_t *list) {
    switch(list->type) {
        case ST_ASSIGN:
            printf("[Statement]: ASSIGN\n");
            break;
        case ST_PROC:
            printf("[Statement]: PROCEDURE\n");
            break;
        case ST_IFTHENELSE:
            printf("[Statement]: IFTHENELSE\n");
            stmt_list_print(list->stmt.if_then_else_stmt.if_stmt);
            stmt_list_print(list->stmt.if_then_else_stmt.else_stmt);
            break;
        case ST_WHILE:
            printf("[Statement]: WHILE\n");
            break;
    }
    if(list->next != NULL)
        stmt_list_print(list->next);
}