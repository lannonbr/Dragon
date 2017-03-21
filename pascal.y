%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "tree.h"
#include "node.h"
#include "symtable.h"

sym_table_stack_t *top_scope;
node_t *tmp_nodes;
%}

%union {
    int ival;
    float fval;
    int bopval;
    char* sval;
    tree_t * tval;
    node_t *nval;
    type_e tyval;
}

%token <ival> INUM
%token <fval> RNUM
%token <sval> IDENT
%token PROGRAM
%token PROCEDURE FUNCTION
%token ARRAY
%token VAR
%token OF
%token INTEGER
%token REAL
%token BBEGIN END
%token DO
%token ASSIGNOP
%token IF THEN ELSE
%token WHILE
%token NOT
%token <bopval> RELOP
%token <bopval> ADDOP
%token <bopval> MULOP
%token DOTDOT

%type <tyval> type
%type <tyval> standard_type

%type <nval> identifier_list

%type <nval> variable

%type <tval> expression
%type <tval> simple_expression
%type <tval> term
%type <tval> factor

%%

start: program;

program: PROGRAM
    IDENT { top_scope = push_stack(top_scope, $2); }
    '(' identifier_list ')' ';' 
    declarations
    subprogram_declarations
    compound_statement
    '.' { top_scope = pop_stack(top_scope); }
    ;

identifier_list: IDENT
    { 
        printf("Inserting %s into symbol table scope %s\n", $1, top_scope->name);
        
        node_t * node = sts_insert(top_scope, 0, $1);
        node_t * tmp = tmp_nodes;
        tmp_nodes=node;
        tmp_nodes->next = tmp;

        printf("This scope now has %d variables\n", top_scope->var_count);

        $$ = tmp_nodes;
    }
    | identifier_list ',' IDENT 
    {
        printf("Inserting %s into symbol table scope %s\n", $3, top_scope->name);
        node_t * node = sts_insert(top_scope, 0, $3);
        node_t * tmp = tmp_nodes;
        tmp_nodes=node;
        tmp_nodes->next = tmp;

        printf("This scope now has %d variables\n", top_scope->var_count);

        $$ = tmp_nodes;
    }
    ;

declarations: declarations VAR identifier_list ':' type ';'
    {
        node_t * node = tmp_nodes;
        while(node != NULL) {
            node->var_type = $5;
            node = node->next;
        }
    }
    | /* empty */
    ;

/* TODO: Pass size of Array up to declarations field */
type: standard_type { $$ = $1; }
    | ARRAY '[' INUM DOTDOT INUM ']' OF standard_type { $$ = ($8 == T_REAL) ? T_ARR_REAL : T_ARR_INT; }
    ;

standard_type: INTEGER { $$ = T_INT; }
    | REAL { $$ = T_REAL; }
    ;

subprogram_declarations: subprogram_declarations subprogram_declaration ';'
    | /* empty */
    ;

subprogram_declaration: subprogram_head declarations subprogram_declarations compound_statement
    ;

subprogram_head: FUNCTION IDENT arguments ':' standard_type ';'
    | PROCEDURE IDENT arguments ';'
    ;

arguments: '(' parameter_list ')'
    | /* empty */
    ;

parameter_list: identifier_list ':' type
    | parameter_list ';' identifier_list ':' type
    ;

compound_statement: BBEGIN optional_statements END
    ;

optional_statements: statement_list
    | /* empty */
    ;

statement_list: statement
    | statement_list ';' statement
    ;

statement: variable ASSIGNOP expression { printf("[Parser] Assignment\n"); }
    | procedure_statement
    | compound_statement
    | IF expression THEN statement ELSE statement
    | WHILE expression DO statement
    ;

variable: IDENT { printf("Assign to var\n"); }
    | IDENT '[' expression ']' { printf("Assign to array index\n"); }
    ;

procedure_statement: IDENT
    | IDENT '(' expression_list ')' { printf("Procedure Call\n"); }
    ;

expression_list: expression
    | expression_list ',' expression
    ;

expression: simple_expression { print_tree($1, 0); $$ = $1; }
    | simple_expression RELOP simple_expression { $$ = gen_binop($2, $1, $3); }
    ;

simple_expression: term { $$ = $1; }
    | ADDOP term { $$ = gen_unaryop($1, $2); }
    | simple_expression ADDOP term { $$ = gen_binop($2, $1, $3); }
    ;

term: factor { $$ = $1; }
    | term MULOP factor { $$ = gen_binop($2, $1, $3); }
    ;

factor: IDENT { $$ = gen_ident(make_node(0, $1)); }
    | IDENT '(' expression_list ')' { printf("[Parser] Function Call\n"); $$ = gen_tree(); }
    | IDENT '[' expression ']' { printf("[Parser] Array Access\n"); $$ = gen_tree(); }
    | INUM { $$ = gen_int($1); }
    | RNUM { $$ = gen_real($1); }
    | '(' expression ')' { $$ = $2; }
    | NOT factor { $$ = gen_tree(); }
    ;

%%

int main() {
    top_scope = NULL;
    tmp_nodes = NULL;

    yyparse();
}
