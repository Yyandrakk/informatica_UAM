#!/bin/bash
############ Punto 3 de la memoria
echo "Comenzando SCRIPT 3, Punto 3 de la memoria"

test ! -f ./crearCDF && make
tshark -r traza.pcap -T fields -e frame.len -Y 'eth.src eq 00:11:88:CC:33:7B' > tamOrigenejer3aux.txt
tshark -r traza.pcap -T fields -e frame.len -Y 'eth.dst eq 00:11:88:CC:33:7B' > tamDestinoejer3aux.txt
./crearCDF tamDestinoejer3aux.txt CFDDestino.txt
test -f ./auxCDF.txt && rm auxCDF.txt
test -f ./auxCDFU.txt && rm auxCDFU.txt
./crearCDF tamOrigenejer3aux.txt CFDOrigen.txt
test -f ./auxCDF.txt && rm auxCDF.txt
test -f ./auxCDFU.txt && rm auxCDFU.txt
test -f ./tamOrigenejer3aux.txt && rm tamOrigenejer3aux.txt
test -f ./tamDestinoejer3aux.txt && rm tamDestinoejer3aux.txt

test -f ./CFDDestino.png && rm CFDDestino.png
gnuplot -persist <<-EOFMarker
  set title "ECDF tamaño paquetes destino"
  set xlabel "tamaño (B)"
  set ylabel "P(X<= tamaño)"
  plot "./CFDDestino.txt" using 1:2 with steps title "ECDF"
  set term pngcairo
  set output "CFDDestino.png"
  replot
  set output
EOFMarker

test -f ./CFDOrigen.png && rm CFDOrigen.png
gnuplot -persist <<-EOFMarker
  set title "ECDF tamaño paquetes origen"
  set xlabel "tamaño (B)"
  set ylabel "P(X<= tamaño)"
  plot "./CFDOrigen.txt" using 1:2 with steps title "ECDF"
  set term pngcairo
  set output "CFDOrigen.png"
  replot
  set output
EOFMarker

############ Punto 4 de la memoria
tshark -r traza.pcap -T fields -e frame.len -Y 'tcp && !icmp && tcp.srcport eq 80' > tamHTTPOrigenejer3aux.txt
tshark -r traza.pcap -T fields -e frame.len -Y 'tcp && !icmp && tcp.dstport eq 80' > tamHTTPDestinoejer3aux.txt
./crearCDF tamHTTPDestinoejer3aux.txt CFDHTTPDestino.txt
test -f ./auxCDF.txt && rm auxCDF.txt
test -f ./auxCDFU.txt && rm auxCDFU.txt
./crearCDF tamHTTPOrigenejer3aux.txt CFDHTTPOrigen.txt
test -f ./auxCDF.txt && rm auxCDF.txt
test -f ./auxCDFU.txt && rm auxCDFU.txt
test -f ./tamHTTPOrigenejer3aux.txt && rm tamHTTPOrigenejer3aux.txt
test -f ./tamHTTPDestinoejer3aux.txt && rm tamHTTPDestinoejer3aux.txt


test -f ./CFDHTTPDestino.png && rm CFDHTTPDestino.png
gnuplot -persist <<-EOFMarker
  set title "ECDF tamaño paquetes HTTP destino"
  set xlabel "tamaño (B)"
  set ylabel "P(X<= tamaño)"
  plot "./CFDHTTPDestino.txt" using 1:2 with steps title "ECDF"
  set term pngcairo
  set output "CFDHTTPDestino.png"
  replot
  set output
EOFMarker

test -f ./CFDHTTPOrigen.png && rm CFDHTTPOrigen.png
gnuplot -persist <<-EOFMarker
  set title "ECDF tamaño paquetes HTTP origen"
  set xlabel "tamaño (B)"
  set ylabel "P(X<= tamaño)"
  plot "./CFDHTTPOrigen.txt" using 1:2 with steps title "ECDF"
  set term pngcairo
  set output "CFDHTTPOrigen.png"
  replot
  set output
EOFMarker

############ Punto 5 de la memoria
tshark -r traza.pcap -T fields -e frame.len -Y 'udp && !icmp && udp.srcport eq 53' > tamDNSOrigenejer3aux.txt
tshark -r traza.pcap -T fields -e frame.len -Y 'udp && !icmp && udp.dstport eq 53' > tamDNSDestinoejer3aux.txt
./crearCDF tamDNSDestinoejer3aux.txt CFDDNSDestino.txt
test -f ./auxCDF.txt && rm auxCDF.txt
test -f ./auxCDFU.txt && rm auxCDFU.txt
./crearCDF tamDNSOrigenejer3aux.txt CFDDNSOrigen.txt
test -f ./auxCDF.txt && rm auxCDF.txt
test -f ./auxCDFU.txt && rm auxCDFU.txt
test -f ./tamDNSOrigenejer3aux.txt && rm tamDNSOrigenejer3aux.txt
test -f ./tamDNSDestinoejer3aux.txt && rm tamDNSDestinoejer3aux.txt


test -f ./CFDDNSDestino.png && rm CFDDNSDestino.png
gnuplot -persist <<-EOFMarker
  set title "ECDF tamaño paquetes DNS destino"
  set xlabel "tamaño (B)"
  set ylabel "P(X<= tamaño)"
  plot "./CFDDNSDestino.txt" using 1:2 with steps title "ECDF"
  set term pngcairo
  set output "CFDDNSDestino.png"
  replot
  set output
EOFMarker

test -f ./CFDDNSOrigen.png && rm CFDDNSOrigen.png
gnuplot -persist <<-EOFMarker
  set title "ECDF tamaño paquetes DNS origen"
  set xlabel "tamaño (B)"
  set ylabel "P(X<= tamaño)"
  plot "./CFDDNSOrigen.txt" using 1:2 with steps title "ECDF"
  set term pngcairo
  set output "CFDDNSOrigen.png"
  replot
  set output
EOFMarker
