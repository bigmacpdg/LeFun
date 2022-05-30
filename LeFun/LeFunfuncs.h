/* interface to the lexer */
extern int yylineno; /* from lexer */
void yyerror(char *s);

/* symbol table */
struct symbol { /* a variable name */
 char *name;
 double value;
 struct ast *func; /* stmt for the function */
 struct symlist *syms; /* list of dummy args */
};

/* simple symtab of fixed size */
#define NHASH 9997
struct symbol symtab[NHASH];
struct symbol *lookup(char*);



/* node types for the ast
 * + - * / |
 * 0-7 comparison and ops
 * L expression or statement list
 * I IF statement
 * W WHILE statement
 * N symbol ref
 * = assignment
 * S list of symbols
 * F built in function call
 */ 


/* built-in functions */
enum bifs { B_sqrt = 1,B_exp,B_log,B_print};


/* nodes in the abstract syntax tree */
/* all have common initial nodetype */
struct ast {
 int nodetype;
 struct ast *l;
 struct ast *r;
};

struct fncall { /* built-in function */
 int nodetype; /* type F */
 struct ast *l;
 enum bifs functype;
};


struct flow {int nodetype; /* type I or W */
 struct ast *cond; /* condition */
 struct ast *tl; /* then branch or do list */
 struct ast *el; /* optional else branch */
};

struct numval {
 int nodetype; /* type K */
 double number;
};

struct symref {
 int nodetype; /* type N */
 struct symbol *s;
};

struct symasgn {
 int nodetype; /* type = */
 struct symbol *s;
 struct ast *v; /* value */
};

struct symlist {
 struct symbol *sym;
 struct symlist *next;
};

struct symlist *newsymlist(struct symbol *sym, struct symlist *next);
void symlistfree(struct symlist *sl);


/* build an AST */
struct ast *newast(int nodetype, struct ast *l, struct ast *r);
struct ast *newcmp(int cmptype, struct ast *l, struct ast *r);
struct ast *newop(int optype, struct ast *l, struct ast *r);
struct ast *newfunc(int functype, struct ast *l);
struct ast *newref(struct symbol *s);
struct ast *newasgn(struct symbol *s, struct ast *v);
struct ast *newnum(double d);
struct ast *newflow(int nodetype, struct ast *cond, struct ast *tl, struct ast *tr);


/* evaluate an AST */
double eval(struct ast *);

/* delete and free an AST */
void treefree(struct ast *);

