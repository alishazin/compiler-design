%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

int regCount = 0;
char code[1000];

int getReg() {
    return regCount++;
}

void freeReg() {
    if (regCount > 0) regCount--;
}
%}

%union {
    int ival;
    struct {
        int reg;
        char code[256];
    } val;
}

%token <ival> NUMBER
%type <val> expr

%left '+' '-'
%left '*' '/'

%%

input:
    expr '\n' {
        printf("Generated Code:\n%s", $1.code);
        freeReg();
    }
    ;

expr:
    expr '+' expr {
        int r = getReg();
        sprintf($$.code, "%s%sMOV R%d, R%d\nADD R%d, R%d\n",
            $1.code, $3.code, r, $1.reg, r, $3.reg);
        $$.reg = r;
        freeReg();
        freeReg();
    }
  | expr '-' expr {
        int r = getReg();
        sprintf($$.code, "%s%sMOV R%d, R%d\nSUB R%d, R%d\n",
            $1.code, $3.code, r, $1.reg, r, $3.reg);
        $$.reg = r;
        freeReg();
        freeReg();
    }
  | expr '*' expr {
        int r = getReg();
        sprintf($$.code, "%s%sMOV R%d, R%d\nMUL R%d, R%d\n",
            $1.code, $3.code, r, $1.reg, r, $3.reg);
        $$.reg = r;
        freeReg();
        freeReg();
    }
  | expr '/' expr {
        int r = getReg();
        sprintf($$.code, "%s%sMOV R%d, R%d\nDIV R%d, R%d\n",
            $1.code, $3.code, r, $1.reg, r, $3.reg);
        $$.reg = r;
        freeReg();
        freeReg();
    }
  | NUMBER {
        int r = getReg();
        sprintf($$.code, "MOV R%d, %d\n", r, $1);
        $$.reg = r;
    }
  | '(' expr ')' {
        $$ = $2;
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter an arithmetic expression:\n");
    yyparse();
    return 0;
}