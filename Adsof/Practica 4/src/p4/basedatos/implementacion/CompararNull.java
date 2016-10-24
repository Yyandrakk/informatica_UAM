package p4.basedatos.implementacion;

import java.util.Comparator;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class CompararNull implements Comparator<Object> {
	public static CompararNull instance = new CompararNull();

	/**
	 * sirve para poder comparar objetos null
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int compare(Object p, Object s) {

		if (p == null) {
			return s == null ? 0 : -1;
		} else if (s == null) {
			return 1;
		} else {
			return ((Comparable<Object>) p).compareTo(s);
		}

	}
}
