package practica1;

import java.util.*;


public class Reglas {

	public String no_term;
	public  List<String> derecha ;
	
	public Reglas (String a, List<String> simb)
	{
		this.no_term=a;
		this.derecha=new ArrayList<String>(simb);

	}
	public List<String> getDerecha()
	{
		return derecha;
	}
}
