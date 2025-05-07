%{
#include "13.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+          { yylval.ival = atoi(yytext); return NUMBER; }
[ \t]           ; // skip whitespace
[\n]            { return '\n'; }
.               { return yytext[0]; }

%%

int yywrap() { return 1; }