CC = gcc -ansi -pedantic
CFLAGS = -Wall -g
OBJECTS = tablashash.o 

all: main.o $(OBJECTS)
	$(CC) $(CFLAGS) -o prueba_tabla main.o $(OBJECTS)
main.o: main.c tablashash.h
	$(CC) $(CFLAGS) -c main.c
tablashash.o: tablashash.c tablashash.h simbandinclude.h
	$(CC) $(CFLAGS) -c tablashash.c
clean:
	rm prueba_tabla  main.o tablashash.o


