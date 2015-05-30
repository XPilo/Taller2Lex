%{
    void yyerror(char *);
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void);
    int sym[26];
%}

%token INTEGER VARIABLE PRINT EXIT TRUE FALSE EVAL CONDITIONAL IFF
%left '+' '-'
%left '*' '/'
%left '&' '|'
%left '!' '<' '>' CONDITIONAL IFF
   
%%

program:
          program statement '\n'  {;}
        |
        ;
         
statement:
          expr
        | PRINT expr                 {
                                       if($2 > 0)
                                         printf("true\n");
                                       else
                                         printf("false\n");
                                     }
        | EXIT                       {exit(EXIT_SUCCESS);}
        | VARIABLE ':' expr          {sym[$1] = $3;}
        ;

expr:
          comparator                 {$$ = $1;}
        | mathExpr                   {$$ = $1;}
        | EVAL logicValExpr          {$$ = $2;}
        ;

comparator:
          mathExpr '<' mathExpr      {$$ = ($1 < $3);}
        | mathExpr '>' mathExpr      {$$ = ($1 > $3);}
        | mathExpr '=' mathExpr      {$$ = ($1 == $3);}
        | mathExpr '<' '=' mathExpr  {$$ = ($1 <= $4);}
        | mathExpr '>' '=' mathExpr  {$$ = ($1 >= $4);}
        | mathExpr '!' '=' mathExpr  {$$ = ($1 != $4);}
        ;

mathExpr:
          term                       {$$ = $1;}
        | mathExpr '+' mathExpr      {$$ = $1 + $3;}
        | mathExpr '-' mathExpr      {$$ = $1 - $3;}
        | mathExpr '*' mathExpr      {$$ = $1 * $3;}
        | mathExpr '/' mathExpr      {$$ = $1 / $3;}
        | '(' mathExpr ')'           {$$ = $2;}
        ;

logicValExpr:
          term                                  {$$ = $1;}
        | '!' logicValExpr                      {$$ = !$2;}
        | logicValExpr '&' logicValExpr         {$$ = $1 & $3;}
        | logicValExpr '|' logicValExpr         {$$ = $1 | $3;}
        | logicValExpr CONDITIONAL logicValExpr {$$ = (!$1) | $3;}
        | logicValExpr IFF logicValExpr         {$$ = $1 == $3;}
        | '(' logicValExpr ')'                  {$$ = $2;}
        ;

term:
          INTEGER                    {$$ = $1;}
        | VARIABLE                   {$$ = sym[$1];}
        | constant                   {$$ = $1;}
        ;

constant:
        | TRUE                       {$$ = 1;}
        | FALSE                      {$$ = 0;}
        ;

%%
void yyerror(char *s){
  fprintf(stderr, "%s\n", s);
}

int main(void){
  yyparse();
  return 0;
}
