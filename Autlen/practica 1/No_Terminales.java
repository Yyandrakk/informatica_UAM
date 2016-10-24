package practica1;

import java.util.*;
	
	

public class No_Terminales {
		public String simbolo;
		public List<Reglas> reglas;
		
		public No_Terminales(String s)
		{
			this.simbolo=s;
			this.reglas= new ArrayList<Reglas>();
		}

		public String getSimbolo() {
			return simbolo;
		}

		public void setSimbolo(String simbolo) {
			this.simbolo = simbolo;
		}

		public List<Reglas> getReglas() {
			return reglas;
		} 

		public void anadirReglas(Reglas regla) {
			this.reglas.add(regla);
		}
	
		
}
