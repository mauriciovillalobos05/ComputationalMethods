%{
#include "y.tab.h"
#include <stdlib.h>  
extern int yylval;
%}

%option noyywrap

DIGIT   [0-9]
FNUM    {DIGIT}+\.{DIGIT}+
INUM    {DIGIT}+
IDCHAR  [a-eh-oz]

%%

{FNUM}             { 
                      yylval = 0; 
                      return FNUM;
                    }

{INUM}             { yylval = atoi(yytext); return INUM; }

{IDCHAR}           { yylval = yytext[0]; return ID; }

\/\/.*             { return COMMENT; }

f                  { return FLOATDCL; }
i                  { return INTDCL; }
=                  { return ASSIGN; }
-                  { return SUBTRACT; }
\+                 { return PLUS; }
\*                 { return MULTIPLY; }
\/                 { return DIVIDE; }
p                  { return PRINT; }

[ \t]+             { /* skip whitespace */ }

\n                 { return 0; }  

.                  { return yytext[0]; }

%%
