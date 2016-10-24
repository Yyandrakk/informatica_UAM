package p4.basedatos.interfaces;

public interface Entity { 
    //Id único para cada entidad del mismo tipo de datos. Null si no se ha guardado aún 
    public Long getId(); 
    public void setId(Long id); //Este método solo lo usará la base de datos, para asignar el id 
    public String getType(); //Nombre del tipo de datos 
    public Object getProperty(String property); //Obtiene el valor de una propiedad 
    public void setProperty(String property, Object value); //Modifica el valor de una propiedad 
  }