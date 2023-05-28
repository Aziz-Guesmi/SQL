/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_PROJET_TAB_H_INCLUDED
# define YY_YY_PROJET_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    SELECT = 258,                  /* SELECT  */
    FROM = 259,                    /* FROM  */
    WHERE = 260,                   /* WHERE  */
    CREATE = 261,                  /* CREATE  */
    DELETE = 262,                  /* DELETE  */
    UPDATE = 263,                  /* UPDATE  */
    SET = 264,                     /* SET  */
    VIRG = 265,                    /* VIRG  */
    ETOILE = 266,                  /* ETOILE  */
    EGAL = 267,                    /* EGAL  */
    INF = 268,                     /* INF  */
    SUP = 269,                     /* SUP  */
    INFEGAL = 270,                 /* INFEGAL  */
    SUPEGAL = 271,                 /* SUPEGAL  */
    ET = 272,                      /* ET  */
    OU = 273,                      /* OU  */
    EGAL_EQUAL = 274,              /* EGAL_EQUAL  */
    PARENTHESE_OUVRANTE = 275,     /* PARENTHESE_OUVRANTE  */
    PARENTHESE_FERMANTE = 276,     /* PARENTHESE_FERMANTE  */
    PLUS = 277,                    /* PLUS  */
    MOINS = 278,                   /* MOINS  */
    DIV = 279,                     /* DIV  */
    POINT = 280,                   /* POINT  */
    APOSTROPHE = 281,              /* APOSTROPHE  */
    TRUE = 282,                    /* TRUE  */
    FALSE = 283,                   /* FALSE  */
    TABLE = 284,                   /* TABLE  */
    PRIMARY_KEY = 285,             /* PRIMARY_KEY  */
    SP = 286,                      /* SP  */
    POINTVIRGULE = 287,            /* POINTVIRGULE  */
    ALTER = 288,                   /* ALTER  */
    ADD = 289,                     /* ADD  */
    DROP = 290,                    /* DROP  */
    NUM = 291,                     /* NUM  */
    ID = 292,                      /* ID  */
    DATATYPE = 293                 /* DATATYPE  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 19 "projet.y"

char* strval;
    int numval;
    char** strlist;
    table_info* table;
        char** column_list;



#line 112 "projet.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PROJET_TAB_H_INCLUDED  */
