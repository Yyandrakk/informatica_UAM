/***************************************************************************
 practica4.c
 Inicio, funciones auxiliares y modulos de transmision implmentados y a implementar de la practica 4.
Compila con warning pues falta usar variables y modificar funciones

 Compila: make
 Autor: Jose Luis Garcia Dorado
 2014 EPS-UAM v2
***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include "interface.h"
#include "practica4.h"

/***************************Variables globales utiles*************************************************/
pcap_t* descr, *descr2; //Descriptores de la interface de red
pcap_dumper_t * pdumper;//y salida a pcap
uint64_t cont=0;	//Contador numero de mensajes enviados
char interface[10];	//Interface donde transmitir por ejemplo "eth0"
uint16_t ID=1,ID_ICMP=1,secuencia_ICMP=1;		//Identificador IP y ICMP


void handleSignal(int nsignal){
	printf("Control C pulsado (%"PRIu64")\n", cont);
	pcap_close(descr);
	exit(OK);
}

int main(int argc, char **argv){

	char errbuf[PCAP_ERRBUF_SIZE];
	char fichero_pcap_destino[CADENAS];
	uint8_t IP_destino_red[IP_ALEN];
	uint16_t MTU;
	uint16_t datalink;
	uint16_t puerto_destino;
	char data[IP_DATAGRAM_MAX],linea[IP_DATAGRAM_MAX];
	uint16_t pila_protocolos[CADENAS];


	int long_index=0;
	char opt;
	char flag_iface = 0, flag_ip = 0, flag_port = 0, flag_file = 0;

	static struct option options[] = {
		{"if",required_argument,0,'1'},
		{"ip",required_argument,0,'2'},
		{"pd",required_argument,0,'3'},
		{"f",required_argument,0,'4'},
		{"h",no_argument,0,'5'},
		{0,0,0,0}
	};

		//Dos opciones: leer de stdin o de fichero, adicionalmente para pruebas si no se introduce argumento se considera que el mensaje es "Payload "
	while ((opt = getopt_long_only(argc, argv,"1:2:3:4:5", options, &long_index )) != -1) {
		switch (opt) {

			case '1' :

				flag_iface = 1;
					//Por comodidad definimos interface como una variable global
				sprintf(interface,"%s",optarg);
				break;

			case '2' :

				flag_ip = 1;
					//Leemos la IP a donde transmitir y la almacenamos en orden de red
				if (sscanf(optarg,"%"SCNu8".%"SCNu8".%"SCNu8".%"SCNu8"",
				                   &(IP_destino_red[0]),&(IP_destino_red[1]),&(IP_destino_red[2]),&(IP_destino_red[3])) != IP_ALEN){
					printf("Error: Fallo en la lectura IP destino %s\n", optarg);
					exit(ERROR);
				}

				break;

			case '3' :

				flag_port = 1;
					//Leemos el puerto a donde transmitir y la almacenamos en orden de hardware
				puerto_destino=atoi(optarg);
				break;

			case '4' :

				if(strcmp(optarg,"stdin")==0) {
					if (fgets(data, sizeof data, stdin)==NULL) {
						  	printf("Error leyendo desde stdin: %s %s %d.\n",errbuf,__FILE__,__LINE__);
						return ERROR;
					}
					sprintf(fichero_pcap_destino,"%s%s","stdin",".pcap");
				} else {
					sprintf(fichero_pcap_destino,"%s%s",optarg,".pcap");
					FILE *f=fopen(optarg,"r");
					if(f==NULL){
						printf("Error: abrir fichero");
						return ERROR;
					}
					do{
						fscanf(f,"%[^\n]\n",linea);
						strcat(data,linea);
					} while (!feof(f));
					//FILE *open=fopen()
					//TODO Leer fichero en data [...]
				}
				flag_file = 1;

				break;

			case '5' : printf("Ayuda. Ejecucion: %s -if interface -ip IP -pd Puerto <-f /ruta/fichero_a_transmitir o stdin>: %d\n",argv[0],argc); exit(ERROR);
				break;

			case '?' : printf("Error. Ejecucion: %s -if interface -ip IP -pd Puerto <-f /ruta/fichero_a_transmitir o stdin>: %d\n",argv[0],argc); exit(ERROR);
				break;

			default: printf("Error. Ejecucion: %s -if interface -ip IP -pd Puerto <-f /ruta/fichero_a_transmitir o stdin>: %d\n",argv[0],argc); exit(ERROR);
				break;
        }
    }

	if ((flag_iface == 0) || (flag_ip == 0) || (flag_port == 0)){
		printf("Error. Ejecucion: %s -if interface -ip IP -pd Puerto <-f /ruta/fichero_a_transmitir o stdin>: %d\n",argv[0],argc);
		exit(ERROR);
	} else {
		printf("Interface:\n\t%s\n",interface);
		printf("IP:\n\t%"PRIu8".%"PRIu8".%"PRIu8".%"PRIu8"\n",IP_destino_red[0],IP_destino_red[1],IP_destino_red[2],IP_destino_red[3]);
		printf("Puerto destino:\n\t%"PRIu16"\n",puerto_destino);
	}

	if (flag_file == 0) {
		sprintf(data,"%s","Payload "); //Deben ser pares!
		sprintf(fichero_pcap_destino,"%s%s","debugging",".pcap");
	}

	if(signal(SIGINT,handleSignal)==SIG_ERR){
		printf("Error: Fallo al capturar la senal SIGINT.\n");
		return ERROR;
	}
		//Inicializamos las tablas de protocolos
	if(inicializarPilaEnviar()==ERROR){
      	printf("Error leyendo desde stdin: %s %s %d.\n",errbuf,__FILE__,__LINE__);
		return ERROR;
	}
		//Leemos el tamano maximo de transmision del nivel de enlace
	if(obtenerMTUInterface(interface, &MTU)==ERROR)
		return ERROR;
		//Descriptor de la interface de red donde inyectar trafico
	if ((descr = pcap_open_live(interface,MTU+ETH_HLEN,0, 0, errbuf)) == NULL){
		printf("Error: pcap_open_live(): %s %s %d.\n",errbuf,__FILE__,__LINE__);
		return ERROR;
	}

	datalink=(uint16_t)pcap_datalink(descr); //DLT_EN10MB==Ethernet

		//Descriptor del fichero de salida pcap para debugging
	descr2=pcap_open_dead(datalink,MTU+ETH_HLEN);
	pdumper=pcap_dump_open(descr2,fichero_pcap_destino);

		//Formamos y enviamos el trafico, debe enviarse un unico segmento por llamada a enviar() aunque luego se traduzca en mas de un datagrama
		//Primero un paquete UDP
		//Definimos la pila de protocolos que queremos seguir
	pila_protocolos[0]=UDP_PROTO; pila_protocolos[1]=IP_PROTO; pila_protocolos[2]=ETH_PROTO;
		//Rellenamos los parametros necesario para enviar el paquete a su destinatario y proceso
	Parametros parametros_udp; memcpy(parametros_udp.IP_destino,IP_destino_red,IP_ALEN); parametros_udp.puerto_destino=puerto_destino;
		//Enviamos
	if(enviar((uint8_t*)data,pila_protocolos,strlen(data),&parametros_udp)==ERROR ){
		printf("Error: enviar(): %s %s %d.\n",errbuf,__FILE__,__LINE__);
		return ERROR;
	}
	else	cont++;

	printf("Enviado mensaje %"PRIu64", almacenado en %s\n\n\n", cont,fichero_pcap_destino);

		//Luego, un paquete ICMP en concreto un ping
	pila_protocolos[0]=ICMP_PROTO; pila_protocolos[1]=IP_PROTO; pila_protocolos[2]=0;
	Parametros parametros_icmp; parametros_icmp.tipo=PING_TIPO; parametros_icmp.codigo=PING_CODE; memcpy(parametros_icmp.IP_destino,IP_destino_red,IP_ALEN);
	if(enviar((uint8_t*)"Probando a hacer un ping",pila_protocolos,strlen("Probando a hacer un ping"),&parametros_icmp)==ERROR ){
		printf("Error: enviar(): %s %s %d.\n",errbuf,__FILE__,__LINE__);
		return ERROR;
	}
	else	cont++;
	printf("Enviado mensaje %"PRIu64", ICMP almacenado en %s\n\n", cont,fichero_pcap_destino);

		//Cerramos descriptores
	pcap_close(descr);
	pcap_dump_close(pdumper);
	pcap_close(descr2);
	return OK;
}


