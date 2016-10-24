CC = gcc -ansi -pedantic
CFLAGS = -O3
EXE = ejercicio3a ejercicio3b ejercicio4a ejercicio4b ejercicio8 ejercicio10

all : $(EXE) limpia

.PHONY : clean
clean :
	rm -f *.o core $(EXE)
limpia:
	rm -f *.o
$(EXE) : % : %.o
		@ echo "#---------------------------"
		@ echo "# Generando $@ "
		@ echo "# Depende de $^"
		@ echo "# Ha cambiado $<"
		$(CC) $(CFLAGS) -o $@ $@.o -lpthread

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
