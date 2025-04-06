%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char* s);
int yylex(void);
float final_result = 0.0;
%}

%union {
    char* str;
}

%token <str> ID NUM
%token SI VINAY
%type <str> stmt expr

%%

program:
    stmt
;

stmt:
    ID '=' expr ';' {
        printf("\n[Three Address Code]\n%s = %s\n", $1, $3);

        if (strncmp($3, "(", 1) == 0 && strstr($3, "*") && strstr($3, "/100")) {
            char P[32], R[32], T[32];
            sscanf($3, "(%[^*]*%[^*]*%[^)]*)/100", P, R, T);
            printf("\n[Optimized Instructions]\nSIMPLINT %s = %s, %s, %s\n", $1, P, R, T);
        }

        printf("\n[Evaluated Result] %s = %.2f\n", $1, final_result);
        printf("\n[Final Code]\nSTORE %s\n", $1);
    }
    |
    SI ID '=' NUM ',' NUM ',' NUM ';' {
        float p = atof($4);
        float t = atof($6);
        float r = atof($8);
        final_result = (p * r * t) / 100;

        printf("\n[Three Address Code]\nt1 = %.2f * %.2f\n", p, r);
        printf("t2 = t1 * %.2f\n", t);
        printf("%s = t2 / 100\n", $2);

        printf("\n[Optimized Instructions]\nSI %s = %s, %s, %s\n", $2, $4, $6, $8);
        printf("\n[Evaluated Result] %s = %.2f\n", $2, final_result);
        printf("\n[Final Code]\nSTORE %s\n", $2);
    }
    |
    VINAY ID '=' NUM ',' NUM ',' NUM ';' {
        float b = atof($4);
        float c = atof($6);
        float t = atof($8);
        final_result = b + c * t;

        printf("\n[Three Address Code]\nt1 = %.2f * %.2f\n", c, t);
        printf("t2 = %.2f + t1\n", b);
        printf("%s = t2\n", $2);

        printf("\n[Optimized Instructions]\nVINAY %s = %s, %s, %s\n", $2, $4, $6, $8);
        printf("\n[Evaluated Result] %s = %.2f\n", $2, final_result);
        printf("\n[Final Code]\nSTORE %s\n", $2);
    }
;

expr:
    '(' NUM '*' NUM '*' NUM ')' '/' NUM {
        float p = atof($2);
        float r = atof($4);
        float t = atof($6);
        float d = atof($9);
        final_result = (p * r * t) / d;

        printf("\n[Evaluated Result] = %.2f\n", final_result);

        char* buf = (char*)malloc(128);
        sprintf(buf, "(%s*%s*%s)/%s", $2, $4, $6, $9);
        $$ = buf;
    }
;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}
