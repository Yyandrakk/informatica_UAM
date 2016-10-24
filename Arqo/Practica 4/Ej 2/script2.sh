#!/bin/bash
rm tiempos.dat


./pescalar_serie 1000 2> /dev/null | grep "Tiempo:" | awk '{printf "1000 %s ", $2}' >> tiempos.dat
for indice in 1 2 3 4
do 
         ./pescalar_par2 1000 $indice 2> /dev/null | grep "Tiempo:" | awk '{printf "%s ", $2}' >> tiempos.dat
done

./pescalar_serie 2000 2> /dev/null | grep "Tiempo:" | awk '{printf "\n2000 %s ", $2}' >> tiempos.dat
for indice in 1 2 3 4
do 
         ./pescalar_par2 2000 $indice 2> /dev/null | grep "Tiempo:" | awk '{printf "%s ", $2}' >> tiempos.dat
done

./pescalar_serie 5000 2> /dev/null | grep "Tiempo:" | awk '{printf "\n5000 %s ", $2}' >> tiempos.dat
for indice in 1 2 3 4
do 
         ./pescalar_par2 5000 $indice 2> /dev/null | grep "Tiempo:" | awk '{printf "%s ", $2}' >> tiempos.dat
done

./pescalar_serie 10000 2> /dev/null | grep "Tiempo:" | awk '{printf "\n10000 %s ", $2}' >> tiempos.dat
for indice in 1 2 3 4
do 
         ./pescalar_par2 10000 $indice 2> /dev/null | grep "Tiempo:" | awk '{printf "%s ", $2}' >> tiempos.dat
done

./pescalar_serie 20000 2> /dev/null | grep "Tiempo:" | awk '{printf "\n20000 %s ", $2}' >> tiempos.dat
for indice in 1 2 3 4
do 
         ./pescalar_par2 20000 $indice 2> /dev/null | grep "Tiempo:" | awk '{printf "%s ", $2}' >> tiempos.dat
done

./pescalar_serie 30000 2> /dev/null | grep "Tiempo:" | awk '{printf "\n30000 %s ", $2}' >> tiempos.dat
for indice in 1 2 3 4
do 
         ./pescalar_par2 30000 $indice 2> /dev/null | grep "Tiempo:" | awk '{printf "%s ", $2}' >> tiempos.dat
done

./pescalar_serie 40000 2> /dev/null | grep "Tiempo:" | awk '{printf "\n40000 %s ", $2}' >> tiempos.dat
for indice in 1 2 3 4
do 
         ./pescalar_par2 40000 $indice 2> /dev/null | grep "Tiempo:" | awk '{printf "%s ", $2}' >> tiempos.dat
done

./pescalar_serie 50000 2> /dev/null | grep "Tiempo:" | awk '{printf "\n50000 %s ", $2}' >> tiempos.dat
for indice in 1 2 3 4
do 
         ./pescalar_par2 50000 $indice 2> /dev/null | grep "Tiempo:" | awk '{printf "%s ", $2}' >> tiempos.dat
done

./pescalar_serie 100000 2> /dev/null | grep "Tiempo:" | awk '{printf "\n100000 %s ", $2}' >> tiempos.dat
for indice in 1 2 3 4
do 
         ./pescalar_par2 100000 $indice 2> /dev/null | grep "Tiempo:" | awk '{printf "%s ", $2}' >> tiempos.dat
done
