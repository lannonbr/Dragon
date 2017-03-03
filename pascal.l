%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "pascal.tab.h"
%}

%%

"(*".*"*)" { fprintf(stderr, "[COMMENT]"); }
"{".*"}" { fprintf(stderr, "[COMMENT]"); }
"program" { fprintf(stderr, "[PROGRAM]"); return PROGRAM; }
"array" { fprintf(stderr, "[ARRAY]"); return ARRAY; }
"var" { fprintf(stderr, "[VAR]"); return VAR; }
"of" { fprintf(stderr, "[OF]"); return OF; }
"integer" { fprintf(stderr, "[INTEGER]"); return INTEGER; }
"real" { fprintf(stderr, "[REAL]"); return REAL; }
"function" { fprintf(stderr, "[FUNCTION]"); return FUNCTION; }
"procedure" { fprintf(stderr, "[PROCEDURE]"); return PROCEDURE; }
"begin" { fprintf(stderr, "[BEGIN]"); return BBEGIN; }
"end" { fprintf(stderr, "[END]"); return END; }
":=" { fprintf(stderr, "[ASSIGNOP]"); return ASSIGNOP; }
"if" { fprintf(stderr, "[IF]"); return IF; }
"then" { fprintf(stderr, "[THEN]"); return THEN; }
"else" { fprintf(stderr, "[ELSE]"); return ELSE; }
"while" { fprintf(stderr, "[WHILE]"); return WHILE; }
"do" { fprintf(stderr, "[DO]"); return DO; }
"<" { fprintf(stderr, "[RELOP:<]"); yylval.relopval = 0; return RELOP; }
">" { fprintf(stderr, "[RELOP:>]"); yylval.relopval = 1; return RELOP; }
"<=" { fprintf(stderr, "[RELOP:<=]"); yylval.relopval = 2; return RELOP; }
">=" { fprintf(stderr, "[RELOP:>=]"); yylval.relopval = 3; return RELOP; }
"=" { fprintf(stderr, "[RELOP:=]"); yylval.relopval = 4; return RELOP; }
"<>" { fprintf(stderr, "[RELOP:<>]"); yylval.relopval = 5; return RELOP; }
"+" { fprintf(stderr, "[ADDOP:+]"); yylval.addopval = 0; return ADDOP; }
"-" { fprintf(stderr, "[ADDOP:-]"); yylval.addopval = 1; return ADDOP; }
"or" { fprintf(stderr, "[ADDOP:or]"); yylval.addopval = 2; return ADDOP; }
"*" { fprintf(stderr, "[MULOP:*]"); yylval.addopval = 0; return MULOP; }
"/" { fprintf(stderr, "[MULOP:/]"); yylval.addopval = 1; return MULOP; }
"and" { fprintf(stderr, "[MULOP:and]"); yylval.addopval = 2; return MULOP; }
"not" { fprintf(stderr, "[NOT]"); return NOT; }
"." { fprintf(stderr, "[DOT]"); return '.'; }
"," { fprintf(stderr, "[COMMA]"); return ','; }
".." { fprintf(stderr, "[DOTDOT]"); return DOTDOT; }
":" { fprintf(stderr, "[COLON]"); return ':'; }
";" { fprintf(stderr, "[SEMICOLON]"); return ';'; }
"(" { fprintf(stderr, "[LPAREN]"); return '('; }
")" { fprintf(stderr, "[RPAREN]"); return ')'; }
"[" { fprintf(stderr, "[LBRACE]"); return '['; }
"]" { fprintf(stderr, "[RBRACE]"); return ']'; }
[A-Za-z][A-Za-z0-9]* { fprintf(stderr, "[IDENT:%s]", yytext); yylval.sval = strdup(yytext); return IDENT; }
[0-9]+ { fprintf(stderr, "[INUM:%d]", atoi(yytext)); yylval.ival = atoi(yytext); return INUM; }
[0-9]+\.[0-9]+ { fprintf(stderr, "[RNUM:%f]", atof(yytext)); yylval.fval = atof(yytext); return RNUM; }
[ \t] { ; }
[\n] { fprintf(stderr, "\n"); }
. { fprintf(stderr, "Unkown token: %s", yytext); }

%%