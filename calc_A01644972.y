%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
%}

%token ID INUM FNUM
%token FLOATDCL INTDCL PRINT ASSIGN
%token PLUS SUBTRACT MULTIPLY DIVIDE
%token COMMENT

%left PLUS SUBTRACT
%left MULTIPLY DIVIDE

%start statement

%%

statement:
      ID ASSIGN expression        { printf("Assigned: %c = %d\n", $1, $3); }
    | PRINT ID                    { printf("Print: %c\n", $2); }
    | expression                  { printf("= %d\n", $1); }
    ;

expression:
      term                        { $$ = $1; }
    | expression PLUS term        { $$ = $1 + $3; }
    | expression SUBTRACT term    { $$ = $1 - $3; }
    ;

term:
      factor                      { $$ = $1; }
    | term MULTIPLY factor        { $$ = $1 * $3; }
    | term DIVIDE factor          { $$ = $1 / $3; }
    ;

factor:
      INUM                        { $$ = $1; }
    | '(' expression ')'          { $$ = $2; }
    | ID                          { $$ = $1; }  
    ;

%%

int main() {
    printf("Enter an expression:\n");
    return yyparse();
}
