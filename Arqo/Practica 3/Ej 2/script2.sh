#!/bin/bash
rm 1024.dat
rm 2048.dat
rm 4096.dat
rm 8192.dat
rm slowF
rm fastF



	valgrind --tool=cachegrind --I1=1024,1,64 --D1=1024,1,64 --LL=8388608,1,64 --cachegrind-out-file=slowF ./slow 
	 grep -H -R  "summary:" ./slowF | awk '{printf "0 %s %s ",$6,$9}' >> 1024.dat
	valgrind --tool=cachegrind --I1=1024,1,64 --D1=1024,1,64 --LL=8388608,1,64 --cachegrind-out-file=fastF ./fast  
	 grep -H -R "summary:" ./fastF | awk '{printf "%s %s\n",$6,$9}' >> 1024.dat

for indice in $(seq 3 16 2051)
do 

	valgrind --tool=cachegrind --I1=1024,1,64 --D1=1024,1,64 --LL=8388608,1,64 --cachegrind-out-file=slowF ./slow $indice 
	 grep -H -R  "summary:" ./slowF | awk '{printf "%d %s %s ",'$indice',$6,$9}' >> 1024.dat
	valgrind --tool=cachegrind --I1=1024,1,64 --D1=1024,1,64 --LL=8388608,1,64 --cachegrind-out-file=fastF ./fast $indice 
	 grep -H -R "summary:" ./fastF | awk '{printf "%s %s\n",$6,$9}' >> 1024.dat
done

	valgrind --tool=cachegrind --I1=2048,1,64 --D1=2048,1,64 --LL=8388608,1,64 --cachegrind-out-file=slowF ./slow 
	 grep -H -R  "summary:" ./slowF | awk '{printf "0 %s %s ",$6,$9}' >> 2048.dat
	valgrind --tool=cachegrind --I1=2048,1,64 --D1=2048,1,64 --LL=8388608,1,64 --cachegrind-out-file=fastF ./fast  
	 grep -H -R "summary:" ./fastF | awk '{printf "%s %s\n",$6,$9}' >> 2048.dat

for indice in $(seq 3 16 2051)
do 

	valgrind --tool=cachegrind --I1=2048,1,64 --D1=2048,1,64 --LL=8388608,1,64 --cachegrind-out-file=slowF ./slow $indice 
	 grep -H -R  "summary:" ./slowF | awk '{printf "%d %s %s ",'$indice',$6,$9}' >> 2048.dat
	valgrind --tool=cachegrind --I1=2048,1,64 --D1=2048,1,64 --LL=8388608,1,64 --cachegrind-out-file=fastF ./fast $indice 
	 grep -H -R "summary:" ./fastF | awk '{printf "%s %s\n",$6,$9}' >> 2048.dat
done

	valgrind --tool=cachegrind --I1=4096,1,64 --D1=4096,1,64 --LL=8388608,1,64 --cachegrind-out-file=slowF ./slow 
	 grep -H -R  "summary:" ./slowF | awk '{printf "0 %s %s ",$6,$9}' >> 4096.dat
	valgrind --tool=cachegrind --I1=4096,1,64 --D1=4096,1,64 --LL=8388608,1,64 --cachegrind-out-file=fastF ./fast  
	 grep -H -R "summary:" ./fastF | awk '{printf "%s %s\n",$6,$9}' >> 4096.dat

for indice in $(seq 3 16 2051)
do 

	valgrind --tool=cachegrind --I1=4096,1,64 --D1=4096,1,64 --LL=8388608,1,64 --cachegrind-out-file=slowF ./slow $indice 
	 grep -H -R  "summary:" ./slowF | awk '{printf "%d %s %s ",'$indice',$6,$9}' >> 4096.dat
	valgrind --tool=cachegrind --I1=4096,1,64 --D1=4096,1,64 --LL=8388608,1,64 --cachegrind-out-file=fastF ./fast $indice 
	 grep -H -R "summary:" ./fastF | awk '{printf "%s %s\n",$6,$9}' >> 4096.dat
done

	valgrind --tool=cachegrind --I1=8192,1,64 --D1=8192,1,64 --LL=8388608,1,64 --cachegrind-out-file=slowF ./slow 
	 grep -H -R  "summary:" ./slowF | awk '{printf "0 %s %s ",$6,$9}' >> 8192.dat
	valgrind --tool=cachegrind --I1=8192,1,64 --D1=8192,1,64 --LL=8388608,1,64 --cachegrind-out-file=fastF ./fast  
	 grep -H -R "summary:" ./fastF | awk '{printf "%s %s\n",$6,$9}' >> 8192.dat

for indice in $(seq 3 16 2051)
do 

	valgrind --tool=cachegrind --I1=8192,1,64 --D1=8192,1,64 --LL=8388608,1,64 --cachegrind-out-file=slowF ./slow $indice 
	 grep -H -R  "summary:" ./slowF | awk '{printf "%d %s %s ",'$indice',$6,$9}' >> 8192.dat
	valgrind --tool=cachegrind --I1=8192,1,64 --D1=8192,1,64 --LL=8388608,1,64 --cachegrind-out-file=fastF ./fast $indice 
	 grep -H -R "summary:" ./fastF | awk '{printf "%s %s\n",$6,$9}' >> 8192.dat
done
