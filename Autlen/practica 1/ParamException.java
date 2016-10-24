package practica1;

public class ParamException extends Exception{

/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
private final int n_param;
    
    public ParamException (int n_params)
    {
        this.n_param = n_params;
        
    }
    
    @Override
    public String toString (){
        return "ERROR: El numero de parametros son 4, introdujo"+this.n_param;
    }
	
}
