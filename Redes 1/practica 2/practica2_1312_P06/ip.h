#ifndef   IP_H
#define IP_H

#include "variables.h"
int analizar_cabecera_ip(const uint8_t *paquete, uint8_t *protocolo, uint8_t *ipo_filtro, uint8_t *ipd_filtro);
int obtener_flag_posicion(uint16_t *aux, uint8_t *flag, uint16_t *posicion);
int obtener_version_ihl(uint8_t *aux, uint8_t *version, uint8_t *ihl);
int comprobar_filtro_ip(uint8_t *ipo_filtro, uint8_t *ipd_filtro);
#endif
