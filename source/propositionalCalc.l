%{
#include "propositionalCalc.tab.h"
%}

%%

"print"           {return PRINT;}
"exit"            {return EXIT;}
"true"            {return TRUE;}
"false"           {return FALSE;}
"eval"            {return EVAL;}
"->"              {return CONDITIONAL;}
"<->"             {return IFF;}
[a-z]             {yylval = *yytext - 'a'; return VARIABLE;}
[0-9]+            {yylval = atoi(yytext); return INTEGER;}
[ \t]             ;
[-+*/()\n:]       {return *yytext;}
[<>=!]            {return *yytext;}
[&|]              {return *yytext;}

.                 {ECHO; yyerror ("unexpected character");}

%%

int yywrap (void) {return 1;}
