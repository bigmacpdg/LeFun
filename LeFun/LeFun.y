/* calculator with AST */
%{
# include <stdio.h>
# include <stdlib.h>
# include "LeFunfuncs.h"

int yyparse();
int yylex();


%}

%union {
 struct ast *a;
 double d;
 struct symbol *s; /* which symbol */
 struct symlist *sl;
 int fn; /* which function */
}
/* declare tokens */
%token <d> NUMBER
%token <s> NAME
%token <fn> FUNC
%token FDL FDS
%token IF THEN ELSE WHILE DO 
%nonassoc <fn> CMP
%right '='
%left <fn> OP
%type <a> exp stmt list explist


%start calclist

%%

stmt: IF exp THEN list  { $$ = newflow('I', $2, $4, NULL); }
 | IF exp THEN list ELSE list  { $$ = newflow('I', $2, $4, $6); }
 | WHILE exp DO list  { $$ = newflow('W', $2, $4, NULL); }
 | exp 
;

list: /* nothing */ { $$ = NULL; }
 | stmt ';' list { if ($3 == NULL)
 $$ = $1;
 else
 $$ = newast('L', $1, $3);
 };

exp: exp CMP exp { $$ = newcmp($2, $1, $3); }
 | exp OP exp { $$ = newop($2, $1,$3); }
 | '(' exp ')' { $$ = $2; }
 | NUMBER { $$ = newnum($1); }
 | NAME { $$ = newref($1); }
 | NAME '=' exp { $$ = newasgn($1, $3); }
 | FUNC '(' explist ')' { $$ = newfunc($1, $3); }



explist: exp
 | exp ',' explist { $$ = newast('L', $1, $3); }
;



calclist: /* nothing */
 | calclist stmt FDL  {
 printf("= %4.4g\n> ", eval($2));
 treefree($2);
 }
 | calclist error FDL  { yyerror; printf("> "); }
 ;
%% 
