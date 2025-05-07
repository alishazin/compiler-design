%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <ctype.h>

int yylex(void);
void yyerror(const char *s);

typedef struct ast {
    int nodetype;
    struct ast *left;
    struct ast *right;
    int value;
} AST;

typedef struct tac {
    char code[100];
    char result[10];
    char arg1[10];
    char op;
    char arg2[10];
    struct tac *next;
} TAC;

AST *new_node(int nodetype, AST *left, AST *right, int value);
int generate_code(AST *node);
void append_code(const char *fmt, ...);
void print_tac();
void optimize_code();
void print_optimized_tac();
int is_number(const char *s);

int tempCount = 1;
TAC *head = NULL, *tail = NULL;
%}

%union {
    int ival;
    struct ast* node;
}

%token <ival> NUMBER
%type <node> expr

%left '+' '-'
%left '*' '/'

%%
input:
    expr '\n' {
        tempCount = 1;
        generate_code($1);
        printf("Three Address Code:\n");
        print_tac();

        optimize_code();
        print_optimized_tac();
    }
    ;

expr:
    expr '+' expr   { $$ = new_node('+', $1, $3, 0); }
  | expr '-' expr   { $$ = new_node('-', $1, $3, 0); }
  | expr '*' expr   { $$ = new_node('*', $1, $3, 0); }
  | expr '/' expr   { $$ = new_node('/', $1, $3, 0); }
  | NUMBER          { $$ = new_node('N', NULL, NULL, $1); }
  | '(' expr ')'    { $$ = $2; }
  ;
%%

AST *new_node(int nodetype, AST *left, AST *right, int value) {
    AST *node = (AST *)malloc(sizeof(AST));
    node->nodetype = nodetype;
    node->left = left;
    node->right = right;
    node->value = value;
    return node;
}

int generate_code(AST *node) {
    if (!node) return -1;

    if (node->nodetype == 'N') {
        int t = tempCount++;
        append_code("t%d = %d", t, node->value);
        return t;
    }

    int left = generate_code(node->left);
    int right = generate_code(node->right);
    int result = tempCount++;

    append_code("t%d = t%d %c t%d", result, left, node->nodetype, right);
    return result;
}

void append_code(const char *fmt, ...) {
    TAC *new_code = (TAC *)malloc(sizeof(TAC));
    va_list args;
    va_start(args, fmt);
    vsnprintf(new_code->code, sizeof(new_code->code), fmt, args);
    va_end(args);
    new_code->next = NULL;

    // Try to parse components (not all lines will have them, but we'll try)
    sscanf(new_code->code, "%[^= ] = %[^ ] %c %s", new_code->result, new_code->arg1, &new_code->op, new_code->arg2);

    if (!head) head = tail = new_code;
    else {
        tail->next = new_code;
        tail = new_code;
    }
}

void print_tac() {
    TAC *curr = head;
    while (curr) {
        printf("%s\n", curr->code);
        curr = curr->next;
    }
}

int is_number(const char *s) {
    for (int i = 0; s[i]; i++)
        if (!isdigit(s[i])) return 0;
    return 1;
}

void optimize_code() {
    TAC *curr = head;
    while (curr) {
        // Constant folding: t1 = 2 + 3
        if (is_number(curr->arg1) && is_number(curr->arg2)) {
            int a = atoi(curr->arg1);
            int b = atoi(curr->arg2);
            int res = 0;
            switch (curr->op) {
                case '+': res = a + b; break;
                case '-': res = a - b; break;
                case '*': res = a * b; break;
                case '/': res = b != 0 ? a / b : 0; break;
            }
            sprintf(curr->code, "%s = %d", curr->result, res);
        }

        // Algebraic simplifications
        else if (curr->op == '+' && is_number(curr->arg2) && atoi(curr->arg2) == 0) {
            sprintf(curr->code, "%s = %s", curr->result, curr->arg1);
        }
        else if (curr->op == '*' && is_number(curr->arg2)) {
            int val = atoi(curr->arg2);
            if (val == 1)
                sprintf(curr->code, "%s = %s", curr->result, curr->arg1);
            else if (val == 0)
                sprintf(curr->code, "%s = 0", curr->result);
        }

        curr = curr->next;
    }
}

void print_optimized_tac() {
    printf("\nOptimized Three Address Code:\n");
    TAC *curr = head;
    while (curr) {
        printf("%s\n", curr->code);
        curr = curr->next;
    }
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter an arithmetic expression:\n");
    yyparse();
    return 0;
}