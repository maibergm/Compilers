%{
# include "romcalc.tab.h"
void yyerror(char *s);
%}

%%
"I"	{ yylval = 1; return ONE; }
"V"	{ yylval = 5; return FIVE; }
"X"	{ yylval = 10; return TEN; }
"L"	{ yylval = 50; return FIFTY; }
"C"     { yylval = 100; return HUNDRED; }
"D"	{ yylval = 500; return FIVEHUNDRED;}
"M"	{ yylval = 1000; return THOUSAND;}
"{"     { return LB; }
"}"     { return RB; }
"+"     { return ADD;}
"-"     { return SUB;}
"*"     { return MUL;}
"/"     { return DIV;}
"|"     { return ABS;}
\n      { return EOL;}
[ \t]   { /* ignore white space */ }
.	{ return;}
%%

