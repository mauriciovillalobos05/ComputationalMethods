all:
	lex calc_A01644972.l
	yacc -d calc_A01644972.y
	gcc y.tab.c lex.yy.c -o calc_A01644972

clean:
	rm -rf calc_A01644972
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch
