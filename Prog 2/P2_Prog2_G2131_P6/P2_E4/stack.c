/* 
 * File:   stack.c
 * Author: María
 *
 * Created on 13 de febrero de 2014, 13:53
 */

#include "stack.h"

/*Inicializa la pila. Devuelve ERR si ha habido un error u OK si ha ido bien */ 
STATUS iniStack (STACK *str){ 
    
    if (!str)
        return ERROR;
    
    str->top = NULL;
    
    return OK;
}

/* Comprueba si la pila está llena. Devuelve TRUE si está llena o FALSE si no lo está*/ 
BOOL isFullStack (const STACK *stc){
    
    if (stc->top == (stc->item+MAXSTACK-1))
        return TRUE;

    return FALSE;
}

/* Comprueba si la pila está vacía. Devuelve TRUE si está vacía o FALSE si no lo está. */ 
BOOL isEmptyStack (const STACK *stc){
    
    if (stc->top == NULL)
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
    
    if(isEmptyStack (stc)==TRUE)
       if((stc->top=copyEleStack(&stc->item[0],ele))!=NULL)
            return OK;
    
    if((stc->top=copyEleStack((stc->top+1),ele))!=NULL)
            return OK;    
    
    return ERROR;
        
    return OK;
}

/* Extrae un elemento de la pila. Devuelve ERR si no logra extraerlo u OK si lo extrae 
correctamente */ 
STATUS pop (STACK *stc, ELESTACK *ele){
    
    if ((!stc) || (!ele))
        return ERROR;
    
    if (isEmptyStack(stc) == TRUE)
        return ERROR;
    
    if(stc->top==stc->item)
      {
        if(copyEleStack(ele,stc->top)==NULL)
            return ERROR;
        stc->top=NULL;
        return OK;
      }
 
    else if(copyEleStack(ele,stc->top)==NULL)
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
    
    if (copyEleStack(ele, stc->top)==NULL)
        return ERROR;
    
    return OK;
    
} 

/* Imprime toda la pila en un fichero ya abierto*/ 
void printStack (FILE *pf, const STACK *stc){
    
    int i;
    if(isEmptyStack(stc)==TRUE)
            return;
    for(i=0;(stc->item+i)!=stc->top+1;i++)
    {
        printEleStack (pf, &stc->item[i]);
    }
       
}

/* Elimina la pila, teniendo en cuenta que por ahora no estamos trabajando con memoria 
dinámica */ 
STATUS destroyStack (STACK *stack){
     
    if (!stack)
        return ERROR;
     
     stack->top = NULL;
     return OK;    
}