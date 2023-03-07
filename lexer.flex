%top{
#include "parser.tab.hh"
#define YY_DECL yy::parser::symbol_type yylex()
#include "Node.h"
int lexical_errors = 0;
int lineno = 1;
void print_token(char *t);
void error();
}
%option yylineno noyywrap nounput batch noinput stack
%%

"//".*                  {printf("comment at line %d\n", lineno);}

"+"                     {print_token("PLUSOP ");}
"-"                     {print_token("SUBOP ");}
"*"                     {print_token("MULTOP ");}
"/"                     {print_token("DIVOP ");}

"("                     {print_token("L_PAREN ");}
")"                     {print_token("R_PAREN ");}
"{"                     {print_token("L_CURLY ");}
"}"                     {print_token("R_CURLY ");}
"["                     {print_token("L_SQUARE ");}
"]"                     {print_token("R_SQUARE ");}

"="                     {print_token("ASSIGN ");}
";"                     {print_token("SEMI ");}
","                     {print_token("COMMA ");}
"."                     {print_token("DOT ");}
"_"                     {print_token("USCORE ");}
"!"                     {print_token("BANG ");}

"=="                    {print_token("EQ ");}
"&&"                    {print_token("AND ");}
"||"                    {print_token("OR ");}
"<"                     {print_token("LT ");}
">"                     {print_token("GT ");}

"while"                 {print_token("WHILE ");}
"public"                {print_token("PUBLIC ");}
"static"                {print_token("STATIC ");}
"void"                  {print_token("VOID ");}
"class"                 {print_token("CLASS ");}
"new"                   {print_token("NEW ");}

"System.out.println"    {print_token("PRINTOP ");}
"String"                   {print_token("STR ");}

0|[1-9][0-9]*           {print_token("INT ");}
[a-zA-Z]+               {print_token("ID ");}

[ \t\r]+              {}
[\n]+                   {lineno++;}
.                       { if(!lexical_errors) fprintf(stderr, "Lexical errors found! See the logs below: \n"); error();  lexical_errors = 1;}
<<EOF>>                 return yy::parser::make_END();
%%

void error()
{
    printf("LEX ERROR: token: %s", yytext, lineno);
}

void print_token(char *t)
{
    printf("yytext: %s\ttoken: %s\tlineno: %d\n", yytext, t, lineno);
}