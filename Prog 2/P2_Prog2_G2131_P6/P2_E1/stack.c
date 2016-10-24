/* 
 * File:   stack.c
 * Author: María y Oscar
 *
 * Created on 13 de febrero de 2014, 13:53
 */

#include <stdio.h>
#include <stdlib.h>

#include "stack.h"
/*
 * 
 */



    /*Inicializa la pila. Devuelve ERR si ha habido un error u OK si ha ido bien */ 
STATUS iniStack (STACK *str){ 
        if (!str)
            return ERROR;
        str->top = 0;
        return OK;
}

/* Comprueba si la pila está llena. Devuelve TRUE si está llena o FALSE si no lo está*/ 
BOOL isFullStack (const STACK *stc){
    
    if (stc->top == MAXSTACK)
        return TRUE;
    return FALSE;
}

/* Comprueba si la pila está vacía. Devuelve TRUE si está vacía o FALSE si no lo está. */ 
BOOL isEmptyStack (const STACK *stc){
   
    if (stc->top == 0)
        return TRUE;
    
    return FALSE;
}

/* Inserta un elemento en la pila. Devuelve ERR si no logra insertarlo u OK si se inserta 
correctamente */ 
STATUS push (STACK *stc, const ELESTACK *ele){
    if ((!stc) || (!ele))
        return ERROR;
    if (isFullStack(stc) == TRUE )
        return ERROR;
    if (copyEleStack(&stc->item[stc->top],ele) == NULL)
        return ERROR;
    stc->top++;
    return OK;
}

/* Extrae un elemento de la pila. Devuelve ERR si no logra extraerlo u OK si lo extrae 
correctamente */ 
STATUS pop (STACK *stc, ELESTACK *ele){
    if ((!stc) || (!ele))
        return ERROR;
    if (isEmptyStack(stc) == TRUE)
        return ERROR;
    if(copyEleStack(ele, &stc->item[stc->top-1])==NULL)
        return ERROR;
    stc->top--;
    return OK;
}

/* Copia el elemento que está en el tope de la pila sin extraerlo de la pila. Devuelve ERR si no 
logra copiarlo u OK si lo copia correctamente */ 
STATUS topStack (const STACK *stc, ELESTACK *ele){
    if ((!stc) || (!ele))
        return ERROR;
     if (isEmptyStack(stc) == TRUE)
        return ERROR;
    if (copyEleStack(ele, &stc->item[stc->top-1])==NULL)
        return ERROR;
    return OK;
    
} 

/* Imprime toda la pila en un fichero ya abierto*/ 
void printStack (FILE *pf, const STACK *stc){
    int i;
    for(i=0;i<stc->top;i++)
    {
        printEleStack (pf, &stc->item[i]);
    }
       
}

/* Elimina la pila, teniendo en cuenta que por ahora no estamos trabajando con memoria 
dinámica */ 
STATUS destroyStack (STACK *stack){
     if (!stack)
         return ERROR;
     stack->top = 0;
         return OK;    
} 

    

