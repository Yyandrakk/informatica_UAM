CC = gcc -ansi -pedantic
CFLAGS = -Wall -O3 -lpthread
EXE = ej4a ej4b ej5a ej5b ejercicio6 ej8a ej8b ejercicio9

all : $(EXE)

.PHONY : clean
clean :
	rm -f *.o core $(EXE)

$(EXE) : % : %.o
		@ echo "#---------------------------"
		@ echo "# Generando $@ "
		@ echo "# Depende de $^"
		@ echo "# Ha cambiado $<"
		$(CC) $(CFLAGS) -o $@ $@.o

%.o : %.c
			@ echo "#---------------------------"
			@ echo "# Generando $@"
			@ echo "# Depende de $^"
			@ echo "# Ha cambiado $<"
			$(CC) $(CFLAGS) -c $<

info:
				@ echo "-------------------------------------"
				@ echo "Practica realizada por: "
				@ echo "Oscar Garcia de Lara "
				@ echo "Santiago Gomez "
				@ echo "-------------------------------------"
