%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+          { yylval = atoi(yytext); return NUMBER; }
[\t ]+          ;  // Ignore whitespace
\n              { return EOL; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return TIMES; }
"/"             { return DIVIDE; }
"("             { return LPAREN; }
")"             { return RPAREN; }

.               { printf("Invalid character: %s\n", yytext); }

%%
