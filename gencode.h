#ifndef GENCODE_H
#define GENCODE_H

#include "statement.h"

void gen_code_main_preamble();
void gen_code_main_ending();
void gen_code_stmt_list(statement_t *list);

#endif