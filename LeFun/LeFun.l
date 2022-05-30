/* recognize tokens for the calculator */
%option noyywrap nodefault yylineno
%{
#include "LeFunfuncs.h"
#include "LeFun.tab.h"

%}

/* float exponent */
EXP ([Ee][-+]?[0-9]+)
%%
"=" |
"(" |
";" |
"," |
")" { return yytext[0]; }

 /* comparison ops, all are a CMP token */

">" { yylval.fn = 1; return CMP; }
"<" { yylval.fn = 2; return CMP ; }
"==" { yylval.fn = 3; return CMP; }

 /* operators */
"le_plus"    { yylval.fn= 4; return OP; }
"le_moins"   { yylval.fn= 5; return OP ;}
"le_fois"    { yylval.fn= 6; return OP; }
"le_diviseur" { yylval.fn= 7; return OP ;}

 /* keywords */
"le_;"       {return(FDS);}
"le_si" { return IF; }
"le_alors" { return THEN; }
"le_sinon" { return ELSE; }
"le_tant_que" { return WHILE; }
"le_fait" { return DO; }

"la_racine" { yylval.fn = B_sqrt; return FUNC; }
"l_exp" { yylval.fn = B_exp; return FUNC; }
"le_log" { yylval.fn = B_log; return FUNC; }
"le_print" { yylval.fn = B_print; return FUNC; }

 /* names */
[a-zA-Z][a-zA-Z0-9]* { yylval.s = lookup(yytext); return NAME; }
[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}? { yylval.d = atof(yytext); return NUMBER; }
"//".*
[ \t] /* ignore whitespace */
\\\n { printf("c> "); } /* ignore line continuation */
\n { return FDL; }
. { yyerror("Token non défini"); }
%%

int main()
{
 printf("> ");
 return yyparse();
}