/****************************************************************************************
* Nombre: enviar 									*
* Descripcion: Esta funcion envia un mensaje						*
* Argumentos: 										*
*  -mensaje: mensaje a enviar								*
*  -pila_protocolos: conjunto de protocolos a seguir					*
*  -longitud: bytes que componen mensaje						*
*  -parametros: parametros necesario para el envio (struct parametros)			*
* Retorno: OK/ERROR									*
****************************************************************************************/

uint8_t enviar(uint8_t* mensaje, uint16_t* pila_protocolos,uint64_t longitud,void *parametros){
	uint16_t protocolo=pila_protocolos[0];
printf("Enviar(%"PRIu16") %s %d.\n",protocolo,__FILE__,__LINE__);
	if(protocolos_registrados[protocolo]==NULL){
		printf("Protocolo %"PRIu16" desconocido\n",protocolo);
		return ERROR;
	}
	else {
		return protocolos_registrados[protocolo](mensaje,pila_protocolos,longitud,parametros);
	}
	return ERROR;
}


/***************************TODO Pila de protocolos a implementar************************************/

/****************************************************************************************
* Nombre: moduloUDP 									*
* Descripcion: Esta funcion implementa el modulo de envio UDP				*
* Argumentos: 										*
*  -mensaje: mensaje a enviar								*
*  -pila_protocolos: conjunto de protocolos a seguir					*
*  -longitud: bytes que componen mensaje						*
*  -parametros: parametros necesario para el envio este protocolo			*
* Retorno: OK/ERROR									*
****************************************************************************************/

