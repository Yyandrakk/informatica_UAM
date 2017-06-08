#include "ip.h"
/**
  return: ERROR en caso que sea un paquete no valido o el tamaño de la cabecera;
*/
int analizar_cabecera_ip(const uint8_t *paquete, uint8_t *protocolo, uint8_t *ipo_filtro, uint8_t *ipd_filtro){
  uint16_t  longitud_total=0,aux_flag_posicion=0,suma_control=0,posicion=0;
  uint8_t version=0,aux_version_ihl=0,ihl=0,tipo_servicio=0,flags=0,tiempo_de_vida,dir_origen[IP_ALEN]={0},dir_destino[IP_ALEN]={0};

  int i=0;

  printf("\nDatos de nivel 3:\n\n" );
  memcpy(&aux_version_ihl,paquete,sizeof(uint8_t));
  paquete+=sizeof(uint8_t);

  if(obtener_version_ihl(&aux_version_ihl, &version, &ihl)!=OK){
    printf("La version no es IPv4\n");
    return ERROR;
  }

  printf("La version es IPv%"PRIu8" y el ihl es %02x por tanto el tamaño de la cabecera es %d Byte\n",version,ihl,ihl*4);

  memcpy(&tipo_servicio,paquete,sizeof(uint8_t));
  paquete+=sizeof(uint8_t);

  //printf("El tipo de servicio es %02x\n",tipo_servicio );

  memcpy(&longitud_total,paquete,sizeof(uint16_t));
  paquete+=sizeof(uint16_t);
  longitud_total=ntohs(longitud_total);

  printf("La longitud total es %"PRIu16"\n",longitud_total);

  paquete+=sizeof(uint16_t);//Ignorar identificador

  memcpy(&aux_flag_posicion,paquete,sizeof(uint16_t));
  paquete+=sizeof(uint16_t);
  aux_flag_posicion=ntohs(aux_flag_posicion);
  if(obtener_flag_posicion(&aux_flag_posicion, &flags,&posicion)!=OK){
    printf("El flag es 0x%02x y La posicion/desplazamiento es %"PRIu16" por tanto  el paquete no es el primer fragmento \n",flags,posicion*8);
    return ERROR;
  }
  printf("El flag es 0x%02x y La posicion/desplazamiento es %"PRIu16" \n",flags,posicion);

  memcpy(&tiempo_de_vida,paquete,sizeof(uint8_t));
  paquete+=sizeof(uint8_t);

  printf("El tiempo de vida es %"PRIu8"\n",tiempo_de_vida );

  memcpy(protocolo,paquete,sizeof(uint8_t));
  paquete+=sizeof(uint8_t);
  switch (*protocolo) {
    case 0x06:
    printf("El protocolo es TCP\n");
    break;
    case 0x11:
    printf("El protocolo es UDP\n");
    break;
    default:
    printf("No es el protocolo esperado\n");
    return ERROR;
    break;
  }

  memcpy(&suma_control,paquete,sizeof(uint16_t));
  paquete+=sizeof(uint16_t);
  suma_control=ntohs(suma_control);


  printf("La suma de control 0x%04x\n",suma_control );

  printf("La direccion de origen es: ");
  for(i=0;i<IP_ALEN;i++){
    memcpy(dir_origen+i,paquete,sizeof(uint8_t));
    paquete+=sizeof(uint8_t);
    if(i!=3)
      printf("%"PRIu8".",dir_origen[i]);
    else
    printf("%"PRIu8"\n",dir_origen[i]);
  }

  if(comprobar_filtro_ip(ipo_filtro, dir_origen)==ERROR){
	  printf("La ip origen no cumple el filtro\n");
	  return ERROR;
  }

  printf("La direccion de destino es: ");
  for(i=0;i<IP_ALEN;i++){
    memcpy(dir_destino+i,paquete,sizeof(uint8_t));
    paquete+=sizeof(uint8_t);
    if(i!=3)
      printf("%"PRIu8".",dir_destino[i]);
    else
      printf("%"PRIu8"\n",dir_destino[i]);
  }

  if(comprobar_filtro_ip(ipd_filtro, dir_destino)==ERROR){
	  printf("La ip destino no cumple el filtro\n");
	  return ERROR;
  }

  return ihl*4;//Tamano de la cabecera


}

int obtener_version_ihl(uint8_t *aux, uint8_t *version, uint8_t *ihl){

  uint8_t aux2=(((*aux)&0xF0)>>4);
  memcpy(version,&aux2,sizeof(uint8_t));
  if((*version)!=0x04){
    return ERROR;
  }
  aux2=((*aux)&0x0F);
  memcpy(ihl,&aux2,sizeof(uint8_t));
  return OK;
}

int obtener_flag_posicion(uint16_t *aux, uint8_t *flag, uint16_t *posicion){

  uint16_t aux2=((*aux)&0xE000)>>13;
  memcpy(flag,&aux2,sizeof(uint8_t));
  aux2=(((*aux)&0x1FFF));
  memcpy(posicion,&aux2,sizeof(uint16_t));
  if((*posicion)!=0x0000){
    return ERROR;
  }
  return OK;
}

int comprobar_filtro_ip(uint8_t *ip_filtro, uint8_t *dir){
  int i;
	for(i=0; i<IP_ALEN; i++){
		if(ip_filtro[i]!=0 && ip_filtro[i]!=dir[i])
			return ERROR;
	}

	return OK;
}
