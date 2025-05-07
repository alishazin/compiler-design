#define NUMBER 257
#define PLUS 258
#define MINUS 259
#define TIMES 260
#define DIVIDE 261
#define LPAREN 262
#define RPAREN 263
#define EOL 264
#define UMINUS 265
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union {
	int ival;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;