uint8_t moduloUDP(uint8_t* mensaje, uint16_t* pila_protocolos,uint64_t longitud,void *parametros){
	uint8_t segmento[UDP_SEG_MAX]={0};
	uint16_t puerto_origen = 0,suma_control=0,longitud_udp=0;
	uint16_t aux16;
	uint32_t pos=0;
	uint16_t protocolo_inferior=pila_protocolos[1];

  printf("modulo UDP(%"PRIu16") %s %d.\n",protocolo_inferior,__FILE__,__LINE__);

	if (longitud>(pow(2,16)-UDP_HLEN)){
		printf("Error: mensaje demasiado grande para UDP (%f).\n",(pow(2,16)-UDP_HLEN));
		return ERROR;
	}

	Parametros udpdatos=*((Parametros*)parametros);
	uint16_t puerto_destino=udpdatos.puerto_destino;
	longitud_udp=longitud+UDP_HLEN;
//TODO
//[...]
//obtenerPuertoOrigen(·)
if(obtenerPuertoOrigen(&puerto_origen)!=OK){
	printf("Error: no hay puerto disponible UDP");
	return ERROR;
}
	aux16=htons(puerto_origen);
	memcpy(segmento+pos,&aux16,sizeof(uint16_t));
	pos+=sizeof(uint16_t);

	aux16=htons(puerto_destino);
	memcpy(segmento+pos,&aux16,sizeof(uint16_t));
	pos+=sizeof(uint16_t);

	aux16=htons(longitud_udp);
	memcpy(segmento+pos,&aux16,sizeof(uint16_t));
	pos+=sizeof(uint16_t);

	aux16=htons(suma_control);
	memcpy(segmento+pos,&aux16,sizeof(uint16_t));
	pos+=sizeof(uint16_t);


	memcpy(segmento+pos,mensaje,sizeof(uint8_t)*longitud);
	pos+=sizeof(uint8_t)*longitud;



//TODO Completar el segmento [...]
//[...]
//Se llama al protocolo definido de nivel inferior a traves de los punteros registrados en la tabla de protocolos registrados
	return protocolos_registrados[protocolo_inferior](segmento,pila_protocolos,pos,parametros);
}


/****************************************************************************************
* Nombre: moduloIP 									*
* Descripcion: Esta funcion implementa el modulo de envio IP				*
* Argumentos: 										*
*  -segmento: segmento a enviar								*
*  -pila_protocolos: conjunto de protocolos a seguir					*
*  -longitud: bytes que componen el segmento						*
*  -parametros: parametros necesario para el envio este protocolo			*
* Retorno: OK/ERROR									*
****************************************************************************************/

