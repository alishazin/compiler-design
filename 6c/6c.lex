%{
        #include <stdio.h>
        int vow_count = 0, cons_count = 0;
%}

%%
[aeiouAEIOU]    { vow_count++; }
[a-zA-Z]        { cons_count++; }
%%

int main() {

        printf("Enter text (Ctrl + D to stop): ");
        yylex();
        printf("Total Vowels: %d\n", vow_count);
        printf("Total Consonants: %d\n", cons_count);

        return 0;
}