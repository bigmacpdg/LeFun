%{ 
#include <string.h> 
enum {VALUE=1,IDENT,PLUS,MOINS,FOIS,DIVISE,OUVERT,FERMER,DEBUT,FIN};
char globalValue[0x100];
%}

%option noyywrap 

entier [0-9]+ 
reel [0-9]+\.[0-9]*|\.[0-9]+ 
ident [a-zA-Z_][0-9a-zA-Z_]*
%% 

{entier}    {/*  yylval.ival = atoi(yytext); */ return(VALUE);}
{reel}      { /* yylval.fval = atof(yytext);*/ return(VALUE);}

"lemoins"   {return(MOINS);}
"leplus"    { return(PLUS); }
"lefois"    { return(FOIS); }
"gauche"    {return(OUVERT);}
"droite"      {return(FERMER);}
"lediviseur" { return(DIVISE); }
"ledebut"   {return(DEBUT);}
"lafin"     {return(FIN);}
{ident}     {return(IDENT); } 
[ \t\n]+    {;}

%%

int main(void)
 {
 int token;
 do
 {
 token=yylex();
 switch(token)
 {
 case 0:         fprintf(stderr,"FIN_DE_CODE\n"); break;
 case VALUE:   fprintf(stderr,"VALUE [%s]\n",globalValue); break;
 case FERMER:   fprintf(stderr,"FERMER [%s]\n",globalValue); break;
 case OUVERT:   fprintf(stderr,"OUVERT [%s]\n",globalValue); break;
 case IDENT:     fprintf(stderr,"IDENT [%s]\n",globalValue); break;
 case PLUS:  fprintf(stderr,"PLUS [%s]\n",globalValue); break; 
 case MOINS:  fprintf(stderr,"MOINS [%s]\n",globalValue); break;
 case FOIS:  fprintf(stderr,"FOIS [%s]\n",globalValue); break;
 case DIVISE:  fprintf(stderr,"DIVISE [%s]\n",globalValue); break;
 case DEBUT: fprintf(stderr,"DEBUT [%s]\n",globalValue); break;
 case FIN: fprintf(stderr,"FIN [%s]\n",globalValue); break;

 }
} while(token);
 return(0);
 }  