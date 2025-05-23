%{
#include <stdio.h>
#include <stdlib.h>
%}

%union {
    int ival;
}

%token <ival> NUMBER
%token PLUS MINUS TIMES DIVIDE LPAREN RPAREN EOL
%type <ival> expr

%left PLUS MINUS
%left TIMES DIVIDE
%nonassoc UMINUS

%%

calculation:
    /* empty */
    | calculation expr EOL { printf("Result = %d\n", $2); }
    ;

expr:
      expr PLUS expr     { $$ = $1 + $3; }
    | expr MINUS expr    { $$ = $1 - $3; }
    | expr TIMES expr    { $$ = $1 * $3; }
    | expr DIVIDE expr   {
                            if ($3 == 0) {
                                printf("Error: Division by zero\n");
                                $$ = 0;
                            } else {
                                $$ = $1 / $3;
                            }
                          }
    | LPAREN expr RPAREN { $$ = $2; }
    | MINUS expr %prec UMINUS { $$ = -$2; }
    | NUMBER              { $$ = $1; }
    ;

%%

int main() {
    printf("Enter expressions, one per line (press Ctrl+D to exit):\n");
    yyparse();
    return 0;
}

int yyerror(const char *msg) {
    fprintf(stderr, "Syntax error: %s\n", msg);
    return 0;
}
