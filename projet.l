%{
#include "projet.tab.h"
extern FILE *yyin;
%}

%option noyywrap
%option yylineno
%option nounput
ALTER 	(A|a)(L|l)(T|t)(E|e)(R|r)
ADD	(A|a)(D|d)(D|d)
DROP	(D|d)(R|r)(O|o)(P|p)
SELECT (S|s)(E|e)(L|l)(E|e)(C|c)(T|t)
FROM	(F|f)(R|r)(O|o)(M|m)
WHERE	(W|w)(H|h)(E|e)(R|r)(E|e)
CREATE (C|c)(R|r)(E|e)(A|a)(T|t)(E|e)
COLUMN	(C|c)(O|o)(L|l)(U|u)(M|m)(N|n)
TABLE (T|t)(A|a)(B|b)(L|l)(E|e)
PRIMARY_KEY PRIMARY(" ")*KEY
DELETE  (D|d)(E|e)(L|l)(E|e)(T|t)(E|e)
UPDATE  (U|u)(P|p)(D|d)(A|a)(T|t)(E|e)
INT (I|i)(N|n)(T|t)
VARCHAR (V|v)(A|a)(R|r)(C|c)(H|h)(A|a)(R|r)
DATE (D|d)(A|a)(T|t)(E|e)
DATATYPE ({INT}|{VARCHAR}|{DATE})
SET 	(S|s)(E|e)(T|t)
TRUE    "TRUE"
FALSE   "FALSE"
ID      [a-zA-Z][a-zA-Z0-9_-]*
NUM     [1-9][0-9]*

%%


{SELECT}      { return SELECT; }
{FROM}        { return FROM; }
{WHERE}       { return WHERE; }
{CREATE}      { return CREATE; }
{ADD}		{return ADD;}
{ALTER}		{return ALTER;}
{DROP}		{return DROP;}
{TRUE}        { return TRUE; }
{FALSE}       { return FALSE; }
{TABLE}             { return TABLE; }
{DATATYPE}   { return DATATYPE; }
{PRIMARY_KEY}    { return PRIMARY_KEY; }

{DELETE}      { return DELETE; }
{UPDATE}      { return UPDATE; }
{SET}         { return SET; }
{ID} {
    yylval.strval = malloc(strlen(yytext) + 1); // allocate memory for the string
    strcpy(yylval.strval, yytext); // copy the string into the allocated memory
    return ID;
}
{NUM}         { return NUM; }
","           { return VIRG; }
"="           { return EGAL; }
"<"           { return INF; }
">"           { return SUP; }
"<="          { return INFEGAL; }
">="          { return SUPEGAL; }
"=="          { return EGAL_EQUAL; }
"("           { return PARENTHESE_OUVRANTE; }
")"           { return PARENTHESE_FERMANTE; }
"|"           { return OU; }
"&"           { return ET; }

"*"           { return ETOILE; }
"+"           { return PLUS; }
"-"           { return MOINS; }
"/"           { return DIV; }
"."           { return POINT; }
"'"           { return APOSTROPHE; }
";"           { return POINTVIRGULE; }

[ \t\n]+    { /* ignore whitespace */ }
.           { fprintf(stderr, "Unknown character: %s\n", yytext); }

%%

