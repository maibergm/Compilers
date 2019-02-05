%{
int years = 0;
int count = 0;
%}
YEAR [0-9]{2}
DASH -
SPACE [\t\n\ ]+
SPACE2 [\t\n\ ]+
INVALIDYEAR [0-9]{4,}?
COUNTY CE|CN|CW|DL|KE|KK|KY|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|W|WH|WX|WW|G|D|L|C|T
NUMBER [0-9]{7,}?
%%


^{YEAR} 	{if(count = 0) {
			years = atoi(yytext); 
			if(years > 18) {
				years = 100-years;
		      	  	years = years + 18;
					} 
			else {
				years = 18-years;
			     } 
				printf("%d\n",years);
				} 
		else {
			count = 0;
			}
			     }
	
{SPACE}{YEAR} {if(count = 0) {
			years = atoi(yytext); 
			if(years > 18) {
				years = 100-years;
		      	  	years = years + 18;
					} 
			else {
				years = 18-years;
			     } 
				printf("%d\n",years);
				} 
		else {
			count = 0;
			}
			     }

^{INVALIDYEAR}				{printf("INVALID\n");count = 1;}

{DASH}[0-9]+{DASH}				{printf("INVALID\n");}

{DASH}{COUNTY}{DASH}				{}

{DASH}[0-9]{7,}				{printf("INVALID\n");}

. 					{}
\n 					{}

%%

int main()
{
  yylex();
  return 0;
}
