package practica1;

import java.io.IOException;


public class Main {

	 

	public static void main(String[] args) throws ParamException, IOException {
	        
		 Gramatica g = new Gramatica();
		 if (args.length > 4|| args.length == 0)
	            throw new ParamException(args.length);
	    	      
		if((args[1].equals("i")||args[1].equals("d"))&&(args[2].equals("p")||args[2].equals("a")||args[2].equals("u")))
				{ g.cargar_fichero (args[0]);
	    
	            g.derivar(args[1].charAt(0),args[2].charAt(0),Integer.parseInt(args[3]));
	            return;
				}
		System.out.println("Error en los parametros propercionados: Fichero, i||d, a||u||p, numero de profundidad \n");
	    }
	
	
}
