


%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
typedef struct ast {
    int nodetype;
    struct ast *left;
    struct ast *right;
    int value;
} AST;

AST *new_node(int nodetype, AST *left, AST *right, int value);
void print_ast(AST *node, int level);
void generate_code(AST *node);
void yyerror(const char *s);
int tempCount = 1;
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
        printf("Abstract Syntax Tree:\n");
        print_ast($1, 0);
        printf("\nThree Address Code:\n");
        generate_code($1);
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

void print_ast(AST *node, int level) {
    if (!node) return;
    for (int i = 0; i < level; i++) printf("  ");
    if (node->nodetype == 'N') {
        printf("NUMBER(%d)\n", node->value);
    } else {
        printf("OP('%c')\n", node->nodetype);
        print_ast(node->left, level + 1);
        print_ast(node->right, level + 1);
    }
}

void generate_code(AST *node) {
    if (!node) return;

    if (node->nodetype == 'N') {
        printf("t%d = %d\n", tempCount, node->value);
        tempCount++;
        return;
    }

    generate_code(node->left);
    int leftTemp = tempCount - 1;

    generate_code(node->right);
    int rightTemp = tempCount - 1;

    printf("t%d = t%d %c t%d\n", tempCount, leftTemp, node->nodetype, rightTemp);
    tempCount++;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
int main() {
    printf("Enter an arithmetic expression:\n");
    yyparse();
    return 0;
}
