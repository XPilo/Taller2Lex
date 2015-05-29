# Taller2Lex
Repositorio creado para el taller numero 2 de lenguajes de programación Universidad Nacional de Colombia

La idea es crear un lenguaje de programación para lógica proposicional usando las herramientas Lex y Yacc.

Lenguaje propuesto:

Operadores lógicos:

Negación: ! <br>
Conjunción: & <br>
Disyunción: | <br>
Condicional: -> <br>
Bicondicional: <-> <br>
Disyunción excluyente: ^ <br>

Ejemplos:

var p : true <br>
var q : 3 < 5 <br>
var r : q & p <br>
print (p | q) -> r <br>
p : !!!(p|q) <br>
