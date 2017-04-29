package implementaciones.regla;



/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */

public class Rule<T> {
	private String nombre;
	private String descripcion;
	private Predicate<T> condicion;
	private Consumer<T> consecuencia;

	/**
	 * Constructor para Rule.
	 *
	 * @param nombre
	 *            nombre de la regla
	 *
	 * @param des
	 *            descripcion de la regla
	 */
	public Rule(String nombre, String des) {
		this.nombre = nombre;
		this.descripcion = des;
	}

	
	 /**
	 *
	 * @param nombre
	 *            nombre de la regla
	 *
	 * @param des
	 *            descripcion de la regla
	 *
	 * @return una regla con esas caracteristicas
	 */
	 
	public static <T> Rule<T> rule(String nombre, String des) {

		return new Rule<T>(nombre, des);
	}

	/**
	 *
	 * @param pred
	 *            un predicado
	 *
	 * @return la regla con esa condicion
	 */
	public Rule<T> when(Predicate<T> pred) {

		this.condicion = pred;

		return this;
	}

	/**
	 *
	 * @param consumer
	 *            un consumer
	 *
	 * @return la regla con esa consecuencia
	 */
	public Rule<T> exec(Consumer<T> consumer) {

		this.consecuencia = consumer;

		return this;
	}

	/**
	 *
	 * @param objeto
	 *            objeto de tipo T para procesar
	 *
	 * @return true si lo procesa, false si no
	 */
	public boolean process(T objeto) {

		if (condicion.test(objeto)) {
			consecuencia.accept(objeto);
			return true;
		}
		return false;
	}

	/**
	 *
	 * @param objeto
	 *            objeto de tipo T para testar
	 *
	 * @return true si lo procesa, false si no
	 */

	public boolean test(T objeto) {
		return condicion.test(objeto);

	}

	/**
	 *
	 * @param objeto
	 *            objeto de tipo T para aceptar
	 *
	 */

	public void accept(T objeto) {
		consecuencia.accept(objeto);
	}

	public String toString() {
		return nombre + ": " + descripcion;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((nombre == null) ? 0 : nombre.hashCode());
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (!(obj instanceof Rule)) {
			return false;
		}
		Rule<?> other = (Rule<?>) obj;
		if (nombre == null) {
			if (other.nombre != null) {
				return false;
			}
		} else if (!nombre.equals(other.nombre)) {
			return false;
		}
		return true;
	}
}