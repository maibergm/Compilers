%{
#  include <stdio.h>
int yylex();
int oneSet;
void yyerror(char *s);
%}

/* declare tokens */
%token ONE
%token FIVE TEN FIFTY HUNDRED FIVEHUNDRED THOUSAND ABS
%token EOL EL
%%
calclist: /* nothing */
 | calclist start EOL { printf("%d\n", $2); }
 | calclist ti EOL { printf("%d\n", $2); }

 ; 





ti: start
 | ti ONE {$$ = $1 + 1;}
 /* ALL CASES FOR 5 */
 | ONE FIVE {$$ = +4;}
 | ti ONE FIVE {$$ = $1 +4;}
 | ti FIVE {$$ = $1 + 5;}
 /* ALL CASES FOR 10 */
 | ONE TEN {$$ = +9;}
 | ti ONE TEN {$$ = $1 + 9;}
 | ti TEN {$$ = $1 + 10;}
 /* ALL CASES FOR 50  */
 | TEN FIFTY {$$ = +40;}
 | ti TEN FIFTY {$$ = $1 + 40;}
 | ti FIFTY {$$ = $1 + 50;}
 /* ALL CASES FOR 100 */
 | TEN HUNDRED {$$ = +90;}
 | ti TEN HUNDRED {$$ = $1 + 90;}
 | ti HUNDRED {$$ = $1 + 100;}
 /* ALL CASES FOR 500 */
 | HUNDRED FIVEHUNDRED {$$ = +400;}
 | ti HUNDRED FIVEHUNDRED {$$ = $1 + 400;}
 | ti FIVEHUNDRED { $$ = $1 + 500;}

 /*  ALL CASES FOR 1000     */
 | HUNDRED THOUSAND { $$ = +900;}
 | ti HUNDRED THOUSAND {$$ = $1 + 900;}
 | ti THOUSAND {$$ = $1 + 1000;}
 | HUNDRED THOUSAND HUNDRED HUNDRED{ yyerror("syntax error");return; }
 ;



 start: ONE | FIVE | TEN | FIFTY | HUNDRED | FIVEHUNDRED | THOUSAND 
 |ABS ONE { $$ = $2;}
 |ABS FIVE { $$ = $2;}
 |ABS TEN { $$ = $2;}
 |ABS FIFTY { $$ = $2;}
 |ABS HUNDRED { $$ = $2;}
 |ABS FIVEHUNDRED { $$ = $2;}
 |ABS THOUSAND { $$ = $2;}
 ;
%%
int main()
{
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "%s\n", s);
}








