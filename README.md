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
- restack.h: Register stack
- gcc\_examples/: A collection of simple C programs and the assembly compiled using GCC 

## What I got done
As follows is a list of features that I got done at the end of the Spring 2017 semester.

- Lexical analysis
- Syntax analysis
- Expression Trees
- Symbol tables
- Statement lists
- Debug printing for expressions and statements
- Gencode:
	- variable assignment
	- reading
	- writing
	- longer expressions
	- if statements
	- while statements
	- procedures with no parameters

## What didn't get done
These are things I could work on in the future, but was not able to get done within the semester.

- detailed scoping semantics
- arrays
- unary operators (not & negative)
- procedures with parameters
- functions
- expressions with need of a temporary stack
- support for floating point numbers

## License
This program is Licensed under the MIT License
