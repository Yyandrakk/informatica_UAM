#ifndef   PRACTICA2_H
#define PRACTICA2_H

#include "variables.h"
#include "ip.h"
#include "eth.h"
#include "transporte.h"

void analizar_paquete(const struct pcap_pkthdr *cabecera, const uint8_t *paquete);

void handleSignal(int nsignal);

pcap_t *descr = NULL;
uint64_t contador = 0;
uint8_t ipo_filtro[IP_ALEN] = {0};
uint8_t ipd_filtro[IP_ALEN] = {0};
uint16_t po_filtro = 0;
uint16_t pd_filtro = 0;
#endif
