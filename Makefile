pascal: pascal.tab.o lex.yy.o tree.o
	clang -g -o pascal pascal.tab.o lex.yy.o tree.o -ll -ly

tree.o: tree.c
	clang -g -c tree.c

pascal.tab.o: pascal.tab.c
	clang -g -c pascal.tab.c

pascal.tab.c: pascal.y
	bison -dv pascal.y

lex.yy.o: lex.yy.c
	clang -g -c lex.yy.c

lex.yy.c: pascal.l
	flex -l pascal.l

clean:
	rm -rf lex.yy.* pascal.tab.* *.o pascal
