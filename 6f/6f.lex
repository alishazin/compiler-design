%{
        #include <stdio.h>
%}

%%
[aA]+[a-zA-Z0-9_ ]*$    { printf("%s is starting with 'a' or 'A'", yytext); }
.*              { printf("%s is not starting with 'a' or 'A'", yytext); }
%%

int main() {

        printf("Enter a text to check (Ctrl + D to stop): \n");
        yylex();
        return 0;
}

int yywrap() { return 1; }
