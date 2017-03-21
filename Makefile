psc: pascal.tab.o lex.yy.o tree.o node.o symtable.o statement.o
	clang -g -o psc pascal.tab.o lex.yy.o tree.o node.o symtable.o statement.o -lfl -ly

tree.o: tree.c
	clang -g -c tree.c

symtable.o: symtable.c
	clang -g -c symtable.c
	
node.o: node.c
	clang -g -c node.c

statement.o: statement.c
	clang -g -c statement.c

pascal.tab.o: pascal.tab.c
	clang -g -c pascal.tab.c

pascal.tab.c: pascal.y
	bison -dv pascal.y

lex.yy.o: lex.yy.c
	clang -g -c lex.yy.c

lex.yy.c: pascal.l
	flex -l pascal.l

clean:
	rm -rf lex.yy.* pascal.tab.* *.o psc
