CC = gcc -ansi -pedantic
CFLAGS = -Wall -g
OBJECTS = lex.yy.o y.tab.o 

all: $(OBJECTS)
	$(CC) $(CFLAGS) -o castellano $(OBJECTS)
lex.yy.o: lex.yy.c y.tab.h
	$(CC) $(CFLAGS) -c lex.yy.c
y.tab.o: y.tab.c
	$(CC) $(CFLAGS) -c y.tab.c
lex.yy.c: castellano.l
	$ flex castellano.l
y.tab.h: castellano.y
	$ bison -d -y -v castellano.y
clean:
	rm castellano  *.o *.c *.h
