CC = gcc -ansi -pedantic
CFLAGS = -Wall -g
OBJECTS = lex.yy.o y.tab.o compilador.o tablashash.o printNASM.o

all: $(OBJECTS)
	$(CC) $(CFLAGS) -o alfa $(OBJECTS)
compilador.o: compilador.c y.tab.h
	$(CC) $(CFLAGS) -c compilador.c
printNASM.o: printNASM.c printNASM.h
	$(CC) $(CFLAGS) -c printNASM.c
tablashash.o: tablashash.c tablashash.h
	$(CC) $(CFLAGS) -c tablashash.c
lex.yy.o: lex.yy.c y.tab.h
	$(CC) $(CFLAGS) -c lex.yy.c
y.tab.o: y.tab.c
	$(CC) $(CFLAGS) -c y.tab.c
lex.yy.c: alfa.l
	$ flex alfa.l
y.tab.h: alfa.y
	$ bison -d -y -v alfa.y
clean:
	rm alfa *.o lex.yy.c y.tab.c y.tab.h y.output
