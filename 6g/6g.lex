%{
	#include <stdio.h>
	#include <string.h>

	int line_num = 0;
%}

%%
[int|float|char|if|else|while|for|return]	  	 { printf("Keyword: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*                                   { printf("Identifier: %s\n", yytext); }
[0-9]+(\.[0-9]+)?                                        { printf("Number: %s\n", yytext); }
[==|!=|<=|>=|=|<|>]		                         { printf("Operator: %s\n", yytext); }
[+|-|*|/]                                                { printf("Operator: %s\n", yytext); }
[(){};,]			                         { printf("Punctuation: %s\n", yytext); }
\"([^\\\"]|\\.)*\"                                       { printf("String literal: %s\n", yytext); }
[ \t]+                                                   { /* Ignore whitespace */ }
\n                                                       { line_num++; }
.                                                        { printf("Unknown token: %s\n", yytext); }
%%

int main() {
    	printf("Starting lexical analysis...\n");
    	yylex();
	printf("Lexical analysis complete.\n");
	printf("Total Lines Analyzed: %d\n", line_num);	
    	return 0;
}

int yywrap() {
    return 1;
}
