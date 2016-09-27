%{
#include <cstdio>
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()
bool flag;
FILE *outfile;
%}

digit [0-9]
alpha [a-zA-Z]

%%
{digit}+					{fprintf( outfile,"Integer\n%s\n", yytext);}
[0-9]+"."[0-9]+					{fprintf( outfile,"Float\n%s\n", yytext);}
if|else|while|for|int|float			{fprintf( outfile,"Keyword\n%s\n", yytext);}
{alpha}[a-zA-Z0-9_]*				{fprintf( outfile,"Identifier\n%s\n", yytext );}
"+"|"-"|"*"|"/"					{fprintf( outfile,"Operator\n%s\n", yytext );}
"="						{fprintf( outfile,"Assignment\n%s\n", yytext );}
"=="|"<"|">"|"<="|">="				{fprintf( outfile,"Comparison\n%s\n", yytext );}
"{"						{fprintf( outfile,"Open-bracket\n%s\n", yytext );}
"}"						{fprintf( outfile,"Close-bracket\n%s\n", yytext );}
"("						{fprintf( outfile,"Open-paren\n%s\n", yytext );}
")"						{fprintf( outfile,"Close-paren\n%s\n", yytext );}
";"						{fprintf( outfile,"Semicolon\n%s\n", yytext );}
\/\/.*						/* Ignore one line commments */
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]		/* Ignore multi line comments */
[ \t\n]+					/* Ignore whitespace */
.						{flag=true;}
%%

int main(int argc, char **argv)
{
	outfile = fopen("flex_output.txt", "w");
	if ( argc > 1 )
		yyin = fopen(argv[1], "r");
	else
		yyin = stdin;
	yylex();
	fclose(outfile);
	if (flag == 0)
		cout << "Success" << endl;
	else
		cout << "Syntax error" << endl;
	return 0;
}
