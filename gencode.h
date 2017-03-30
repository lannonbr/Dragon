#ifndef GENCODE_H
#define GENCODE_H

#include "statement.h"
#include "tree.h"

void gen_code_main_preamble();
void gen_code_main_ending();
void gen_code_stmt_list(statement_t *list);
void gen_code_expr(tree_t *tree);
void gen_code_write(tree_list_t *expr_list);

#endif
