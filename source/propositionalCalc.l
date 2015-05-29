%{
#include "propositionalCalc.tab.h"
%}

%%

"exit"        {return exit_command;}

%%

int yywrap(void) { return 1; }
