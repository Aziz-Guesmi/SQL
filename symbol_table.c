
#include <stdlib.h>
#include <string.h>




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

symbol* symbol_table = NULL;

symbol* add_symbol(char* name, table_info* table) {
    symbol* new_symbol = (symbol*) malloc(sizeof(symbol));
    new_symbol->name = strdup(name);
    new_symbol->table = table;
    new_symbol->next = symbol_table;
    symbol_table = new_symbol;
    return new_symbol;
}

symbol* lookup_symbol(char* name) {
    symbol* s;
    for (s = symbol_table; s != NULL; s = s->next) {
        if (strcmp(s->name, name) == 0) {
            return s;
        }
    }
    return NULL;
}

void delete_symbol(char* name) {
    symbol *s, *prev = NULL;
    for (s = symbol_table; s != NULL; prev = s, s = s->next) {
        if (strcmp(s->name, name) == 0) {
            if (prev == NULL) {
                symbol_table = s->next;
            } else {
                prev->next = s->next;
            }
            free(s->name);
            free(s->table->name);
            for (int i = 0; i < s->table->num_columns; i++) {
                free(s->table->columns[i].name);
                free(s->table->columns[i].type);
            }
            free(s->table->columns);
            free(s->table);
            free(s);
            return;
        }
    }
}

void add_column_to_list(table_info* table, column_info* column) {
    // Resize the columns array to accommodate the new column
    table->columns = (column_info*) realloc(table->columns, (table->num_columns + 1) * sizeof(column_info));
    
    // Add the new column to the end of the array
    table->columns[table->num_columns] = *column;
    
    // Increment the number of columns in the table
    table->num_columns++;
}

column_info* create_column(char* name, char* data_type, int size) {
    column_info* new_column = (column_info*) malloc(sizeof(column_info));
    new_column->name = name;
    new_column->type = data_type;
    new_column->size = size;
    return new_column;
}


