package implementaciones.regla;

import java.util.Collection;
import java.util.LinkedHashSet;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */

public class RuleSet<T> {

	LinkedHashSet<Rule<T>> reglas = new LinkedHashSet<Rule<T>>();
	Collection<T> objetos;

	/**
	 *
	 * @param r
	 *            regla a annadir
	 *
	 * @return el RuleSet con la regla annadida
	 */

	public RuleSet<T> add(Rule<T> r) {

		this.reglas.add(r);
		return this;
	}

	/**
	 *
	 * @param str
	 *            collection a fijar
	 *
	 */
	public void setExecContext(Collection<T> str) {
		this.objetos = str;
	}

	/**
	 * recorre los objetos y les aplica una regla si es posible
	 */
	public void process() {

		for (T t : objetos) {
			for (Rule<T> r : reglas) {
				if (r.process(t)) {
					break;
				}
			}
		}

	}

	/**
	 *
	 * @return el ExecutionContext
	 */
	public Collection<T> getExecutionContext() {
		// TODO Auto-generated method stub
		return this.objetos;
	}

	/**
	 *
	 * @return set con las reglas
	 */
	public LinkedHashSet<Rule<T>> getReglas() {
		return reglas;
	}
}
