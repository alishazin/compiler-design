%{
	#include <stdio.h>

	int is_leap_year(int year) {
		return (year % 400 == 0) || (year%4 == 0 && year%100 != 0);
	}

%}

%%
((\+)?91)?[789][0-9]{9}$ 				{ printf("%s is a mobile number\n", yytext); }
[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ 		{ printf("%s is an email\n", yytext); }
(0[1-9]|[12][0-9]|30)-(0[469]|11)-([0-9]{4})$		{ printf("%s is a date\n", yytext); }
(0[1-9]|[12][0-9]|3[01])-(0[13578]|1[02])-([0-9]{4})$	{ printf("%s is a date\n", yytext); }
(0[1-9]|1[0-9]|2[0-8])-02-([0-9]{4})$			{ printf("%s is a date\n", yytext); }
29-02-([0-9]{4})$					{
								int year = atoi(yytext + 6);
								if (is_leap_year(year)) {
									printf("%s is a date\n", yytext);
								} else {
									printf("Invalid input %s\n", yytext);
								}
							}
.*							{ printf("Invalid input %s\n", yytext); }
%%

int main() {
	
	printf("Enter a mobile number (indian) or email or date(DD-MM-YYY) (Ctrl + D to stop):\n");
	yylex();

	return 0;
}

int yywrap() {return 1;}
