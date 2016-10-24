CC = gcc -ansi -pedantic
CFLAGS = -Wall -g


all:
	$ bison -d -y -v expresiones.y
	$ flex expresiones.l
	$(CC) $(CFLAGS) -o expresiones lex.yy.c y.tab.c

clean:
	rm expresiones  *.o *.c y.tab.h
