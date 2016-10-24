package p4.basedatos.interfaces;

import java.util.Collection;

import p4.exepcion.ExcepcionDAO;

public interface Table{ 
    //Devuelve el tipo de dato para el que se ha creado la tabla 
    public TypeDescriptor getType();  
    //Lee el objeto de la tabla y lo convierte en una Entity 
    public Entity getEntity(Long id) throws ExcepcionDAO;  
    //Actualiza la entidad y los índices, asignándole un ID si este era null, y devuelve el ID 
    //Nota: La entidad se puede asumir que es del tipo de la tabla 
    public long updateEntity(Entity e) throws ExcepcionDAO; 
    //Elimina la entidad, si existe, actualizando los índices si es necesario 
    public void delete(Entity e) throws ExcepcionDAO; 
    //Busca las entidades que tengan el valor indicado 
    public Collection<Long> search(String property, Object value) throws ExcepcionDAO;  
    //Devuelve la lista de entidades que tienen la propiedad property, entre el valor from y to 
    //Si from o to son null, listará desde el principio, o hasta el final, respectivamente 
    //En el caso de que ambos sean null, listará todas las entidades, ordenadas por property 
    public Collection<Long> search(String property, Object from, Object to) throws ExcepcionDAO; 
 }