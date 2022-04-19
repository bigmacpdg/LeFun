%{ 
#include <string.h> 
enum {INTEGER=1,REAL,IDENT,NEW_LINE,UNKNOWN};
char globalValue[0x100];
%}

%option noyywrap 
integer [0-9]+ 
real [0-9]+\.[0-9]*|\.[0-9]+ 
ident [a-zA-Z_][0-9a-zA-Z_]* 

%% 

{real}      { strcpy(globalValue,yytext); return(REAL); }
{integer}   { strcpy(globalValue,yytext); return(INTEGER); } 
{ident}     { strcpy(globalValue,yytext); return(IDENT); } 
\n          { strcpy(globalValue,yytext); return(NEW_LINE); } 
.           { strcpy(globalValue,yytext); return(UNKNOWN); } 

%% 

int
main(void)
{
int token;
do
{
token=yylex();
switch(token)
{
case 0: fprintf(stderr,"END_OF_FILE\n"); break;
case INTEGER: fprintf(stderr,"INTEGER [%s]\n",globalValue); break;
case REAL: fprintf(stderr,"REAL [%s]\n",globalValue); break;
case IDENT: fprintf(stderr,"IDENT [%s]\n",globalValue); break;
case NEW_LINE: fprintf(stderr,"NEW_LINE [%s]\n",globalValue); break;
case UNKNOWN: fprintf(stderr,"UNKNOWN [%s]\n",globalValue); break;
}
} while(token);
return(0);
}