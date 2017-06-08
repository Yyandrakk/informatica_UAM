#ifndef   TRANSPORTE_H
#define TRANSPORTE_H

#include "variables.h"
void analizar_cabecera_UDP(const uint8_t *paquete,const uint16_t *po, const uint16_t *pd);
void analizar_cabecera_TCP(const uint8_t *paquete,const uint16_t *po,const uint16_t *pd);
int comprobar_filtro(const uint16_t *pf,const uint16_t *puerto);
#endif
