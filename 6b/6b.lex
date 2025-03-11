%{
        #include <stdio.h>
        int word_count = 0, line_count=0, char_count = 0;
%}

%%
[a-zA-Z]+               { word_count++; char_count += yyleng; }
.                       { char_count += yyleng; }
\n                      { line_count++; char_count++; }
%%

int main() {

        printf("Enter text (Ctrl-D to stop):\n");
        yylex();
        printf("Total Words: %d\n", word_count);
        printf("Total Characters: %d\n", char_count);
        printf("Total Lines: %d\n", line_count);

        return 0;
}

int yywrap() {
        printf("------------------------------------\n");
        return 1;
}