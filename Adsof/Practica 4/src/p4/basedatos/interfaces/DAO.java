package p4.basedatos.interfaces;

import java.util.Collection;

import p4.exepcion.ExcepcionDAO;

public interface DAO{ 
    //Registra un nuevo tipo en la base de datos 
    public void registerType(TypeDescriptor t) throws ExcepcionDAO;  
    //Lee el objeto de la base de datos, o de cache, si se encuentra en memoria 
    public Entity getEntity(String type, Long id) throws ExcepcionDAO;  
    //Actualiza la entidad, asignándole un ID si este era null, y devuelve el ID 
    public long updateEntity(Entity e) throws ExcepcionDAO;  
    //Elimina la entidad 
    public void delete(Entity e)throws ExcepcionDAO; 
    //Busca las entidades que tengan el valor indicado 
    public Collection<Long> search(String type, String property, Object value)throws ExcepcionDAO;  
    //Devuelve la lista de entidades que tienen la propiedad property, entre el valor from y to 
    //Si from o to son null, listará desde el principio, o hasta el final, respectivamente 
    //En el caso de que ambos sean null, listará todas las entidades, ordenadas por property 
    public Collection<Long> search(String type, String property, Object from, Object to)throws ExcepcionDAO; 
 }