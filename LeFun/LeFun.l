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
"leplus"    { yylval.fn= 4; return OP; }
"lemoins"   { yylval.fn= 5; return OP ;}
"lefois"    { yylval.fn= 6; return OP; }
"lediviseur" { yylval.fn= 7; return OP ;}

 /* keywords */
"le;"       {return(FDS);}
"lesi" { return IF; }
"lealors" { return THEN; }
"lesinon" { return ELSE; }
"letantque" { return WHILE; }
"lefait" { return DO; }

"laracine" { yylval.fn = B_sqrt; return FUNC; }
"lexp" { yylval.fn = B_exp; return FUNC; }
"lelog" { yylval.fn = B_log; return FUNC; }
"leprint" { yylval.fn = B_print; return FUNC; }

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