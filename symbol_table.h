#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include <stdbool.h>

typedef struct {
    char* name;
    char* type;
    int size;
    bool primary_key;
} column_info;

typedef struct {
    char* name;
    int num_columns;
    column_info* columns;
} table_info;

typedef struct symbol {
    char* name;
    table_info* table;
    struct symbol* next;
} symbol;

// Function to add a symbol to the symbol table
symbol* add_symbol(char* name, table_info* table);

// Function to lookup a symbol in the symbol table
symbol* lookup_symbol(char* name);

// Function to delete a symbol from the symbol table
void delete_symbol(char* name);


void add_column_to_list(table_info* table, column_info* column);

column_info* create_column(char* name, char* data_type, int size)

#endif /* SYMBOL_TABLE_H */

