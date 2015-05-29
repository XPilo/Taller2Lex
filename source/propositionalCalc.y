%{
void yyerror (char * s);
#include <stdio.h>
#include <stdlib.h>
%}

%start line
%token exit_command

%%

line : exit_command       {exit(EXIT_SUCCESS);}
     ;  

%%

int main (void) {
  
  return yyparse();
}

void yyerror(char *s) {
  fprintf(stderr, "%s\n", s);
}
