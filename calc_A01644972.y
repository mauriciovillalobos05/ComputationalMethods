%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin; 

int yylex();
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
%}

%token ID INUM FNUM
%token FLOATDCL INTDCL PRINT ASSIGN
%token PLUS SUBTRACT MULTIPLY DIVIDE
%token COMMENT

%start statement

%%

statement:
    INTDCL ID                  { printf("Declared int variable: %c\n", $2); }
    | FLOATDCL ID                { printf("Declared float variable: %c\n", $2); }
    |  ID ASSIGN expression         { printf("Assigned: %c = %d\n", $1, $3); }
    | PRINT ID                     { printf("Print: %c\n", $2); }
    | expression                   { printf("= %d\n", $1); }
    ;

expression:
      term expression_prime        { $$ = $2 == -1 ? $1 : $2; }
    ;

expression_prime:
      PLUS term expression_prime   { $$ = $2 + ($3 == -1 ? 0 : $3); }
    | SUBTRACT term expression_prime { $$ = -$2 + ($3 == -1 ? 0 : $3); }
    | /* ε */                      { $$ = -1; }
    ;

term:
      factor term_prime            { $$ = $2 == -1 ? $1 : $2; }
    ;

term_prime:
      MULTIPLY factor term_prime   { $$ = $2 * ($3 == -1 ? 1 : $3); }
    | DIVIDE factor term_prime     { $$ = $2 / ($3 == -1 ? 1 : $3); }
    | /* ε */                      { $$ = -1; }
    ;

factor:
      '(' expression ')'           { $$ = $2; }
    | INUM                         { $$ = $1; }
    | FNUM                         { $$ = $1; }
    | ID                           { $$ = $1; } 
    ;

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Could not open file");
            return 1;
        }
        yyin = file;
    }

    return yyparse();
}
