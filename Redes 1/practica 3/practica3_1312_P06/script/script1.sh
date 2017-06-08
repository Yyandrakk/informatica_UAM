#!/bin/bash
echo "Comenzando SCRIPT 1"
tshark -r traza.pcap 2> /dev/null | wc -l |  awk '{printf "Count_packet %s ", $1}' > aux.txt
tshark -r traza.pcap -Y 'ip' 2> /dev/null | wc -l |  awk '{printf "Count_packet_ip %s ", $1}' >> aux.txt
awk 'BEGIN{ARGC=2;ARGV[1]="aux.txt"} {$(NF+1)="Count_packet_no_ip";$(NF+1)=$2-$4;} END {close(ARGV[1]);printf "%s", $0 > "aux.txt"}'
tshark -r traza.pcap -Y 'ip' -Y 'tcp && !icmp'  2> /dev/null | wc -l |  awk '{printf " Count_packet_tcp %s ", $1}' >> aux.txt
tshark -r traza.pcap -Y 'ip' -Y 'udp && !icmp' 2> /dev/null | wc -l |  awk '{printf "Count_packet_udp %s ", $1}' >> aux.txt
awk 'BEGIN{ARGC=2;ARGV[1]="aux.txt"} {$(NF+1)="Count_packet_other";$(NF+1)=$2-($8+$10);} END {close(ARGV[1]);print $0 > "aux.txt"}'
awk 'BEGIN{ARGC=2;ARGV[1]="aux.txt"}
 {pIP=($4/$2)*100;pNoIP=($6/$2)*100}
 END {close(ARGV[1]);printf "PorcentajeIP %.2f\nPorcentajeNoIp %.2f",pIP,pNoIP > "ejer1.txt"}'
awk 'BEGIN{ARGC=2;ARGV[1]="aux.txt"}
 {pTCP=($8/$4)*100;pUDP=($10/$4)*100;pOther=($12/$4)*100}
 END {close(ARGV[1]);printf "\nPorcentajeTCP %.2f\nPorcentajeUDP %.2f\nPorcentajeOther %.2f",pTCP,pUDP,pOther >> "ejer1.txt"}'
test -f ./aux.txt && rm aux.txt
echo "Terminado SCRIPT 1, el resultado se puede ver en el fichero ejer1.txt"
