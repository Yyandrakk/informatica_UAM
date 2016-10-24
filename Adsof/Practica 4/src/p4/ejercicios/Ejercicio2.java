package p4.ejercicios;

import java.util.Collection;

import p4.basedatos.implementacion.IndexImpl;
import p4.basedatos.interfaces.Index;
import p4.exepcion.ExcepcionDAO;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 * 
 *         prueba la implementacion Index (IndexImpl)
 */
public class Ejercicio2 {
	/**
	 * punto de entrada a la aplicacion
	 * 
	 * @param args
	 *            los argumentos de linea de comandos no se usan
	 */
	public static void main(String[] args) {

		Index indice = new IndexImpl();

		try {
			indice.add("patricia", 10L);

			indice.add("patricia", 6L);
			Collection<Long> s = indice.search("patricia");

			System.out.println(s);

			indice.delete("patricia", 10L);

			System.out.println(s);

			indice.add("oscar", 10L);
			indice.add("oscar", 7L);
			indice.add("a", 1L);
			indice.add("a", 2L);
			indice.add("b", 3L);
			indice.add("b", 4L);

			s = indice.search("b", "patricia");
			System.out.println(s);
		} catch (ExcepcionDAO e) {
			// TODO Auto-generated catch block
			System.out.println(e);
		}

	}

}
