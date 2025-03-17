%{
	#include <stdio.h>
%}

%%
([+-]?[0-9]+|[+-]?[0-9]+\.[0]+)$ 	{
						int num = atoi(yytext);
						if (num%2 == 0) {
							printf("%d is Even\n", num);
						} else {
							printf("%d is Odd\n", num);
						}
					}
.*					{ printf("%s is not in an integer format\n", yytext); }
%%

int main() {

	printf("Enter one integer at a time (Ctrl + D to stop): \n");
	yylex();
	return 0;
}

int yywrap() {return 1;}
