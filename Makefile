mycompiler: parser.tab.o lex.yy.o main.o
	g++ -o mycompiler parser.tab.o lex.yy.o main.o

parser.tab.cpp parser.tab.hpp: parser.y
	bison -d -o parser.tab.cpp parser.y

lex.yy.c: lexer.l
	flex lexer.l

parser.tab.o: parser.tab.cpp
	g++ -c parser.tab.cpp

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

main.o: main.cpp
	g++ -c main.cpp

clean:
	rm -f *.o mycompiler parser.tab.* lex.yy.c
