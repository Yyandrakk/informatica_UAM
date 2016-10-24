#!/bin/bash
rm tiempos.dat

echo "Serie"
for indice in 1 2 3 4
do 
         ./serie $indice 2> /dev/null | grep "Execution time:" | awk '{printf "%s ", $3}' >> tiempos.dat
done

echo   >> tiempos.dat
echo "paralelo1"
for indice in 1 2 3 4
do 
         ./paralelo1 $indice 2> /dev/null | grep "Execution time:" | awk '{printf "%s ", $3}' >> tiempos.dat
done

echo  >> tiempos.dat
echo "paralelo2"
for indice in 1 2 3 4
do 
         ./paralelo2 $indice 2> /dev/null | grep "Execution time:" | awk '{printf "%s ", $3}' >> tiempos.dat
done

echo  >> tiempos.dat
echo "paralelo3"
for indice in 1 2 3 4
do 
         ./paralelo3 $indice 2> /dev/null | grep "Execution time:" | awk '{printf "%s ", $3}' >> tiempos.dat
done
