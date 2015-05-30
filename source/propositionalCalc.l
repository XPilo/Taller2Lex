%{
#include "y.tab.h"
%}

%%

"print"           {return PRINT;}
"exit"            {return EXIT;}
[a-z]             {yylval = *yytext - 'a'; return VARIABLE;}
[0-9]+            {yylval = atoi(yytext); return INTEGER;}
[ \t]             ;
[-+*/()\n:]       {return *yytext;}
[<>=!]            {return *yytext;}

.                 {ECHO; yyerror ("unexpected character");}

%%

int yywrap (void) {return 1;}