uint8_t moduloIP(uint8_t* segmento, uint16_t* pila_protocolos,uint64_t longitud,void *parametros){
	uint8_t datagrama[IP_DATAGRAM_MAX]={0},checksum[2]={0};
	uint16_t aux16,longitud_ip=0,longitud_mtu=0;
	uint8_t aux8;
	uint32_t pos=0,pos_control=0,pos_long=0;
	uint8_t IP_origen[IP_ALEN],IP_router[IP_ALEN],IP_destino_mascara[IP_ALEN],IP_origen_mascara[IP_ALEN];
	uint16_t protocolo_superior=pila_protocolos[0];
	uint16_t protocolo_inferior=pila_protocolos[2];
	pila_protocolos++;
	uint8_t mascara[IP_ALEN];
	int i,local=1;
  printf("modulo IP(%"PRIu16") %s %d.\n",protocolo_inferior,__FILE__,__LINE__);
	if(obtenerMTUInterface(interface, &longitud_mtu)!=OK){
		printf("Error: no se ha podido obtener MTU para ETH\n");
		return ERROR;
	}

	if (longitud>(pow(2,16)-IP_HLEN)){
		printf("Error: segmento demasiado grande para IP (%f).\n",(pow(2,16)-IP_HLEN));
		return ERROR;
	}
	longitud_ip=longitud+IP_HLEN;
	Parametros ipdatos=*((Parametros*)parametros);
	uint8_t* IP_destino=ipdatos.IP_destino;
	if(obtenerMascaraInterface(interface, mascara)!=OK){
		printf("Error: No se puede conseguir la mascara de la Interface" );
		return ERROR;
	}
	if(obtenerIPInterface(interface,IP_origen)!=OK){
		printf("Error: No se puede conseguir la IP origen" );
		return ERROR;
	}
	//Aplico la mascara a la IP origen y la destino, si el resultado es el mismo, estan en la misma red local
	if(aplicarMascara(IP_origen,mascara, IP_ALEN, IP_origen_mascara)!=OK ||aplicarMascara(IP_destino,mascara, IP_ALEN, IP_destino_mascara)!=OK  ){
		printf("Error: No se puede aplicar las mascaras" );
		return ERROR;
	}

	for(i=0;i<IP_ALEN;i++){
		if(IP_origen_mascara[i]!=IP_destino_mascara[i])
			local=0;
	}

		if(local==1){
				//esta en el mismo nivel 2
			if(ARPrequest(interface,IP_destino,ipdatos.ETH_destino)!=OK){
				printf("Error: No se ha realizado el ARPrequest\n" );
				return ERROR;
			}
		}else{
			if(obtenerGateway(interface, IP_router)!=OK || ARPrequest(interface,IP_router,ipdatos.ETH_destino)!=OK){
				printf("Error: No se ha conseguido el gateway\n" );
				return ERROR;
			}
		}

	//TODO
	//Llamar a ARPrequest(·) adecuadamente y usar ETH_destino de la estructura parametros
	//[...]
	//TODO A implementar el datagrama y fragmentación (en caso contrario, control de tamano)
	//[...]
	//llamada/s a protocolo de nivel inferior [...]

	aux8 = 0x45 ;//version=4,ihl=20/4 supongo que no hay opciones ni Rellenamos
	memcpy(datagrama+pos,&aux8,sizeof(uint8_t));
	pos+=sizeof(uint8_t);

	aux8 = 0x00 ;//Tipo de servicio no se que poner
	memcpy(datagrama+pos,&aux8,sizeof(uint8_t));
	pos+=sizeof(uint8_t);

	pos_long=pos;
	aux16=htons(longitud_ip);
	memcpy(datagrama+pos,&aux16,sizeof(uint16_t));
	pos+=sizeof(uint16_t);

	aux16=htons(ID++);//identificador
	memcpy(datagrama+pos,&aux16,sizeof(uint16_t));
	pos+=sizeof(uint16_t);

if(longitud_ip<longitud_mtu){
	//Cuando no hay fragmentacion
	aux16=0;
	memcpy(datagrama+pos,&aux16,sizeof(uint16_t));
	pos+=sizeof(uint16_t);

	aux8=63;//tiempo_de_vida 64
	memcpy(datagrama+pos,&aux8,sizeof(uint8_t));
	pos+=sizeof(uint8_t);

	aux8=protocolo_superior;
	memcpy(datagrama+pos,&aux8,sizeof(uint8_t));
	pos+=sizeof(uint8_t);

	//nos quedamos con la posicion del checksum para ponerlo al final
	pos_control=pos;
	aux16=htons(0x00);
	memcpy(datagrama+pos,&aux16,sizeof(uint16_t));
	pos+=sizeof(uint16_t);

	for(i=0;i<IP_ALEN;i++){
		aux8=IP_origen[i];//tiempo_de_vida 64
		memcpy(datagrama+pos,&aux8,sizeof(uint8_t));
		pos+=sizeof(uint8_t);
	}

	for(i=0;i<IP_ALEN;i++){
		aux8=IP_destino[i];//tiempo_de_vida 64
		memcpy(datagrama+pos,&aux8,sizeof(uint8_t));
		pos+=sizeof(uint8_t);
	}

	if(calcularChecksum(IP_HLEN,datagrama,checksum)!=OK){
		printf("Error: Al calcular Checksum\n" );
		return ERROR;
	}
	//Checksum ya esta en forma red
	memcpy(datagrama+pos_control,&checksum[0],sizeof(uint8_t));
	pos_control+=sizeof(uint8_t);
	memcpy(datagrama+pos_control,&checksum[1],sizeof(uint8_t));


	memcpy(datagrama+pos,segmento,sizeof(uint8_t)*longitud);
	pos+=sizeof(uint8_t)*longitud;



	return protocolos_registrados[protocolo_inferior](datagrama,pila_protocolos,pos,&ipdatos);
}else{

	int num_div=floor((longitud_mtu-20 / 8));
	int num_dat=(int)ceil((double)longitud/num_div),cont=0;
	uint32_t pos_frag=pos,pos_seg=0;

	do{

		pos=pos_frag;
		//cambiar
		aux16=0;
		aux16=(((num_dat==1)?0b000:0b001)<<13)|(pos_seg/8);
		aux16=htons(aux16);
		memcpy(datagrama+pos,&aux16,sizeof(uint16_t));
		pos+=sizeof(uint16_t);

		aux8=63;//tiempo_de_vida 64
		memcpy(datagrama+pos,&aux8,sizeof(uint8_t));
		pos+=sizeof(uint8_t);

		aux8=protocolo_superior;
		memcpy(datagrama+pos,&aux8,sizeof(uint8_t));
		pos+=sizeof(uint8_t);

		//nos quedamos con la posicion del checksum para ponerlo al final
		pos_control=pos;
		aux16=htons(0x00);
		memcpy(datagrama+pos,&aux16,sizeof(uint16_t));
		pos+=sizeof(uint16_t);

		for(i=0;i<IP_ALEN;i++){
			aux8=IP_origen[i];//tiempo_de_vida 64
			memcpy(datagrama+pos,&aux8,sizeof(uint8_t));
			pos+=sizeof(uint8_t);
		}

		for(i=0;i<IP_ALEN;i++){
			aux8=IP_destino[i];//tiempo_de_vida 64
			memcpy(datagrama+pos,&aux8,sizeof(uint8_t));
			pos+=sizeof(uint8_t);
		}


		//entra dos veces en el if
		if(longitud-pos_seg>longitud_mtu-IP_HLEN){

				memcpy(datagrama+pos,segmento+pos_seg,(longitud_mtu-IP_HLEN)*sizeof(uint8_t));
				pos_seg+=longitud_mtu-IP_HLEN;
				pos+=(longitud_mtu-IP_HLEN)*sizeof(uint8_t);
				aux16=htons(longitud_mtu);
				memcpy(datagrama+pos_long,&aux16,sizeof(uint16_t));
				if(calcularChecksum(IP_HLEN,datagrama,checksum)!=OK){
					printf("Error: Al calcular Checksum\n" );
					return ERROR;
				}
				//Checksum ya esta en forma red
				memcpy(datagrama+pos_control,&checksum[0],sizeof(uint8_t));
				pos_control+=sizeof(uint8_t);
				memcpy(datagrama+pos_control,&checksum[1],sizeof(uint8_t));
			//	mostrarPaquete(datagrama,IP_HLEN);
				if(protocolos_registrados[protocolo_inferior](datagrama,pila_protocolos,longitud_mtu,&ipdatos)!=OK){
					printf("Error: Al mandar paquete fragmentado:%d\n",cont);
					return ERROR;
				}
				printf("intermedio\n");
		}else{

			memcpy(datagrama+pos,segmento+pos_seg,(longitud-(pos_seg))*sizeof(uint8_t));
			//pos_seg+=longitud-pos_seg;
			pos+=(longitud-pos_seg)*sizeof(uint8_t);
			aux16=htons(longitud-pos_seg+(int)IP_HLEN);
			memcpy(datagrama+pos_long,&aux16,sizeof(uint16_t));

			if(calcularChecksum(IP_HLEN,datagrama,checksum)!=OK){
				printf("Error: Al calcular Checksum\n" );
				return ERROR;
			}
			//Checksum ya esta en forma red
			memcpy(datagrama+pos_control,&checksum[0],sizeof(uint8_t));
			pos_control+=sizeof(uint8_t);
			memcpy(datagrama+pos_control,&checksum[1],sizeof(uint8_t));
			//mostrarPaquete(datagrama,IP_HLEN);
			if(protocolos_registrados[protocolo_inferior](datagrama,pila_protocolos,(longitud-(pos_seg))+IP_HLEN,&ipdatos)!=OK){
				printf("Error: Al mandar paquete fragmentado:%d\n",cont);
				return ERROR;
			}
					printf("final\n");
		}


		num_dat--;
	}while(num_dat>0);
	return OK;
}

}


