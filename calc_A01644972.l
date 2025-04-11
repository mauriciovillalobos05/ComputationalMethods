%{
#include "y.tab.h"
#include <stdlib.h>
%}

%option noyywrap

DIGIT   [0-9]
FNUM    {DIGIT}+\.{DIGIT}+
INUM    {DIGIT}+
IDCHAR  [a-egh-hozq-z]

%%

{FNUM}   { yylval.fval = atof(yytext); return FNUM; }
{INUM}   { yylval.fval = atoi(yytext); return INUM; }
{IDCHAR} { yylval.cval = yytext[0]; return ID; }

\/\/.*   { return COMMENT; }

f        { return FLOATDCL; }
i        { return INTDCL; }
=        { return ASSIGN; }
-        { return SUBTRACT; }
\+       { return PLUS; }
\*       { return MULTIPLY; }
\/       { return DIVIDE; }
p        { return PRINT; }

[ \t]+   { /* skip whitespace */ }

\n       { /* skip newline */ }

.        { return yytext[0]; }

%%
