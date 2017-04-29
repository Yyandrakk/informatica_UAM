package implementaciones.regla;

import java.util.Observable;
import java.util.Observer;
import java.util.function.Consumer;
import java.util.function.Predicate;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class TriggeredRule<T extends Observable> implements Observer {
	private String nombre;
	private T objeto;
	private String argumento;
	private Predicate<T> condicion;
	private Consumer<T> consecuencia;

	/**
	 * Constructor para TriggeredRule.
	 *
	 * @param nombre
	 *            nombre del TriggeredRule
	 *
	 */

	public TriggeredRule(String nombre) {
		this.nombre = nombre;
		// TODO Auto-generated constructor stub
	}

	/**
	 *
	 * @param nombre
	 *            nombre del TriggeredRule
	 *
	 * @return un nuevo TriggeredRule con esas caracteristicas
	 */
	public static <T extends Observable> TriggeredRule<T> trigRule(String nombre) {

		return new TriggeredRule<T>(nombre);
	}

	/**
	 * se añade a la regla el objeto y el argumento que se quieren observar, se
	 * le añade al objeto esta regla
	 * 
	 * @param t
	 *            elemento de tipo T
	 *
	 * @param argumento
	 *            argumento del TriggeredRule
	 *
	 * @return el TriggeredRule con esas caracteristicas
	 */
	public TriggeredRule<T> trigger(T t, String argumento) {

		this.objeto = t;
		this.argumento = argumento;
		this.objeto.addObserver(this);
		return this;
	}

	/**
	 * @param pred
	 *            predicado
	 *
	 * @return el TriggeredRule con esas caracteristicas
	 */
	public TriggeredRule<T> when(Predicate<T> pred) {

		this.condicion = pred;

		return this;
	}

	/**
	 * @param consumer
	 *            Consumer
	 *
	 * @return el TriggeredRule con esas caracteristicas
	 */
	public TriggeredRule<T> exec(Consumer<T> consumer) {

		this.consecuencia = consumer;

		return this;
	}

	/**
	 * Compreuba que la actualizacion del objeto es para esta regla, si es asi
	 * lo procesa
	 * 
	 * @param o
	 *            Observable
	 *
	 * @param arg
	 *            de tipo Object
	 *
	 */
	@Override
	public void update(Observable o, Object arg) {
		if (o != null && arg != null && o.equals(this.objeto)
				&& this.argumento.equals(arg)) {
			if (this.condicion.test(this.objeto)) {
				this.consecuencia.accept(this.objeto);
			}
		}

	}
}
