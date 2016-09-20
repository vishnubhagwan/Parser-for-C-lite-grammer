%{
#include <stdio.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror(const char *s);
%}

%token INT ID BOOL

%right '='

%%

start: {
	printf("Program encountered\n");
	} Declarations

Declarations: INT ID {
		 printf("Int declaration encountered\n");
		 printf("Id=%d\n",$2);
	}
	|
	INT ID'['INT']' {
		printf("Int declaration encountered\n");
		printf("Id=%d\n",$2 );
		printf("Size=%d",$3);
	}
	|
	BOOL ID {
		 printf("Boolean declaration encountered\n");
		 printf("Id=%d\n",$2);
	}
	|
	BOOL ID'['BOOL']' {
		printf("Boolean declaration encountered\n");
		printf("Id=%d\n",$2);
		printf("Size=%d\n",$3);
	}
	| Assignment

Assignment: ID '=' {
	printf("Assignment operation encountered\n");
	} Expr';'

Expr: Expr '+' {
	printf("Addition expression encountered\n");
	} Expr
	|
	Expr'-'{
	printf("Subtraction expression encountered\n");
	} Expr
	|
	Expr'*'{
	printf("Multiplication expression encountered\n");
	} Expr
	|
	Expr'/'{
	printf("Division expression encountered\n");
	} Expr
	|
	Expr'%'{
	printf("Modulus expression encountered\n");
	} Expr
	| INT
	| BOOL;

%%

int main(int argc, char **argv)
{
	FILE* outfile = fopen("flex_output.txt", "w");
	if ( argc > 1 )
		yyin = fopen(argv[1], "r");
	else
		yyin = stdin;
	yylex(); int flag = yyparse();
	fclose(outfile);
	if (flag == 0)
		printf("Success\n");
	else
		printf("Syntax error\n");
	return 0;
}

void yyerror (char const *s) {
	fprintf (stderr, "%s\n", s);
}

