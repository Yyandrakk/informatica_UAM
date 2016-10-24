package p4.basedatos.interfaces;

import java.util.List;

public interface TypeDescriptor{ 
    public enum Type { Long, Double, String ; } 
    public String getName(); //Nombre del tipo de datos 
    public List<String> getProperties(); //Propiedades del tipo de datos 
    public Type getType(String property); //Indica el tipo de la propiedad 
    public Entity newEntity(); // Creador de nueva entidad 
}