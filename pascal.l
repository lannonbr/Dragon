%{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
%}

%%

"(*".*"*)" { fprintf(stderr, "[COMMENT]"); yytext = ""; }
"{".*"}" { fprintf(stderr, "[COMMENT]"); yytext = ""; }
"program" { fprintf(stderr, "[PROGRAM]"); }
"array" { fprintf(stderr, "[ARRAY]"); }
"var" { fprintf(stderr, "[VAR]"); }
"of" { fprintf(stderr, "[OF]"); }
"integer" { fprintf(stderr, "[INTEGER]"); }
"real" { fprintf(stderr, "[REAL]"); }
"function" { fprintf(stderr, "[FUNCTION]"); }
"procedure" { fprintf(stderr, "[PROCEDURE]"); }
"begin" { fprintf(stderr, "[BEGIN]"); }
"end" { fprintf(stderr, "[END]"); }
":=" { fprintf(stderr, "[ASSIGNOP]"); }
"if" { fprintf(stderr, "[IF]"); }
"then" { fprintf(stderr, "[THEN]"); }
"else" { fprintf(stderr, "[ELSE]"); }
"while" { fprintf(stderr, "[WHILE]"); }
"do" { fprintf(stderr, "[DO]"); }
"<" { fprintf(stderr, "[RELOP:<]"); }
">" { fprintf(stderr, "[RELOP:>]"); }
"<=" { fprintf(stderr, "[RELOP:<=]"); }
">=" { fprintf(stderr, "[RELOP:>=]"); }
"=" { fprintf(stderr, "[RELOP:=]"); }
"<>" { fprintf(stderr, "[RELOP:<>]"); }
"+" { fprintf(stderr, "[ADDOP:+]"); }
"-" { fprintf(stderr, "[ADDOP:-]"); }
"or" { fprintf(stderr, "[ADDOP:or]"); }
"*" { fprintf(stderr, "[MULOP:*]"); }
"/" { fprintf(stderr, "[MULOP:/]"); }
"and" { fprintf(stderr, "[MULOP:and]"); }
"not" { fprintf(stderr, "[NOT]"); }
"." { fprintf(stderr, "[DOT]"); }
"," { fprintf(stderr, "[COMMA]"); }
".." { fprintf(stderr, "[DOTDOT]"); }
":" { fprintf(stderr, "[COLON]"); }
";" { fprintf(stderr, "[SEMICOLON]"); }
"(" { fprintf(stderr, "[LPAREN]"); }
")" { fprintf(stderr, "[RPAREN]"); }
"[" { fprintf(stderr, "[LBRACE]"); }
"]" { fprintf(stderr, "[RBRACE]"); }
[A-Za-z][A-Za-z0-9]* { fprintf(stderr, "[IDENT:%s]", yytext); }
[0-9]+ { fprintf(stderr, "[INUM:%d]", atoi(yytext)); }
[0-9]+\.[0-9]+ { fprintf(stderr, "[RNUM:%f]", atof(yytext)); }
[ \t] { ; }
[\n] { fprintf(stderr, "[NEWLINE]\n"); }
. { fprintf(stderr, "Unkown token: %s", yytext); }

%%

main() {
    yylex();
}