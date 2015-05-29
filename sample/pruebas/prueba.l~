%{
    #include <stdlib.h>
    void yyerror(char *);
%}

%%

[a-z]     {printf("%d\n",(yytext[0] - 'a'));}

%%

int yywrap(void){
    return 1;
}              
