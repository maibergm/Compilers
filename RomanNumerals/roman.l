/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb1-5.l,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */

/* recognize tokens for the calculator and print them out */

%{
# include "roman.tab.h"
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
"|"     { return ABS;}
\n      { return EOL;}
[ \t]   { /* ignore white space */ }
.	{ return;}
%%

