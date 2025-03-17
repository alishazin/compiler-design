%{
	#include <stdio.h>
%}

%%
([+-]?[0-9]*[02468]|[+-]?[0-9]*[02468]\.[0]+)$ 	{ printf("%s is Even\n", yytext); }
([+-]?[0-9]*[13579]|[+-]?[0-9]*[13579]\.[0]+)$ 	{ printf("%s is Odd\n", yytext); }
.*		     				{ printf("%s is not in an integer format\n", yytext); }
%%

int main() {

	printf("Enter one integer at a time (Ctrl + D to stop): \n");
	yylex();
	return 0;
}

int yywrap() {return 1;}
