%{
#include <stdio.h>
#include "imageprocessing.h"
#include <FreeImage.h>

void yyerror(char *c);
int yylex(void);

%}
%union {
  char    strval[50];
  int     ival;
  float fval;
}
%token <strval> STRING
%token <ival> VAR IGUAL EOL ASPA 
%token <fval> FATOR
%left SOMA SINAL DIVISAO ABRECOL FECHACOL

%%

PROGRAMA:
        ABRECOL STRING FECHACOL EOL{
          printf("kkk eae men");
        }
        |
        PROGRAMA EXPRESSAO DIVISAO FATOR EOL{
          printf("Entro em divisao");
        }
        |
        PROGRAMA EXPRESSAO SINAL FATOR EOL
        |
        PROGRAMA EXPRESSAO EOL
        |
        ;

EXPRESSAO:
    | STRING IGUAL STRING {
        printf("Copiando %s para %s\n", $3, $1);
        imagem I = abrir_imagem($3);
        printf("Li imagem %d por %d\n", I.width, I.height);
        salvar_imagem($1, &I,54); //o ultimo argumento dessa funçao eh o fator que se multiplica cada pixel
                          }

    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
  FreeImage_Initialise(0);
  yyparse();
  return 0;

}