/****************************************************************************************
* Nombre: moduloETH 									*
* Descripcion: Esta funcion implementa el modulo de envio Ethernet			*
* Argumentos: 										*
*  -datagrama: datagrama a enviar							*
*  -pila_protocolos: conjunto de protocolos a seguir					*
*  -longitud: bytes que componen el datagrama						*
*  -parametros: Parametros necesario para el envio este protocolo			*
* Retorno: OK/ERROR									*
****************************************************************************************/

uint8_t moduloETH(uint8_t* datagrama, uint16_t* pila_protocolos,uint64_t longitud,void *parametros){
	//TODO
	//[....]
	//[...] Variables del modulo
	uint16_t ETH_tipo=pila_protocolos[0], longitud_eth=0, aux16=0;
	uint8_t trama[ETH_FRAME_MAX]={0}, ETH_origen[ETH_ALEN];
	uint32_t pos=0;
	uint8_t aux8=0;
	int i, bytes_transmitidos=0;
	struct pcap_pkthdr cabecera;

	printf("modulo ETH(fisica) %s %d.\n",__FILE__,__LINE__);

	//TODO
	//[...] Control de tamano
	if(obtenerMTUInterface(interface, &longitud_eth)!=OK){
		printf("Error: no se ha podido obtener MTU para ETH\n");
		return ERROR;
	}

	if (longitud>longitud_eth){
		printf("Error: segmento demasiado grande para ETH (%d).\n",longitud);
		return ERROR;
	}

	//TODO
	//[...] Cabecera del modulo
	if(obtenerMACdeInterface(interface, ETH_origen)!=OK){
		printf("Error: no se ha podido obtener la MAC de la interfaz\n");
		return ERROR;
	}

	Parametros ethdatos=*((Parametros*)parametros);
	uint8_t *ETH_destino=ethdatos.ETH_destino;

	for(i=0; i<ETH_ALEN; i++){
		aux8=ETH_destino[i];
		memcpy(trama+pos, &aux8, sizeof(uint8_t));
		pos+=sizeof(uint8_t);
	}

	for(i=0; i<ETH_ALEN; i++){
		aux8=ETH_origen[i];
		memcpy(trama+pos, &aux8, sizeof(uint8_t));
		pos+=sizeof(uint8_t);
	}
	printf("0x%04x\n", ETH_tipo);
	aux16=htons(ETH_tipo);
	memcpy(trama+pos,&aux16,sizeof(uint16_t));
	pos+=sizeof(uint16_t);


	memcpy(trama+pos,datagrama,sizeof(uint8_t)*longitud);
	pos+=sizeof(uint8_t)*longitud;


	//TODO
	//Enviar a capa fisica [...]
	bytes_transmitidos=pcap_inject(descr, trama, pos);
	if(bytes_transmitidos==-1){
		printf("Error: no se ha podido enviar a capa fisica\n");
		return ERROR;
	}

	//TODO
	//Almacenamos la salida por cuestiones de debugging [...]
	cabecera.caplen=pos;
	gettimeofday(&cabecera.ts,NULL);
	pcap_dump((uint8_t *)pdumper, &cabecera, trama);

		return OK;
}


