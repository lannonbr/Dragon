# Dragon
This repository is the source for my compiler for CS445 at Clarkson University.
It compiles a Pascal-like language to 64-bit gcc-based assembly.

## Contents
- pascal.l: Lexer
- pascal.y: Parser
- tree.h: Expression Trees
- statement.h: Statement Trees
- enums.h: enumerations for various files
- gencode.h: Code Generation
- node.h: Symbol table nodes
- stmtstack.h: Statement List stack
- symtable.h: Symbol Table stack
- util.h: Misc. util functions
- gcc\_examples/: A collection of simple C programs and the assembly compiled using GCC 

## License
This program is Licensed under the MIT License
