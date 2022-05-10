%{
#include <stdio.h>
#define YYSTYPE int
int yyparse();
int yylex();
int yyerror(char *message_erreur);
%}

//on rappelle les symboles terminaux

%token ENTIER
%token PLUS
%token FOIS
%token MOINS
%token DIVISE
%token OUVRIR
%token FERMER 
%token NOUVELLE_LIGNE
%token FLOTTANT
%token IDENT
%token FIN
%token DEBUT




%%  //Régles syntaxiques/grammaticales

programme : DEBUT instruction_liste FIN
instruction_liste :  instruction_liste instruction| instruction
instruction : IDENT assign expression NOUVELLE_LIGNE
expression : ENTIER | FLOTTANT |somme  | multiplication | division | soustraction | paren
somme : expression PLUS expression {$$ = $1+$3;}
soustraction : expression MOINS expression {$$ = $1-$3;}
multiplication : expression FOIS expression {$$=$1*$3;}
division : expression DIVISE expression {$$=$1/$3;}
assign : IDENT '=' expression {$1=$3;}
paren : OUVRIR expression FERMER {$$=$2;}




%%

int yyerror(char *s) {
    printf("yyerror : %s\n",s);
    return 0;
}

int main(void) {
    yyparse();
    return 0;
}