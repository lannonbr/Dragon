#include "gencode.h"

void gen_code_main_preamble() {
    printf(".globl\tmain\n");
    printf("main:\n");
    // Push base pointer
    printf("\tpushq\t%%rbp\n");
    // move stack pointer
    printf("\tmovq\t%%rsp, %%rbp\n");
}

void gen_code_stmt_list(statement_t *list) {

}

void gen_code_main_ending() {
    printf("\tmovq\t$0, %%rax\n");
    printf("\tpopq\t%%rbp\n");
    printf("\tret\n");
}