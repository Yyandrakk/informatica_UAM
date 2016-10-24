CC = gcc -ansi -pedantic
CFLAGS = -Wall -g


all: lex.yy.o $(OBJECTS)
	$(CC) $(CFLAGS) -o pruebaMorfo lex.yy.o $(OBJECTS)
lex.yy.o: lex.yy.c tokens.h
	$(CC) $(CFLAGS) -c lex.yy.c
lex.yy.c: alfa.l
	$flex alfa.l
clean:
	rm pruebaMorfo  lex.yy.o lex.yy.c
