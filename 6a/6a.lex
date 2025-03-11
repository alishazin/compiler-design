%{
        #include <stdio.h>
        int pos_count = 0, neg_count = 0;
%}

%%
[0-9]+  { pos_count++; }
-[0-9]+ { neg_count++; }
%%

int main() {

        printf("Enter Numbers (Ctrl + D to stop): ");
        yylex();
        printf("Positive Count: %d\n", pos_count);
        printf("Negative Count: %d\n", neg_count);

        return 0;
}

int yywrap() {
        printf("End\n");
        return 1;
}