%{
#include "11.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+                  { yylval.ival = atoi(yytext); return NUMBER; }
[\n]                    { return '\n'; }
[ \t]                   ; // skip whitespace
.                       { return yytext[0]; }

%%

int yywrap() { return 1; }