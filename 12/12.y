%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

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
    struct tac *next;
} TAC;

AST *new_node(int nodetype, AST *left, AST *right, int value);
int generate_code(AST *node);
void print_tac();

int tempCount = 1;
TAC *head = NULL, *tail = NULL;

void append_code(const char *fmt, ...) {
    TAC *new_code = (TAC *)malloc(sizeof(TAC));
    va_list args;
    va_start(args, fmt);
    vsnprintf(new_code->code, sizeof(new_code->code), fmt, args);
    va_end(args);
    new_code->next = NULL;

    if (!head) head = tail = new_code;
    else {
        tail->next = new_code;
        tail = new_code;
    }
}
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

void print_tac() {
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