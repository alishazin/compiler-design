#include <stdio.h>
#include <string.h>

char input[50];
int pos = 0;

// Forward declarations
void Expression();
void Term();
void Factor();

// Error flag
int isError = 0;

void Expression() {
    Term();
    while (input[pos] == '+') {
        pos++;
        Term();
    }
}

void Term() {
    Factor();
    while (input[pos] == '*') {
        pos++;
        Factor();
    }
}

void Factor() {
    if (input[pos] == 'a' || input[pos] == 'b') {
        pos++;
    } else if (input[pos] == '(') {
        pos++;
        Expression();
        if (input[pos] == ')') {
            pos++;
        } else {
            isError = 1;
        }
    } else {
        isError = 1;
    }
}

int main() {
    printf("Enter an expression ending with $: ");
    scanf("%s", input);

    Expression();

    if (input[pos] == '$' && !isError) {
        printf("String Accepted\n");
    } else {
        printf("String Not Accepted\n");
    }

    printf("SLR Parsing Finished\n");
    return 0;
}