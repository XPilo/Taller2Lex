%{
    void yyerror(char *);
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void);
    int sym[26];
%}

%token INTEGER VARIABLE PRINT EXIT
%left '+' '-'
%left '*' '/'

   
%%

program:
          program statement '\n'  {;}
        |
        ;
         
statement:
          expr
        | PRINT expr              {
                                    if($2==1)
                                      printf("true\n");
                                    else
                                      printf("false\n");
                                    
                                  }
        | EXIT                    {exit(EXIT_SUCCESS);}
        | VARIABLE ':' expr       {sym[$1] = $3;}
        ;

expr:
          comparator              {$$ = $1;}
        | mathExpr                {$$ = $1;}
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
          term                    {$$ = $1;}
        | mathExpr '+' mathExpr   {$$ = $1 + $3;}
        | mathExpr '-' mathExpr   {$$ = $1 - $3;}
        | mathExpr '*' mathExpr   {$$ = $1 * $3;}
        | mathExpr '/' mathExpr   {$$ = $1 / $3;}
        | '(' mathExpr ')'        {$$ = $2;}
        ;

term:
          INTEGER                 {$$ = $1;}
        | VARIABLE                {$$ =  sym[$1];}
        ;

%%
void yyerror(char *s){
  fprintf(stderr, "%s\n", s);
}

int main(void){
  yyparse();
  return 0;
}
