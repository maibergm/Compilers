%{
#  include <stdio.h>
# include <string.h>
int yylex();
void yyerror(char *s);
%}

/* declare tokens */
%token ONE
%token FIVE TEN FIFTY HUNDRED FIVEHUNDRED THOUSAND ABS
%token EOL EL ADD SUB MUL DIV LB RB
%%
calclist: /* nothing */
 | calclist start EOL { printf("%d\n", $2); }
 | calclist ti EOL { char s[1024]; 
		     s[0] = '\0';
	             int total = $2;
			if ( total == 0) {
			strcat(s, "Z"); } 
			if (total < 0) strcat(s, "-");
			while (total >= 1000 || total <= -1000){ 
			strcat(s, "M");
			if (total <= -1000){ 
			 total += 1000; }
			else { 
			total -= 1000; }}

			while (total >= 900 || total <= -900){ 
			strcat(s, "CM"); 
			if (total <= -900){ 
			 total += 900; }
			else { 
			total -= 900; } }

			while (total >= 500 || total <= -500){ 
			strcat(s, "D"); 
			if (total <= -500){ 
			 total += 500; }
			else { 
			total -= 500; } }

			while (total >= 400 || total <= -400){ 
			strcat(s, "CD"); 
			if (total <= -400){ 
			 total += 400; }
			else { 
			total -= 400; } }

			while (total >= 100 || total <= -100){ 
			strcat(s, "C"); 
			if (total <= -100){ 
			 total += 100; }
			else { 
			total -= 100; } }

		        while (total >= 90 || total <= -90){ 
			strcat(s, "XC"); 
			if (total <= -90){ 
			 total += 90; }
			else { 
			total -= 90; } }

			while (total >= 50 || total <= -50){ 
			strcat(s, "L"); 
			if (total <= -50){ 
			 total += 50; }
			else { 
			total -= 50; } }

			while (total >= 40 || total <= -40){ 
			strcat(s, "XL"); 
			if (total <= -40){ 
			 total += 40; }
			else { 
			total -= 40; } }

			while (total >= 10 || total <= -10){ 
			strcat(s, "X"); 
			if (total <= -10){ 
			 total += 10; }
			else { 
			total -= 10; } }

			while (total >= 9 || total <= -9){ 
			strcat(s, "IX"); 
			if (total <= -9){ 
			 total += 9; }
			else { 
			total -= 9; } }

			while (total >= 5 || total <= -5){ 
			strcat(s, "V"); 
			if (total <= -5){ 
			 total += 5; }
			else { 
			total -= 5; } }

			while (total >= 4 || total <= -4){ 
			strcat(s, "IV"); 
			if (total <= -4){ 
			 total += 4; }
			else { 
			total -= 4; } }

			while (total >= 1 || total <= -1){ 
			strcat(s, "I"); 
			if (total <= -1){ 
			 total += 1; }
			else { 
			total -= 1; } }
			if(total == 0) {
			printf("%s\n", s);}} 
 ; 




ti: start
 | ti ADD ti {$$ = $1 + $3;}
 | ti SUB ti SUB ti {$$ = $1 - $3 - $5;}
 | ti SUB ti {$$ = $1 - $3;}
 | ti MUL ti {$$ = $1 * $3;}
 | ti DIV ti DIV ti {$$ = $1 / $3 / $5;}
 | ti DIV ti {$$ = $1 / $3;}
 | ti ONE {$$ = $1 + 1;}
 /* ALL CASES FOR 5 */
 | FIVE FIVE { yyerror("syntax error");return; }
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
 |LB ti RB {$$ = $2;}
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








