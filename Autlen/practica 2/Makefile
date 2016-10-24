CC = gcc -ansi -pedantic
CFLAGS = -Wall -g


all: lex.yy.o $(OBJECTS)
	$(CC) $(CFLAGS) -o pruebaMorfo lex.yy.o $(OBJECTS)
lex.yy.o: lex.yy.c
	$(CC) $(CFLAGS) -c lex.yy.c
lex.yy.c: silvia.l
	$flex silvia.l
clean:
	rm pruebaMorfo  lex.yy.o
