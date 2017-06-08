/***************************************************************************
 practica4.h
 Definiciones y cabeceras para practica4.c

 Autor: Jose Luis Garcia Dorado
 2014 EPS-UAM
***************************************************************************/

#ifndef __P4_H
#define __P4_H

#include <stdio.h>
#include <stdlib.h>

#include <pcap.h>
#include <string.h>
#include <netinet/in.h>
#include <linux/udp.h>
#include <linux/tcp.h>
#include <signal.h>
#include <time.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <unistd.h>
#include <netinet/ether.h>
#include <netinet/if_ether.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <inttypes.h>
#include <math.h>

/***************************Definicion de constantes************************************/
#define ETH_ALEN 6      	// Tamano de direccion ethernet
#define ETH_HLEN 14     	// Tamano de cabecera ethernet
#define ETH_TLEN 2 		// Tamano del campo tipo ethernet
#define ETH_FRAME_MAX 1514	// Tamano maximo trama ethernet
#define ETH_PROTO 0 		// Capa de enlace relativa al interface, le asignamos arbitrariamente el 0

#define IP_ALEN 4		// Tamano de direccion IP
#define IP_DATAGRAM_MAX 65536 	// Tamano maximo datagrama IP
#define IP_PROTO 0x0800		// Identificador protocolo IP
#define IP_HLEN 20

#define UDP_HLEN 8	      	// Tamano de cabecera UDP
#define UDP_SEG_MAX 65536  	// Tamano maximo segmento UDP
#define UDP_PROTO 17		// Identificador protocolo UDP

#define ICMP_PROTO 1		// Identificador protocolo ICMP
#define ICMP_HLEN 8		// Tamano de cabecera ICMP
#define ICMP_DATAGRAM_MAX 48	// Tamano maximo ICMP (arbitrario, truncar si es necesario)

#define PING_TIPO 8		//Codigo y tipo para PINGs
#define PING_CODE 0		//

#define CADENAS 256

#define MAX_PROTOCOL 65536	//Numero maximo identificador protocolo IP

#define OK 0
#define ERROR 1

#define min(a, b) (((a) < (b)) ? (a) : (b))

typedef uint8_t (*pf_notificacion) (uint8_t* datos, uint16_t* pila_protocolos,uint64_t longitud,void *parametros);
pf_notificacion protocolos_registrados[MAX_PROTOCOL];

typedef struct parametros{
		uint8_t ETH_destino[ETH_ALEN];
		uint8_t IP_destino[IP_ALEN];
		uint16_t puerto_destino;
		uint8_t tipo;
		uint8_t codigo;
}Parametros;

/***************************Pila de protocolos a implementar*************************************/
uint8_t moduloUDP(uint8_t* mensaje, uint16_t* pila_protocolos,uint64_t longitud,void *parametros);
uint8_t moduloICMP(uint8_t* mensaje, uint16_t* pila_protocolos,uint64_t longitud,void *parametros);
uint8_t moduloIP(uint8_t* segmento, uint16_t* pila_protocolos,uint64_t longitud,void *parametros);
uint8_t moduloETH(uint8_t* datagrama, uint16_t* pila_protocolos,uint64_t longitud,void *parametros);

/***************************Funcion enviar trafico implementada*********************************/
uint8_t enviar(uint8_t* mensaje, uint16_t* pila_protocolos,uint64_t longitud,void *parametros);

/***************************Funciones inicializacion implementadas*******************************/
uint8_t inicializarPilaEnviar();
uint8_t registrarProtocolo(uint16_t protocolo, pf_notificacion handleModule, pf_notificacion* protocolos_registrados);

/***************************Funciones auxiliares implementadas***********************************/
uint8_t calcularChecksum(uint16_t longitud, uint8_t *datos, uint8_t *checksum);
uint8_t mostrarPaquete(uint8_t * paquete, uint32_t longitud);
void handleSignal(int nsignal);

/***************************Funciones auxiliares a implementar*********************************/
uint8_t aplicarMascara(uint8_t* IP, uint8_t* mascara, uint32_t longitud, uint8_t* resultado);


#endif
