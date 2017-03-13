#include "tree.h"
#include <stdlib.h>
#include <stdio.h>

tree_t * gen_tree() {
    tree_t * new_tree = (tree_t *) malloc(sizeof(tree_t));
    new_tree->type = T_OTHER;
    return new_tree;
}

tree_t * gen_int(int ival) {
    tree_t * new_tree = (tree_t *) malloc(sizeof(tree_t));
    new_tree->type = T_INT;
    new_tree->attribute.ival = ival;
    fprintf(stderr, "%p\n", new_tree);
    return new_tree;
}

tree_t * gen_real(float fval) {
    tree_t * new_tree = (tree_t *) malloc(sizeof(tree_t));
    new_tree->type = T_REAL;
    new_tree->attribute.fval = fval;
    fprintf(stderr, "%p\n", new_tree);
    return new_tree;
}

tree_t * gen_binop(binop opval, tree_t *left, tree_t *right) {
    tree_t * new_tree = (tree_t *) malloc(sizeof(tree_t));;
    new_tree->type = T_BINOP;
    new_tree->attribute.bopval = opval;
    new_tree->left = left;
    new_tree->right = right;
    return new_tree;
}

tree_t * gen_unaryop(unaryop opval, tree_t *left) {
    tree_t * new_tree = (tree_t *) malloc(sizeof(tree_t));
    new_tree->type = T_UNOP;
    new_tree->attribute.uopval = opval;
    new_tree->left = left;
    return new_tree;
}

void print_tree(tree_t * tree) {

    fprintf(stderr, "%p\n", tree);

    if(tree == NULL) {
        return;
    }
    printf("Tree ");
    switch(tree->type) {
        case T_BINOP:
            printf("BINOP\n");
            break;
        case T_UNOP:
            printf("UNOP\n");
            break;
        case T_REAL:
            printf("REAL\n");
            printf("%f\n", tree->attribute.fval);
            break;
        case T_INT:
            printf("INT\n");
            printf("%d\n", tree->attribute.ival);
            break;
        case T_OTHER:
            printf("OTHER\n");
            break;
        default:
            printf("NOPE\n");
            break;
    }
    printf("\n");

    if(tree->left != NULL)
        print_tree(tree->left);
    if(tree->right != NULL)
        print_tree(tree->right);
}