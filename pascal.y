%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "pascal.tab.h"
%}

%union {
    int ival;
    float fval;
    int relopval;
    int addopval;
    int mulopval;
    char* sval;
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
%token <relopval> RELOP
%token <addopval> ADDOP
%token <mulopval> MULOP
%token DOTDOT

"%define error-verbose"

%%

start: program;

program: PROGRAM IDENT '(' identifier_list ')' ';'
    declarations
    subprogram_declarations
    compound_statement
    '.'
    ;

identifier_list: IDENT
    | identifier_list ',' IDENT
    ;

declarations: declarations VAR identifier_list ':' type ';' { /* do stuff */ }
    | /* empty */
    ;

type: standard_type
    | ARRAY '[' ADDOP INUM DOTDOT INUM ']' OF standard_type
    ;

standard_type: INTEGER
    | REAL
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

statement: variable ASSIGNOP expression
    | procedure_statement
    | compound_statement
    | IF expression THEN statement ELSE statement
    | WHILE expression DO statement
    ;

variable: IDENT
    | IDENT '[' expression ']'
    ;

procedure_statement: IDENT
    | IDENT '(' expression_list ')'
    ;

expression_list: expression
    | expression_list ',' expression
    ;

expression: simple_expression
    | simple_expression RELOP simple_expression
    ;

simple_expression: term
    | ADDOP term
    | simple_expression ADDOP term
    ;

term: factor
    | term MULOP factor
    ;

factor: IDENT
    | IDENT '(' expression_list ')'
    | IDENT '[' expression ']'
    | INUM
    | RNUM
    | '(' expression ')'
    | NOT factor
    ;

%%

int main() {
    yyparse();
}