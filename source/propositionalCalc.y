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
        program statement '\n'
        |
        ;
         
statement:
        expr
        | PRINT expr              {printf("Printing %d\n", $2);}
        | EXIT                    {exit(EXIT_SUCCESS);}
        | VARIABLE ':' expr       {sym[$1] = $3;}
        ;

expr:
        INTEGER
        | VARIABLE                {$$ =  sym[$1];}
        | expr '+' expr           {$$ = $1 + $3;}
        | expr '-' expr           {$$ = $1 - $3;}
        | expr '*' expr           {$$ = $1 * $3;}
        | expr '/' expr           {$$ = $1 / $3;}
        |'(' expr ')'             {$$ = $2;}
        ;         

%%

void yyerror(char *s){
    fprintf(stderr, "%s\n", s);
}

int main(void){
    yyparse();
    return 0;
}
