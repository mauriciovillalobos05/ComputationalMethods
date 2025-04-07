%{
#include <stdio.h>
%}

DIGIT   [0-9]
ID      [a-eh-oz]
FNUM    [0-9]+\.[0-9]+
INUM    [0-9]+

%%
\/\/.*          { printf("COMMENT "); } 
f              { printf("floatdcl "); }
i              { printf("intdcl "); }
=              { printf("assign "); }
-              { printf("subtract "); }
\+            { printf("plus "); }
\*            { printf("multiply "); }
\/             { printf("divide "); }
p              { printf("print "); }
{ID}           { printf("id "); }
{INUM}         { printf("inum "); }
{FNUM}         { printf("fnum "); }
[ \\t\\n]+     { /* Ignore whitespace */ }
.              { printf("Unknown character: %s\n", yytext); }
%%

int main() {
    printf("Enter text to analyze (Ctrl+D to end):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
