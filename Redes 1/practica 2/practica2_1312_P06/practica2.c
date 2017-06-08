/***************************************************************************
 practica2.c
 Muestra las direciones Ethernet de la traza que se pasa como primer parametro.
 Debe complatarse con mas campos de niveles 2, 3, y 4 tal como se pida en el enunciado.
 Debe tener capacidad de dejar de analizar paquetes de acuerdo a un filtro.

 Compila: gcc -Wall -o practica2 practica2.c -lpcap, make
 Autor: Oscar Garcia de Lara y Santiago Gomez
***************************************************************************/

#include "practica2.h"


void handleSignal(int nsignal)
{
	(void) nsignal; // indicamos al compilador que no nos importa que nsignal no se utilice

	printf("Control C pulsado (%"PRIu64" paquetes leidos)\n", contador);
	if(descr!=NULL)
	 pcap_close(descr);
	exit(OK);
}

int main(int argc, char **argv)
{
	uint8_t *paquete = NULL;
	struct pcap_pkthdr *cabecera;

	char errbuf[PCAP_ERRBUF_SIZE];
	char entrada[256];
	int long_index = 0, retorno = 0;
	char opt;

	(void) errbuf; //indicamos al compilador que no nos importa que errbuf no se utilice. Esta linea debe ser eliminada en la entrega final.

	if (signal(SIGINT, handleSignal) == SIG_ERR) {
		printf("Error: Fallo al capturar la senal SIGINT.\n");
		exit(ERROR);
	}

	if (argc > 1) {
		if (strlen(argv[1]) < 256) {
			strcpy(entrada, argv[1]);
		}

	} else {
		printf("Ejecucion: %s <-f traza.pcap / -i eth0> [-ipo IPO] [-ipd IPD] [-po PO] [-pd PD]\n", argv[0]);
		exit(ERROR);
	}

	static struct option options[] = {
		{"f", required_argument, 0, 'f'},
		{"i",required_argument, 0,'i'},
		{"ipo", required_argument, 0, '1'},
		{"ipd", required_argument, 0, '2'},
		{"po", required_argument, 0, '3'},
		{"pd", required_argument, 0, '4'},
		{"h", no_argument, 0, '5'},
		{0, 0, 0, 0}
	};

	//Simple lectura por parametros por completar casos de error, ojo no cumple 100% los requisitos del enunciado!
	while ((opt = getopt_long_only(argc, argv, "f:i:1:2:3:4:5", options, &long_index)) != -1) {
		switch (opt) {
		case 'i' :
			if(descr!=NULL) { // comprobamos que no se ha abierto ninguna otra interfaz o fichero
				printf("Ha seleccionado más de una fuente de datos\n");
				pcap_close(descr);
				exit(ERROR);
			}
			//printf("Descomente el código para leer y abrir de una interfaz\n");
			//exit(ERROR);

			if ( (descr = pcap_open_live(optarg,ETH_FRAME_MAX,0,100, errbuf)) == NULL){
				printf("Error: pcap_open_live(): Interface: %s, %s %s %d.\n", optarg,errbuf,__FILE__,__LINE__);
				exit(ERROR);
			}
			break;

		case 'f' :
			if(descr!=NULL) { // comprobamos que no se ha abierto ninguna otra interfaz o fichero
				printf("Ha seleccionado más de una fuente de datos\n");
				pcap_close(descr);
				exit(ERROR);
			}

			if ((descr = pcap_open_offline(optarg, errbuf)) == NULL) {
				printf("Error: pcap_open_offline(): File: %s, %s %s %d.\n", optarg, errbuf, __FILE__, __LINE__);
				exit(ERROR);
			}

			break;

		case '1' :
			if (sscanf(optarg, "%"SCNu8".%"SCNu8".%"SCNu8".%"SCNu8"", &(ipo_filtro[0]), &(ipo_filtro[1]), &(ipo_filtro[2]), &(ipo_filtro[3])) != IP_ALEN) {
				printf("Error ipo_filtro. Ejecucion: %s /ruta/captura_pcap [-ipo IPO] [-ipd IPD] [-po PO] [-pd PD]: %d\n", argv[0], argc);
				exit(ERROR);
			}

			break;

		case '2' :
			if (sscanf(optarg, "%"SCNu8".%"SCNu8".%"SCNu8".%"SCNu8"", &(ipd_filtro[0]), &(ipd_filtro[1]), &(ipd_filtro[2]), &(ipd_filtro[3])) != IP_ALEN) {
				printf("Error ipd_filtro. Ejecucion: %s /ruta/captura_pcap [-ipo IPO] [-ipd IPD] [-po PO] [-pd PD]: %d\n", argv[0], argc);
				exit(ERROR);
			}

			break;

		case '3' :
			if ((po_filtro = atoi(optarg)) == 0) {
				printf("Error o_filtro.Ejecucion: %s /ruta/captura_pcap [-ipo IPO] [-ipd IPD] [-po PO] [-pd PD]: %d\n", argv[0], argc);
				exit(ERROR);
			}

			break;

		case '4' :
			if ((pd_filtro = atoi(optarg)) == 0) {
				printf("Error pd_filtro. Ejecucion: %s /ruta/captura_pcap [-ipo IPO] [-ipd IPD] [-po PO] [-pd PD]: %d\n", argv[0], argc);
				exit(ERROR);
			}

			break;

		case '5' :
			printf("Ayuda. Ejecucion: %s <-f traza.pcap / -i eth0> [-ipo IPO] [-ipd IPD] [-po PO] [-pd PD]: %d\n", argv[0], argc);
			exit(ERROR);
			break;

		case '?' :
		default:
			printf("Error. Ejecucion: %s <-f traza.pcap / -i eth0> [-ipo IPO] [-ipd IPD] [-po PO] [-pd PD]: %d\n", argv[0], argc);
			exit(ERROR);
			break;
		}
	}

	if (!descr) {
		printf("No selecciono ningún origen de paquetes.\n");
		return ERROR;
	}

	//Simple comprobacion de la correcion de la lectura de parametros
	printf("Filtro:");
	//if(ipo_filtro[0]!=0)
	printf("ipo_filtro:%"PRIu8".%"PRIu8".%"PRIu8".%"PRIu8"\t", ipo_filtro[0], ipo_filtro[1], ipo_filtro[2], ipo_filtro[3]);
	//if(ipd_filtro[0]!=0)
	printf("ipd_filtro:%"PRIu8".%"PRIu8".%"PRIu8".%"PRIu8"\t", ipd_filtro[0], ipd_filtro[1], ipd_filtro[2], ipd_filtro[3]);

	if (po_filtro != 0) {
		printf("po_filtro=%"PRIu16"\t", po_filtro);
	}

	if (pd_filtro != 0) {
		printf("pd_filtro=%"PRIu16"\t", pd_filtro);
	}

	printf("\n\n");

	do {
		retorno = pcap_next_ex(descr, &cabecera, (const u_char **)&paquete);

		if (retorno == 1) { //Todo correcto
			contador++;
			analizar_paquete(cabecera, paquete);

		} else if (retorno == -1) { //En caso de error
			printf("Error al capturar un paquete %s, %s %d.\n", pcap_geterr(descr), __FILE__, __LINE__);
			pcap_close(descr);
			exit(ERROR);

		}
	} while (retorno != -2);

	printf("Se procesaron %"PRIu64" paquetes.\n\n", contador);
	pcap_close(descr);
	return OK;
}



void analizar_paquete(const struct pcap_pkthdr *cabecera, const uint8_t *paquete)
{
	int tam_cab_ip=0;
	uint8_t protocolo=0;
	printf("Nº: %"PRIu64" Nuevo paquete capturado el %s\n", contador,ctime((const time_t *) & (cabecera->ts.tv_sec)));
	if((analizar_cabecera_ethernet(paquete))==OK){
		//codigo ip
 		paquete+=ETH_HLEN;
  	if((tam_cab_ip=analizar_cabecera_ip(paquete,&protocolo,ipo_filtro,ipd_filtro))!=ERROR){
			paquete+=tam_cab_ip;
			if(protocolo==0x06){
				//codigo TCP
				analizar_cabecera_TCP(paquete,&po_filtro,&pd_filtro);
				paquete+=READ_TCP;
			}else{
				//codigo UDP
				analizar_cabecera_UDP(paquete,&po_filtro,&pd_filtro);
				paquete+=READ_UDP;
			}

		}


	}

	printf("\nNº: %"PRIu64" termina el analisis del paquete %s\n", contador,ctime((const time_t *) & (cabecera->ts.tv_sec)));

	printf("\n\n");
}
