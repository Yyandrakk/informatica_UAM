#!/bin/bash

echo "Comenzando SCRIPT 4"

echo "Calculando la serie temporal del ancho de banda..."
test ! -f ./crearCDF && make
tshark -r traza.pcap -Y 'eth.src eq 00:11:88:CC:33:7B' -q -w traza_eth_src.pcap
tshark -r traza.pcap -Y 'eth.dst eq 00:11:88:CC:33:7B' -q -w traza_eth_dst.pcap
tshark -r traza_eth_src.pcap -qz conv,eth -qz io,stat,1 2> /dev/null | awk '
BEGIN{cont=0}
{
  cont++;

  if(cont>=13 && cont<=142){
    printf "%s\n", $8
  }
}
' > caudal_src.txt
echo "Resultado de la dirección ethernet origen almacenado en caudal_src.txt"

tshark -r traza_eth_dst.pcap -qz conv,eth -qz io,stat,1 2> /dev/null | awk '
BEGIN{cont=0}
{
  cont++;

  if(cont>=13 && cont<=142){
    printf "%s\n", $8
  }
}
' > caudal_dst.txt
echo "Resultado de la dirección ethernet destino almacenado en caudal_dst.txt"

echo "Calculando los tiempos entre llegadas del flujo TCP..."
tshark -r traza.pcap -Y 'tcp && !icmp && ip.src eq 120.24.138.137' -q -w traza_tcp_src.pcap
tshark -r traza.pcap -Y 'tcp && !icmp && ip.dst eq 120.24.138.137' -q -w traza_tcp_dst.pcap
tshark -r traza_tcp_src.pcap -T fields -e frame.time_delta_displayed > tiempos_tcp_src.txt
echo "Resultado de los tiempos del flujo TCP de origen almacenado en tiempos_tcp_src.txt"
tshark -r traza_tcp_dst.pcap -T fields -e frame.time_delta_displayed > tiempos_tcp_dst.txt
echo "Resultado de los tiempos del flujo TCP de destino almacenado en tiempos_tcp_dst.txt"

./crearCDF tiempos_tcp_src.txt CDFtcpsrc.txt
./crearCDF tiempos_tcp_dst.txt CDFtcpdst.txt

test -f ./CDFtcpsrc.png && rm CDFtcpsrc.png
gnuplot -persist <<-EOFMarker
  set title "ECDF tiempo entre llegadas TCP origen"
  set xlabel "Tiempo (s)"
  set ylabel "P(X<= tiempo)"
  plot "./CDFtcpsrc.txt" using 1:2 with steps title "ECDF"
  set term pngcairo
  set output "CDFtcpsrc.png"
  replot
  set output
EOFMarker


test -f ./CFDtcpdst.png && rm CFDtcpsrc.png
gnuplot -persist <<-EOFMarker
  set title "ECDF tiempo entre llegadas TCP destino"
  set xlabel "Tiempo (s)"
  set ylabel "P(X<= tiempo)"
  plot "./CDFtcpdst.txt" using 1:2 with steps title "ECDF"
  set term pngcairo
  set output "CDFtcpdst.png"
  replot
  set output
EOFMarker

echo "Calculando los tiempos entre llegadas del flujo UDP..."
tshark -r traza.pcap -Y 'udp && !icmp && udp.srcport eq 14286' -q -w traza_udp_src.pcap
tshark -r traza.pcap -Y 'udp && !icmp && udp.dstport eq 14286' -q -w traza_udp_dst.pcap
tshark -r traza_udp_src.pcap -T fields -e frame.time_delta_displayed > tiempos_udp_src.txt
echo "Resultado de los tiempos del flujo UDP de origen almacenado en tiempos_udp_src.txt"
tshark -r traza_udp_dst.pcap -T fields -e frame.time_delta_displayed > tiempos_udp_dst.txt
echo "Resultado de los tiempos del flujo UDP de destino almacenado en tiempos_udp_dst.txt"

./crearCDF tiempos_udp_src.txt CDFudpsrc.txt
./crearCDF tiempos_udp_dst.txt CDFudpdst.txt

gnuplot -persist <<-EOFMarker
  set title "ECDF tiempo entre llegadas UDP destino"
  set xlabel "Tiempo (s)"
  set ylabel "P(X<= tiempo)"
  plot "./CDFudpdst.txt" using 1:2 with steps title "ECDF"
  set term pngcairo
  set output "CDFudpdst.png"
  replot
  set output
EOFMarker

rm traza_eth_*
rm traza_tcp_*
rm traza_udp_*
