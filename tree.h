#ifndef TREE_H
#define TREE_H

typedef enum {
    T_BINOP,
    T_UNOP,
    T_REAL,
    T_INT,
    T_OTHER
} type_e;

typedef enum {
    OP_NEG,
    OP_NOT
} unaryop;

typedef enum { 
    OP_LT,
    OP_LE,
    OP_GT,
    OP_GE,
    OP_EQ,
    OP_NEQ,
    OP_ADD,
    OP_SUB,
    OP_MUL,
    OP_DIV,
    OP_MOD
} binop;

typedef struct tree_s {
    type_e type;
    union {
        int ival;
        float fval;
        char *sval;
        binop bopval;
        unaryop uopval;
    } attribute;
    struct tree_s *left, *right;
} tree_t;

tree_t * gen_tree();
tree_t * gen_num(int ival);
tree_t * gen_real(float fval);
tree_t * gen_binop(binop opval, tree_t *left, tree_t *right);
tree_t * gen_unaryop(unaryop opval, tree_t *left);

void print_tree(tree_t * tree);

#endif