/****************************************************************************************
* Nombre: moduloICMP 									*
* Descripcion: Esta funcion implementa el modulo de envio ICMP				*
* Argumentos: 										*
*  -mensaje: mensaje a anadir a la cabecera ICMP					*
*  -pila_protocolos: conjunto de protocolos a seguir					*
*  -longitud: bytes que componen el mensaje						*
*  -parametros: parametros necesario para el envio este protocolo			*
* Retorno: OK/ERROR									*
****************************************************************************************/

uint8_t moduloICMP(uint8_t* mensaje, uint16_t* pila_protocolos,uint64_t longitud,void *parametros){
//TODO
//[....]
uint8_t segmento[ICMP_DATAGRAM_MAX]={0},checksum[2]={0};
uint16_t aux16;
uint32_t pos=0,pos_control=0;
uint16_t protocolo_inferior=pila_protocolos[1];

printf("modulo ICMP(%"PRIu16") %s %d.\n",protocolo_inferior,__FILE__,__LINE__);
if(longitud>ICMP_DATAGRAM_MAX-ICMP_HLEN){
	printf("Error: Tamaño del datagrama ICMP superado\n");
	return ERROR;
}
Parametros icmpdatos=*((Parametros*)parametros);
uint8_t tipo=icmpdatos.tipo;
uint8_t codigo=icmpdatos.codigo;

memcpy(segmento+pos,&tipo,sizeof(uint8_t));
pos+=sizeof(uint8_t);

memcpy(segmento+pos,&codigo,sizeof(uint8_t));
pos+=sizeof(uint8_t);

pos_control=pos;
aux16=htons(0x00);
memcpy(segmento+pos,&aux16,sizeof(uint16_t));
pos+=sizeof(uint16_t);

aux16=htons(ID_ICMP++);
memcpy(segmento+pos,&aux16,sizeof(uint16_t));
pos+=sizeof(uint16_t);

aux16=htons(secuencia_ICMP++);
memcpy(segmento+pos,&aux16,sizeof(uint16_t));
pos+=sizeof(uint16_t);



	memcpy(segmento+pos,mensaje,sizeof(uint8_t)*longitud);
	pos+=sizeof(uint8_t)*longitud;

if(calcularChecksum(pos,segmento, checksum)!=OK){
	printf("Error: Al calcular Checksum\n" );
	return ERROR;
}
//Checksum ya esta en forma red
memcpy(segmento+pos_control,&checksum[0],sizeof(uint8_t));
pos_control+=sizeof(uint8_t);
memcpy(segmento+pos_control,&checksum[1],sizeof(uint8_t));
return protocolos_registrados[protocolo_inferior](segmento,pila_protocolos,pos,parametros);


}


