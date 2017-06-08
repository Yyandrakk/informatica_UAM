#include "transporte.h"

void analizar_cabecera_UDP(const uint8_t *paquete,const uint16_t *po,const uint16_t *pd){
  uint16_t p_origen=0, p_destino=0, longitud=0;

  printf("\nDatos de nivel 4 UDP:\n\n" );
  memcpy(&p_origen,paquete,sizeof(uint16_t));
  paquete += TRANS_PORT;
  p_origen=ntohs(p_origen);
  printf("El puerto origen es %"PRIu16"\n",p_origen );

  if(comprobar_filtro(po,&p_origen)!=OK){
      printf("El puerto origen leido no coincide con el filtro\n");
      return;
  }

  memcpy(&p_destino,paquete,sizeof(uint16_t));
  paquete += TRANS_PORT;
  p_destino=ntohs(p_destino);
  printf("El puerto destino es %"PRIu16"\n",p_destino );

  if(comprobar_filtro(pd,&p_destino)!=OK){
      printf("El puerto destino leido no coincide con el filtro\n");
      return;
  }

  memcpy(&longitud,paquete,sizeof(uint16_t));
  paquete += TRANS_PORT;
  longitud=ntohs(longitud);
  printf("La longitud es %"PRIu16"\n",longitud );

}

void analizar_cabecera_TCP(const uint8_t *paquete,const uint16_t *po,const  uint16_t *pd){
  uint16_t p_origen=0, p_destino=0;

  printf("\nDatos de nivel 4 TCP:\n\n" );
  memcpy(&p_origen,paquete,sizeof(uint16_t));
  paquete += TRANS_PORT;
  p_origen=ntohs(p_origen);
  printf("El puerto origen es %"PRIu16"\n",p_origen );

  if(comprobar_filtro(po,&p_origen)!=OK){
      printf("El puerto origen leido no coincide con el filtro\n");
  }

  memcpy(&p_destino,paquete,sizeof(uint16_t));
  paquete += TRANS_PORT;
  p_destino=ntohs(p_destino);
  printf("El puerto destino es %"PRIu16"\n",p_destino );

  if(comprobar_filtro(pd,&p_destino)!=OK){
      printf("El puerto destino leido no coincide con el filtro\n");
      return;
  }

}

int comprobar_filtro(const uint16_t *pf,const uint16_t *puerto){

  return ((*pf)!=0 && (*pf)!=(*puerto)) ? ERROR : OK;

}
