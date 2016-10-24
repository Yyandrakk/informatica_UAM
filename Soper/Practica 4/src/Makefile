CC = gcc -ansi -pedantic
CFLAGS = -O3
EXE = ejercicio1 gestion

all : $(EXE) limpia

.PHONY : clean
clean :
	rm -f *.o core $(EXE)
limpia:
	rm -f *.o
$(EXE) : % : %.o semaforos.o profesor.o alumno.o
			@ echo "#---------------------------"
			@ echo "# Generando $@ "
			@ echo "# Depende de $^"
			@ echo "# Ha cambiado $<"
			$(CC) $(CFLAGS) -o $@ $@.o semaforos.o profesor.o alumno.o

%.o : %.c semaforos.h
				@ echo "#---------------------------"
				@ echo "# Generando $@"
				@ echo "# Depende de $^"
				@ echo "# Ha cambiado $<"
				$(CC) $(CFLAGS) -c $<

%.o : %.c alumno.h
				@ echo "#---------------------------"
				@ echo "# Generando $@"
				@ echo "# Depende de $^"
				@ echo "# Ha cambiado $<"
				$(CC) $(CFLAGS) -c $<

%.o : %.c profesor.h
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
