CC = gcc -ansi -pedantic
CFLAGS = -Wall -g


all:
	$ bison -d -g -y -v logica.y
	$ flex logica.l
	$(CC) $(CFLAGS) -o logica lex.yy.c y.tab.c

clean:
	rm logica  *.o *.c y.tab.h
