#!/bin/bash

echo "Comenzando SCRIPT 2"
#PAQUETES
echo "Calculando top 10 de direcciones IP..."
tshark -r traza.pcap -T fields -e ip.addr  -Y 'ip' 2> /dev/null | awk 'BEGIN{RS=","} {printf "%s\n", $0}' > aux2.txt
sort aux2.txt > aux2_orden.txt
uniq -c aux2_orden.txt > aux2.txt
sort -n -r aux2.txt > aux2_orden.txt
head -n 10 aux2_orden.txt > toptenip.txt
echo "El top 10 de direcciones IP se ha guardado en toptenip.txt"

echo "Calculando top 10 de puertos (TCP)..."
tshark -r traza.pcap -T fields -e tcp.dstport -e tcp.srcport -Y 'tcp && !icmp'  2> /dev/null | awk 'BEGIN{RS="\t"} {printf "%s\n", $0}' > aux2.txt
sort -n aux2.txt > aux2_orden.txt
uniq -c aux2_orden.txt > aux2.txt
sort -n -r aux2.txt > aux2_orden.txt
head -n 10 aux2_orden.txt > toptentcp.txt
echo "El top 10 de puertos (TCP) se ha guardado en toptentcp.txt"

echo "Calculando top 10 de puertos (UDP)..."
tshark -r traza.pcap -T fields -e udp.dstport -e udp.srcport -Y 'udp && !icmp'  2> /dev/null | awk 'BEGIN{RS="\t"} {printf "%s\n", $0}' > aux2.txt
sort -n aux2.txt > aux2_orden.txt
uniq -c aux2_orden.txt > aux2.txt
sort -n -r aux2.txt > aux2_orden.txt
head -n 10 aux2_orden.txt > toptenudp.txt
echo "El top 10 de puertos (UDP) se ha guardado en toptenudp.txt"

rm aux2.txt
rm aux2_orden.txt

#BYTE
echo "Calculando top 10 de direcciones IP por tamaño del paquete..."
test -f ./aux2.txt && rm aux2.txt
tshark -r traza.pcap -T fields -e ip.src -e frame.len  -Y 'ip'  > aux2s.txt
tshark -r traza.pcap -T fields -e ip.dst -e frame.len  -Y 'ip'  > aux2d.txt
cat aux2s.txt  aux2d.txt > aux2.txt
test -f ./aux2s.txt && rm aux2s.txt
test -f ./aux2d.txt && rm aux2d.txt
test -f ./aux2ipcount.txt && rm aux2ipcount.txt
awk 'BEGIN{ARGC=2;ARGV[1]="aux2.txt";}
{if(count[$1]!=""){
 count[$1]+=$2;
}else{
 count[$1]=$2;
}
}
END {
 for (k in count){
   print k " " count[k] >>"aux2ipcount.txt"
 }
}'
sort -n -k2 -r aux2ipcount.txt > aux2_orden.txt
echo "IP  Bytes\n" > toptenipbyte.txt
head -n 10 aux2_orden.txt >> toptenipbyte.txt
echo "El top 10 de direcciones IP por tamaño del paquete se ha guardado en toptenipbyte.txt"

echo "Calculando top 10 de puertos (TCP)..."
tshark -r traza.pcap -T fields -e tcp.dstport -e frame.len -Y 'tcp && !icmp' > aux2d.txt
tshark -r traza.pcap -T fields -e tcp.srcport -e frame.len -Y 'tcp && !icmp' > aux2s.txt
cat aux2s.txt  aux2d.txt > aux2.txt
test -f ./aux2s.txt && rm aux2s.txt
test -f ./aux2d.txt && rm aux2d.txt
test -f ./aux2tcpcount.txt && rm aux2tcpcount.txt
awk 'BEGIN{ARGC=2;ARGV[1]="aux2.txt";}
{if(count[$1]!=""){
 count[$1]+=$2;
}else{
 count[$1]=$2;
}
}
END {
 for (k in count){
   print k " " count[k] >>"aux2tcpcount.txt"
 }
}'

sort -n -k2 -r aux2tcpcount.txt > aux2_orden.txt
echo "Puertos  Bytes\n" > toptentcpbyte.txt
head -n 10 aux2_orden.txt >> toptentcpbyte.txt
echo "El top 10 de puertos (TCP) por tamaño del paquete se ha guardado en toptentcpbyte.txt"

echo "Calculando top 10 de puertos (UDP) por tamaño del paquete..."
#tshark -r traza.pcap -T fields -e udp.dstport -e udp.srcport -Y 'udp && !icmp'  2> /dev/null | awk 'BEGIN{RS="\t"} {printf "%s\n", $0}' > aux2.txt
tshark -r traza.pcap -T fields -e udp.dstport -e frame.len -Y 'udp && !icmp' > aux2d.txt
tshark -r traza.pcap -T fields -e udp.srcport -e frame.len -Y 'udp && !icmp' > aux2s.txt
cat aux2s.txt  aux2d.txt > aux2.txt
test -f ./aux2s.txt && rm aux2s.txt
test -f ./aux2d.txt && rm aux2d.txt
test -f ./aux2udpcount.txt && rm aux2udpcount.txt
awk 'BEGIN{ARGC=2;ARGV[1]="aux2.txt";}
{if(count[$1]!=""){
 count[$1]+=$2;
}else{
 count[$1]=$2;
}
}
END {
 for (k in count){
   print k " " count[k] >>"aux2udpcount.txt"
 }
}'
sort -n -r aux2.txt > aux2_orden.txt
echo "Puertos  Bytes\n" > toptenudpbyte.txt
head -n 10 aux2_orden.txt >> toptenudpbyte.txt
echo "El top 10 de puertos (UDP) se ha guardado en toptenudpbyte.txt"
test -f ./aux2.txt && rm aux2.txt
test -f ./aux2_orden.txt && rm aux2_orden.txt
test -f ./aux2udpcount.txt && rm aux2udpcount.txt
test -f ./aux2tcpcount.txt && rm aux2tcpcount.txt
