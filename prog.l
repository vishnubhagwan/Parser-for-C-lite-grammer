%{
#include "prog.tab.h"
#include <stdbool.h>
extern int yylex();
%}

digit	[0-9]
letter	[a-zA-Z]

%%

{digit}+			{ yylval=atoi(yytext); return INT; }
{letter}({letter}|{digit})*	{ yylval=atoi(yytext); return ID; }
\/\/.*					;	/* Ignore one line commments */
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]	;	/* Ignore multi line comments */
[ \t\n]+				;	/* Ignore whitespace */
true {
	yylval.boolConstant = true;
	return T_BoolConstant;
}
false {
	yylval.boolConstant = false;
	return T_BoolConstant;
}
.					;
%%
