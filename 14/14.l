%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+            { yylval.ival = atoi(yytext); return NUMBER; }
[ \t]             ; // ignore whitespace
\n                { return '\n'; }
.                 { return yytext[0]; }

%%

int yywrap() { return 1; }
