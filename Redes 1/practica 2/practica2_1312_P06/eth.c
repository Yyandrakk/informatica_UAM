#include "eth.h"

int analizar_cabecera_ethernet(const uint8_t *paquete){
	int i = 0;
	uint16_t tipo_eth = 0x0800, tipo_eth_aux = 0, posicion = 0;

	printf("Direccion ETH destino= ");
	printf("%02X", paquete[0]);

	for (i = 1; i < ETH_ALEN; i++) {
		printf(":%02X", paquete[i]);
	}

	printf("\n");
	paquete += ETH_ALEN;

	printf("Direccion ETH origen = ");
	printf("%02X", paquete[0]);

	for (i = 1; i < ETH_ALEN; i++) {
		printf(":%02X", paquete[i]);
	}

	printf("\n");
	paquete+=ETH_ALEN;

	memcpy(&tipo_eth_aux, paquete, sizeof(uint16_t));
	posicion+=sizeof(uint16_t);
	tipo_eth_aux = ntohs(tipo_eth_aux);
	printf("Tipo ETH = 0x%04X\n", tipo_eth_aux);


	if(tipo_eth_aux != tipo_eth){
		printf("\nEl siguiente protocolo no es IP\n");
		return ERROR;
	}
	else return OK;


}
