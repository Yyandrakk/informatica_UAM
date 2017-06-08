/***************************************************************************
practica1.c

Ejercicio 1 de la practica 1


 Autor: Oscar Garcia de Lara
 Autor: Santiago Gomez
 2016 EPS-UAM
***************************************************************************/
#include "practica1.h"

pcap_t *descr=NULL,*descr2=NULL;
pcap_dumper_t *pdumper=NULL;
int contador=0;

void handle(int nsignal){
	printf("\nControl C pulsado\n");
	if(descr!=NULL)
		pcap_close(descr);
	if(descr2!=NULL)
		pcap_close(descr2);
	if(pdumper!=NULL)
		pcap_dump_close(pdumper);

	printf("Se ha capturado un total de %d paquetes\n", contador);
	exit(OK);
 }

void capturar_traza(char* fichero){
	char errbuf[PCAP_ERRBUF_SIZE];
	if ((descr = pcap_open_offline(fichero, errbuf)) == NULL){
		printf("Error: pcap_open_offline(): %s, %s %d.\n",errbuf,__FILE__,__LINE__);
		exit(ERROR);
	}

	analisis(OFFLINE);
}
void capturar_online(){
	char errbuf[PCAP_ERRBUF_SIZE];
	char file_name[256];
	struct timeval time;

  //Apertura de interface
  if ((descr = pcap_open_live("eth0",ETH_FRAME_MAX,0,100, errbuf)) == NULL){
  printf("Error: pcap_open_live(): %s, %s %d.\n",errbuf,__FILE__,__LINE__);
  exit(ERROR);
  }

	//Volcado de traza
	descr2=pcap_open_dead(DLT_EN10MB,ETH_FRAME_MAX);
	if (!descr2){
		printf("Error al abrir el dump.\n");
		pcap_close(descr);
		exit(ERROR);
	}
	gettimeofday(&time,NULL);
	sprintf(file_name,"eth0.%lld.pcap",(long long)time.tv_sec);
	pdumper=pcap_dump_open(descr2,file_name);
	if(!pdumper){
		printf("Error al abrir el dumper: %s, %s %d.\n",pcap_geterr(descr2),__FILE__,__LINE__);
		pcap_close(descr);
		pcap_close(descr2);
		exit(ERROR);
	}
	analisis(ONLINE);

}

void analisis(tipo_analisis tipo){
	uint8_t *paquete=NULL;
	struct pcap_pkthdr *cabecera=NULL;
	int retorno=0,i=0;

	while (1){
			retorno = pcap_next_ex(descr,&cabecera,(const u_char **)&paquete);
			if(retorno == -1){ 		//En caso de error
				printf("Error al capturar un paquete %s, %s %d.\n",pcap_geterr(descr),__FILE__,__LINE__);
				if(descr!=NULL)
					pcap_close(descr);
				if(descr2!=NULL)
					pcap_close(descr2);
				if(pdumper!=NULL)
					pcap_dump_close(pdumper);
			}
			else if(retorno == 0){
				continue;
			}
			else if(retorno==-2){
				break;
			}
				//En otro caso
			contador++;
			printf("Nuevo paquete capturado a las %s\n",ctime((const time_t*)&(cabecera->ts.tv_sec)));
			if(tipo==ONLINE){
				cabecera->ts.tv_sec=cabecera->ts.tv_sec-(2628000);
				pcap_dump((uint8_t *)pdumper,cabecera,paquete);
			}

			for(i=0;i<15;i++){
				printf("%02x ",paquete[i]);
			}
			printf("\n");
		}
		printf("Se ha capturado un total de %d paquetes\n", contador);
		if(descr!=NULL)
		 	pcap_close(descr);
		if(descr2!=NULL)
		 	pcap_close(descr2);
		if(pdumper!=NULL)
		 	pcap_dump_close(pdumper);


		exit(OK);
}

int main(int argc, char **argv)
{

  if(signal(SIGINT,handle)==SIG_ERR){
		printf("Error: Fallo al capturar la senal SIGINT.\n");
		exit(ERROR);
	}

  switch (argc) {
    case NINGUNO:
		 capturar_online();
    break;
    case UNARGUMENTO:
			capturar_traza(argv[1]);
    break;
    default:
    printf("Error: Ha ejecutado el programa con mas de un argumento .\n");
		exit(ERROR);

  }

	exit(ERROR);
}
