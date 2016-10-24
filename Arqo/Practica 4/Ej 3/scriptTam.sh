#!/bin/bash
rm tiempos2.dat

for indice in $(seq 3 32 1027)
do 
         ./serie2 $indice 2> /dev/null | grep "Execution time:" | awk '{printf "%d %s ", '$indice', $3}' >> tiempos2.dat
         ./paralelo23 $indice 1 2> /dev/null | grep "Execution time:" | awk '{printf "%s ", $3}' >> tiempos2.dat
	 ./paralelo23 $indice 2 2> /dev/null | grep "Execution time:" | awk '{printf "%s ", $3}' >> tiempos2.dat
         ./paralelo23 $indice 3 2> /dev/null | grep "Execution time:" | awk '{printf "%s ", $3}' >> tiempos2.dat
         ./paralelo23 $indice 4 2> /dev/null | grep "Execution time:" | awk '{printf "%s\n", $3}' >> tiempos2.dat
done
