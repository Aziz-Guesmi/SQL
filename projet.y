%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.c"
#include <stdbool.h>

int yylex(void);
int yywrap();
int yyerror(char const *s);
extern char* yytext;

int nbChamps = 0;
int nbfields = 0;
%}
%debug


%union {
char* strval;
    int numval;
    char** strlist;
    table_info* table;
        char** column_list;


}

%token SELECT FROM WHERE CREATE DELETE UPDATE SET VIRG ETOILE EGAL INF SUP INFEGAL SUPEGAL ET OU EGAL_EQUAL PARENTHESE_OUVRANTE PARENTHESE_FERMANTE PLUS MOINS DIV POINT APOSTROPHE  TRUE FALSE TABLE PRIMARY_KEY  SP POINTVIRGULE ALTER ADD DROP NUM 
%token <strval> ID
%token <strval> DATATYPE
%type <numval> NUM 
%type <numval> column_size
%type <strval> from_clause 
%type <strval> champs
%type <strval> table_column
%type <strval> table_column_list
%left PLUS
%left MOINS
%left DIV
%left ET 
%left OU

%%

requete: select_clause 
       | create_clause 
       | delete_clause 
       | update_clause 
       |create_column
       |alter_table_clause
       ;

select_clause: SELECT champs from_clause where_clause {printf("%d champs sélectionnés\n", nbChamps);}  
	{
		// Lookup the table in the symbol table
		symbol* sym = lookup_symbol($3);
		if (sym == NULL) {
		    printf("La table %s n'existe pas\n", $3);
		} else {
		    // Do something with the table_info struct
		    table_info* table = sym->table;


		    // Look up the column name in the table columns
		    char* column_name = $2; // Replace with the name you want to look up
		    bool column_found = false;
		    for (int i = 0; i < table->num_columns; i++) {
			if (strcmp(table->columns[i].name, column_name) == 0) {
			    column_found = true;
			    break;
			}
		    }

		if (column_found) {
			//printf("La colonne %s existe dans la table %s\n", column_name, $3);
		    } else {
			printf("Le champ %s n'existe pas dans la table %s\n", column_name, $3);
		    }
		}

	}

    | SELECT ETOILE from_clause where_clause  
    { 
   char* table_name = $3;
  symbol* sym = lookup_symbol(table_name);
  if (sym == NULL) {
   printf("La table %s n'existe pas\n", table_name);
  } else {
    table_info* table = sym->table;
   printf("Tous les champs sélectionnés\n");
    
  }	
	}
    ;

champs: ID {nbChamps++;$$=$1;} 
      | champs VIRG ID {nbChamps++;}
     ;

from_clause: FROM ID {$$ = $2;
  //char* table_name = $2;
  //symbol* sym = lookup_symbol(table_name);
  //if (sym == NULL) {
  //  printf("La table %s n'existe pas\n", table_name);
  //} else {
   // table_info* table = sym->table;
  //  printf("La table %s existe \n", table_name);
    
  //}
};


where_clause : WHERE condition
|
             ;

condition: comparaison
         | PARENTHESE_OUVRANTE condition PARENTHESE_FERMANTE
         | condition PLUS condition
         | condition MOINS condition
         | condition DIV condition
         | condition ET condition
         | condition OU condition
         ;

comparaison: expression EGAL expression
           | expression INF expression
           | expression SUP expression
           | expression INFEGAL expression
           | expression SUPEGAL expression
           | expression EGAL_EQUAL expression
           ;

expression: ID
          | NUM
          | TRUE
          | FALSE
          ;

create_clause: CREATE TABLE ID PARENTHESE_OUVRANTE table_column_list PARENTHESE_FERMANTE {
    // Create a new table_info struct to store the table information
    table_info* new_table = (table_info*) malloc(sizeof(table_info));
    new_table->name = $3;
    new_table->num_columns = nbfields;

    // Allocate memory for the columns
  	  new_table->columns = (column_info*) malloc(nbfields * sizeof(column_info));
	 new_table->columns[0].name = $5;
	 
       // new_table->columns[0].type = "int";
	
    // Copy the column names and data types to the new table_info struct
    
     

    // Add the new table to the symbol table
    symbol* table_entry = add_symbol($3, new_table);

    printf("Table créée avec succès  \n ");
}

 table_column_list:
    table_column {$$=$1;}
    | table_column PRIMARY_KEY {$$=$1;}
    | table_column_list VIRG table_column {$$=$1;} 
    ;

