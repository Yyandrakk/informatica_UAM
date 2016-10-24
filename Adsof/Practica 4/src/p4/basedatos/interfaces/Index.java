package p4.basedatos.interfaces;

import java.util.Collection;

import p4.exepcion.ExcepcionDAO;

public interface Index { 
    //Relaciona value con key. Puede haber varios valores relacionados con un mismo objeto key 
     Long add (Object key, Long value) throws ExcepcionDAO; 
     //Elimina la relación entre value y key 
     void delete(Object key, Long value) throws ExcepcionDAO; 
     //Lista los valores relacionados con key 
     Collection<Long> search(Object key) throws ExcepcionDAO; 
    //Devuelve la lista de valores desde from a to 
    //Si from o to son null, listará desde el principio, o hasta el final, respectivamente 
    //En el caso de que ambos sean null, listará todos los valores del índice 
    Collection<Long> search(Object from, Object to) throws ExcepcionDAO;  
  } 
