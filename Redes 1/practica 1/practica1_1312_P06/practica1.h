#ifndef PRACTICA1_H
#define PRACTICA1_H

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <pcap.h>
#include <string.h>
#include <netinet/in.h>
#include <linux/udp.h>
#include <linux/tcp.h>
#include <signal.h>
#include <time.h>
#define OK 0
#define ERROR 1

#define ETH_FRAME_MAX 1514	// Tamanio maximo trama ethernet
typedef enum  {NINGUNO=1,UNARGUMENTO} argumento_entrada_type;
typedef enum  {ONLINE=1,OFFLINE} tipo_analisis;

void handle(int nsignal);
void capturar_traza(char* fichero);
void capturar_online();
void analisis(tipo_analisis tipo);
#endif