table_column: ID DATATYPE column_size {nbfields++;$$=$1;}
    ;

column_size:
    PARENTHESE_OUVRANTE NUM PARENTHESE_FERMANTE {$$=$2;}
    |{ $$ = -1; }
    ;


delete_clause: DELETE FROM ID WHERE condition { 
   char* table_name = $3;
  symbol* sym = lookup_symbol(table_name);
  if (sym == NULL) {
   printf("La table %s n'existe pas\n", table_name);
  } else {
    table_info* table = sym->table;
   printf("(2 rows were deleted)\n");
    
  };	
	};
              

update_clause: UPDATE ID SET ID EGAL expression WHERE condition { 
   char* table_name = $2;
  symbol* sym = lookup_symbol(table_name);
  if (sym == NULL) {
   printf("La table %s n'existe pas\n", table_name);
  } else {
    table_info* table = sym->table;
   printf("(2 rows affected)\n");
    
  }};
  
  create_column: ALTER TABLE ID ADD ID DATATYPE column_size {
    // Retrieve the table_info struct from the symbol table
    symbol* table_entry = lookup_symbol($3);
    if (table_entry == NULL) {
        printf("Erreur: La table \"%s\" n'existe pas\n", $3);
        YYERROR;
    }
    table_info* table = table_entry->table;

    // Reallocate memory to fit the new column
    int new_num_columns = table->num_columns + 1;
    table->columns = (column_info*) realloc(table->columns, new_num_columns * sizeof(column_info));

    // Fill in the column_info struct for the new column
    column_info* new_column = &(table->columns[new_num_columns - 1]);
    new_column->name = $5;
    new_column->type = $6;
   // new_column->size = $7;

    // Update the table_info struct with the new number of columns
    table->num_columns = new_num_columns;

    printf("Colonne \"%s\" ajoutée à la table \"%s\" avec succès\n", $5, $3);
};

alter_table_clause: ALTER TABLE ID DROP ID {
    // Find the table in the symbol table
    symbol* table_entry = lookup_symbol($3);
    if (table_entry == NULL) {
        printf("ERROR: Table '%s' not found.\n", $3);
        YYERROR;
    }

    // Find the column in the table's column list
    int column_index = -1;
    for (int i = 0; i < table_entry->table->num_columns; i++) {
        if (strcmp(table_entry->table->columns[i].name, $5) == 0) {
            column_index = i;
            break;
        }
    }

    // If the column was not found, print an error message and return
    if (column_index == -1) {
        printf("ERROR: Column '%s' not found in table '%s'.\n", $5, $3);
        YYERROR;
    }

    // Free memory for the column to be dropped
    free(table_entry->table->columns[column_index].name);
    free(table_entry->table->columns[column_index].type);

    // Shift the remaining columns to the left to fill the gap
    for (int i = column_index; i < table_entry->table->num_columns - 1; i++) {
        table_entry->table->columns[i] = table_entry->table->columns[i + 1];
    }

    // Decrement the number of columns in the table
    table_entry->table->num_columns--;

    printf("Column '%s' dropped from table '%s'.\n", $5, $3);
}


%%
#include "lex.yy.c"


int yyerror(char const *s)
{
  printf("Erreur de syntaxe à la ligne : %s\n" , s);
}
int yywrap() {
    return 1;
}
int main(int argc, char** argv) {
    char input[1024];
    while(1) {
    	nbChamps = 0;
    	nbfields = 0;
        printf("Enter a SQL query: ");
        fgets(input, 1024, stdin);
        yy_scan_string(input);
        yyparse();
        yy_delete_buffer(YY_CURRENT_BUFFER);
    }
    return 0;
}