/***************************Funciones auxiliares a implementar***********************************/

/****************************************************************************************
* Nombre: aplicarMascara 								*
* Descripcion: Esta funcion aplica una mascara a una vector				*
* Argumentos: 										*
*  -IP: IP a la que aplicar la mascara en orden de red					*
*  -mascara: mascara a aplicar en orden de red						*
*  -longitud: bytes que componen la direccion (IPv4 == 4)				*
*  -resultado: Resultados de aplicar mascara en IP en orden red				*
* Retorno: OK/ERROR									*
****************************************************************************************/

uint8_t aplicarMascara(uint8_t* IP, uint8_t* mascara, uint32_t longitud, uint8_t* resultado){
//TODO
//[...]
if(IP==NULL || mascara==NULL || resultado==NULL){
	return ERROR;
}
	uint8_t aux8=0;
	int i;
	for(i=0;i<longitud;i++){
		aux8=(*(IP+i)&*(mascara+i));

		memcpy(resultado+i,&aux8,sizeof(uint8_t));
	}
	return OK;
}


/***************************Funciones auxiliares implementadas**************************************/

/****************************************************************************************
* Nombre: mostrarPaquete 								*
* Descripcion: Esta funcion imprime por pantalla en hexadecimal un vector		*
* Argumentos: 										*
*  -paquete: bytes que conforman un paquete						*
*  -longitud: Bytes que componen el mensaje						*
* Retorno: OK/ERROR									*
****************************************************************************************/

