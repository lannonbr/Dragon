#include <stdlib.h>
#include <stdio.h>
#include "symtable.h"

sym_table_stack_t *create_stack() {
	int i;
	sym_table_stack_t * stack = (sym_table_stack_t*) malloc(sizeof(sym_table_stack_t));
	
	stack->var_count = 0;

	for(int i = 0; i < HASH_SIZE; i++) {
		stack->table[i] = NULL;
	}

	stack->next = NULL;

	return stack;
}

sym_table_stack_t *pop_stack(sym_table_stack_t *head) {
	sym_table_stack_t *temp_stack;

	if(head != NULL) {
		printf("Popping stack: %s\n", head->name);
		temp_stack = head;
		head = head->next;

		free_sts(temp_stack);

		return head;
	}

	return NULL;
}

sym_table_stack_t *push_stack(sym_table_stack_t *head, char* name) {
	sym_table_stack_t *new_stack = create_stack();

	if(new_stack == NULL) {
		fprintf(stderr, "Error: empty symbol table stack");
		exit(1);
	}

	new_stack->next = head;
	new_stack->name = name;

	printf("Pushing stack: %s\n", new_stack->name);

	return new_stack;
}

node_t * sts_search(sym_table_stack_t *head, char* name) {
	int idx;
	node_t *node;

	if(head != NULL) {
		idx = hashpjw(name);
		node = head->table[idx];

		return search_node(node, name);
	}

	return NULL;
}

node_t * sts_global_search(sym_table_stack_t *head, char* name) {
	node_t * node;
	sym_table_stack_t *scope = head;

	while(head != NULL) {
		node = sts_search(scope, name);
		if(node != NULL) {
			return node;
		}
		scope = scope->next;
	}
	return NULL;
}

node_t * sts_insert(sym_table_stack_t *head, int type, char* name) {
	int idx;

	node_t *node;

	if(head != NULL) {
		idx = hashpjw(name);
		
		node = head->table[idx];

		if(search_node(node, name) == NULL) {
			head->table[idx] = insert_node(node, type, name, head->var_count);
			head->var_count += 1;
			return head->table[idx];
		} else {
			fprintf(stderr, "%s is already in current symbol table\n", name);
			exit(1);
		}
	}

	return NULL;
}

void free_sts(sym_table_stack_t *head) {
    for(int i = 0; i < HASH_SIZE; i++) {
		// printf("%p\t%p\n", head, head->table[i]);
        free_node(head->table[i]);
    }
    if(head->next != NULL)
        free_sts(head->next);
}

int hashpjw( char *s )
{
	char *p; 
	unsigned h = 0, g; 
	
	for ( p = s; *p != EOS; p++ ) 
	{ 
		h = (h << 4) + (*p); 
		if ( (g = (h & 0xf0000000)) != 0) 
		{ 
			h = h ^ ( g >> 24 ); 
			h = h ^ g; 
		} 
	} 
	return h % HASH_SIZE; 
}