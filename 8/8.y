%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "y.tab.h"
	void yyerror(char *s);
	int yylex();
%}

%token Zero One

%%
stmt: S			{ printf("%d is accepted\n", $1); };
S:S A | A;
A:Zero Zero | One One;
%%

int main() {
	return yyparse();	
}

void yyerror(char *s) {
	fprintf(stderr, "Error: %s\n", s);
}
