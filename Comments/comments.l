%{
int token = 0;
int token2 = 0;
%}
%x C_COMMENT
%%

"{"            { BEGIN(C_COMMENT); token++;}
<C_COMMENT>"}" { BEGIN(INITIAL); token--;}
<C_COMMENT>\n   {}
<C_COMMENT>.    {}
"**".*          {}
"}"		{printf("syntax error\n");return;}
["](.*)["]      {ECHO;}
%%

int main()
{
  yylex();
  if(token == 1) printf("syntax error\n");
  return 0;
}
