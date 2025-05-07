%{
#include <stdio.h>

// Declare yylex and yyerror
int yylex(void);
void yyerror(const char *s);
%}

%token HELLO BYE OTHER

%%
start:
      HELLO   { printf("You said hello!\n"); }
    | BYE     { printf("You said bye!\n"); }
    | OTHER   { printf("Unknown input.\n"); }
    ;
%%

int main(void) {
    printf("Type something (Ctrl+C to quit):\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}