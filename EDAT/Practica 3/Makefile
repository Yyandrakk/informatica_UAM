CC = gcc
CFLAGS = -Wall -g -Wextra -pedantic -ansi
LDLIBS = -lodbc

EXE = prestamo usuario opcional

all : $(EXE)

clean :
	rm -f *.o core $(EXE)

$(EXE) : % : %.o odbc.o
