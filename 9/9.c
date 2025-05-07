#include <stdio.h>
#include <string.h>

const char *input;
int pos = 0;

// Forward declarations
int E();
int T();

void error() {
    printf("Rejected: Invalid syntax.\n");
}

// E → T + T
int E() {
    if (T()) {
        if (input[pos] == '+') {
            pos++;
            if (T()) return 1;
            else return 0;
        }
    }
    return 0;
}

// T → a | b
int T() {
    if (input[pos] == 'a' || input[pos] == 'b') {
        pos++;
        return 1;
    }
    return 0;
}

int main() {
    char buffer[100];
    printf("Enter a string (like a+b): ");
    scanf("%s", buffer);
    input = buffer;

    if (E() && input[pos] == '\0') {
        printf("Accepted: Valid syntax.\n");
    } else {
        error();
    }

    return 0;
}