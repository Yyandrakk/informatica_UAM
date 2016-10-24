#-----------------------
# IMPORTANTE: Los valores de los parametros de los ejercicio?_test deben ajustarse.
# Se asume que los ficheros fuente se llaman ejercicio1.c, ejercicio2.c,...,ordenar.h
#-----------------------

CC = gcc -ansi -pedantic
CFLAGS = -Wall -O3
EXE = ejercicio1 ejercicio2

all : $(EXE)

.PHONY : clean
clean :
	rm -f *.o core $(EXE)

$(EXE) : % : %.o ordenar.o busqueda.o
	@ echo "#---------------------------"
	@ echo "# Generando $@ "
	@ echo "# Depende de $^"
	@ echo "# Ha cambiado $<"
	$(CC) $(CFLAGS) -o $@ $@.o ordenar.o busqueda.o

%.o : %.c ordenar.h
	@ echo "#---------------------------"
	@ echo "# Generando $@"
	@ echo "# Depende de $^"
	@ echo "# Ha cambiado $<"
	$(CC) $(CFLAGS) -c $<

%.o : %.c busqueda.h
	@ echo "#---------------------------"
	@ echo "# Generando $@"
	@ echo "# Depende de $^"
	@ echo "# Ha cambiado $<"
	$(CC) $(CFLAGS) -c $<

info:
	@ echo "-------------------------------------"
	@ echo "Practica realizada por: "
	@ echo "Oscar Garcia de Lara "
	@ echo "Jaime Lopez "
	@ echo "-------------------------------------"
