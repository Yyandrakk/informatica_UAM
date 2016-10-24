#!/bin/bash
rm timeFile.txt
for i in $(seq 3 16 2051)
do 
	./slow $i 2> /dev/null | grep "Execution time" | awk '{printf "%d %s ", '$i', $3}' >> timeFile.txt
	./fast $i 2> /dev/null | grep "Execution time" | awk '{print $3}' >> timeFile.txt
done





