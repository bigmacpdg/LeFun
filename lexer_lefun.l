%{ 
#include <string.h> 
enum {INTEGER=1,REAL,IDENT,NEW_LINE,UNKNOWN};
char globalValue[0x100];
%}

%option noyywrap 

blanc  [ \t\n]+
entier [0-9]+ 
reel [0-9]+\.[0-9]*|\.[0-9]+ 
ident [a-zA-Z_][0-9a-zA-Z_]*
%% 



{blanc}     { /* ignore */ }
{reel}      { return(FLOTTANT); }
{entier}    { yylval = atoi(yytext); return(ENTIER); } 
{ident}     { return(IDENT); } 
"\n "       { return(NOUVELLE_LIGNE); }
"leplus"    { return(PLUS); }
"lemoins"   { return(MOINS); }
"lefois"    { return(FOIS); }
"lediviseur" { return(DIVISE); }
"la("    { return(OUVRIR); }
"la)"    { return(FERMER); }
"ledebut"     {return(DEBUT);}
"lafin"       {return(FIN);}

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
 case ENTIER:   fprintf(stderr,"ENTIER [%s]\n",globalValue); break;
 case REEL:      fprintf(stderr,"REEL [%s]\n",globalValue); break;
 case IDENT:     fprintf(stderr,"IDENT [%s]\n",globalValue); break;
 case NOUVELLE_LIGNE:  fprintf(stderr,"NOUVELLE_LIGNE [%s]\n",globalValue); break;
 case PLUS:  fprintf(stderr,"PLUS [%s]\n",globalValue); break; 
 case MOINS:  fprintf(stderr,"MOINS [%s]\n",globalValue); break;
 case FOIS:  fprintf(stderr,"FOIS [%s]\n",globalValue); break;
 case DIVISE:  fprintf(stderr,"DIVISE [%s]\n",globalValue); break;
 case OUVRIR:  fprintf(stderr,"OUVRIR [%s]\n",globalValue); break;
 case FERMER:  fprintf(stderr,"FERMER [%s]\n",globalValue); break;
 case DEBUT: fprintf(stderr,"DEBUT [%s]\n",globalValue); break;
 case FIN: fprintf(stderr,"FIN [%s]\n",globalValue); break;

 }
} while(token);
 return(0);
 }  