uint8_t mostrarPaquete(uint8_t * paquete, uint32_t longitud){
	uint32_t i;
	printf("Paquete:\n");
	for (i=0;i<longitud;i++){
		printf("%02"PRIx8" ", paquete[i]);
	}
	printf("\n");
	return OK;
}


/****************************************************************************************
* Nombre: calcularChecksum							     	*
* Descripcion: Esta funcion devuelve el ckecksum tal como lo calcula IP/ICMP		*
* Argumentos:										*
*   -longitud: numero de bytes de los datos sobre los que calcular el checksum		*
*   -datos: datos sobre los que calcular el checksum					*
*   -checksum: checksum de los datos (2 bytes) en orden de red! 			*
* Retorno: OK/ERROR									*
****************************************************************************************/

uint8_t calcularChecksum(uint16_t longitud, uint8_t *datos, uint8_t *checksum) {
    uint16_t word16;
    uint32_t sum=0;
    int i;
    // make 16 bit words out of every two adjacent 8 bit words in the packet
    // and add them up
    for (i=0; i<longitud; i=i+2){
        word16 = (datos[i]<<8) + datos[i+1];
        sum += (uint32_t)word16;
    }
    // take only 16 bits out of the 32 bit sum and add up the carries
    while (sum>>16) {
        sum = (sum & 0xFFFF)+(sum >> 16);
    }
    // one's complement the result
    sum = ~sum;
    checksum[0] = sum >> 8;
    checksum[1] = sum & 0xFF;
    return OK;
}


/***************************Funciones inicializacion implementadas*********************************/

/****************************************************************************************
* Nombre: inicializarPilaEnviar     							*
* Descripcion: inicializar la pila de red para enviar registrando los distintos modulos *
* Retorno: OK/ERROR									*
****************************************************************************************/

uint8_t inicializarPilaEnviar() {
	bzero(protocolos_registrados,MAX_PROTOCOL*sizeof(pf_notificacion));
	if(registrarProtocolo(ETH_PROTO, moduloETH, protocolos_registrados)==ERROR)
		return ERROR;
	if(registrarProtocolo(IP_PROTO, moduloIP, protocolos_registrados)==ERROR)
		return ERROR;
	if(registrarProtocolo(UDP_PROTO, moduloUDP, protocolos_registrados)==ERROR)
	 	return ERROR;
	if(registrarProtocolo(ICMP_PROTO, moduloICMP, protocolos_registrados)==ERROR)
		return ERROR;
//TODO
//A registrar los modulos de UDP y ICMP [...]

	return OK;
}


/****************************************************************************************
* Nombre: registrarProtocolo 								*
* Descripcion: Registra un protocolo en la tabla de protocolos 				*
* Argumentos:										*
*  -protocolo: Referencia del protocolo (ver RFC 1700)					*
*  -handleModule: Funcion a llamar con los datos a enviar				*
*  -protocolos_registrados: vector de funciones registradas 				*
* Retorno: OK/ERROR 									*
*****************************************************************************************/

uint8_t registrarProtocolo(uint16_t protocolo, pf_notificacion handleModule, pf_notificacion* protocolos_registrados){
	if(protocolos_registrados==NULL ||  handleModule==NULL){
		printf("Error: registrarProtocolo(): entradas nulas.\n");
		return ERROR;
	}
	else
		protocolos_registrados[protocolo]=handleModule;
	return OK;
}
