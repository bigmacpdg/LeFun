LeFun:		LeFun.l LeFun.y LeFunfuncs.h
		bison -d LeFun.y
		flex -o LeFun.lex.c LeFun.l
		gcc -o $@ LeFun.tab.c LeFun.lex.c LeFunfuncs.c -lm