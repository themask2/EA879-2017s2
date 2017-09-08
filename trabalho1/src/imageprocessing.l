
%{
#include <stdlib.h>
#include <string.h>
void yyerror(char *);

#include "y.tab.h"
%}



%%
  
[0-9]+\.*[0-9]*  {
        for(int i = 0; i<yyleng;i++){
          yylval.fval = atof(yytext);
        }
        printf("Achei fator: %f\n",yylval.fval);
        return FATOR;
}


[a-z]  {
        yylval.ival = yytext[0] - 'a';
        return VAR;
       }


\" { return ASPA; }

[a-zA-Z0-9\.]+  {
        for (int i = 0; i < yyleng; i++ )
          yylval.strval[i] = yytext[i];

        yylval.strval[yyleng] = '\0';
        printf ("Achei nome: %s\n", yylval.strval);
        return STRING;
       }

[=]     {
          return IGUAL;
        }

[/]     {
    return DIVISAO; 
}
[*]     {
  return SINAL;
}
\[  {
  printf("abre\n");
  return ABRECOL;
}
\]   {
  printf("fecha\n");
  return FECHACOL;
}


\n   {
         return EOL;
       }

[ \t]+ ;

.     {printf("**%s**\n", yytext);
yyerror("Token nao reconhecido!\n");}

%%

int  yywrap() {
  return 1;
}
