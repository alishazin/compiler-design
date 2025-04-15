%{

#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);

typedef struct VarList {
        char *name;
        struct VarList *next;
} VarList;

void free_list(VarList *list) {
        while (list) {
                VarList *tmp = list;
                list = list->next;
                free(tmp->name);
                free(tmp);
        }
}

void print_list(VarList *list) {
        printf("Vars declared are ");
        while (list) {
                printf("%s, ", list->name);
                list = list->next;
        }
        printf("\n");
}

%}

%union {
        char *str;
        struct VarList *list;
}

%token <str> ID
%token INT FLOAT CHAR
%type <list> id_list

%%

program:
       decls;

decls:
     decls decl | decl;

decl:
    type id_list ';'    { print_list($2); free_list($2); };

type:
    INT | FLOAT | CHAR;

id_list:
       ID       {
                        VarList *v = malloc(sizeof(VarList));
                        v->name = $1; v->next = NULL;
                        $$ = v;
                }
        | id_list ',' ID        {
                                        VarList *v = malloc(sizeof(VarList));
                                        v->name = $3; v->next = $1;
                                        $$ = v;
                                }
        ;
%%
int main() {
        return yyparse();
}

void yyerror(const char *s) {
        fprintf(stderr, "Syntax Error: %s\n", s);
}
