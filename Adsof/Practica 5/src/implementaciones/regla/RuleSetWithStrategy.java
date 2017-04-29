package implementaciones.regla;

import java.util.function.Predicate;

import implementaciones.estrategias.Sequence;
import interfaces.estrategias.Estrategia;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class RuleSetWithStrategy<T> extends RuleSet<T> implements Predicate<T> {
	private Estrategia<T> estrategia = new Sequence<T>();
	private Rule<T> regla;
	private T objeto;

	/**
	 * Constructor para RuleSetWithStrategy.
	 *
	 * @param estrategia
	 *            estrategia de la regla
	 *
	 */
	public RuleSetWithStrategy(Estrategia<T> estrategia) {
		this.estrategia = estrategia;
	}

	/**
	 * Procesa los objetos segun la estrategia
	 */
	@Override
	public void process() {
		estrategia.ejecutar(this);
	}

	/**
	 *
	 * @param t
	 *            t para probar
	 *
	 * @return true o false
	 */
	@Override
	public boolean test(T t) {

		for (Rule<T> r : reglas) {
			if (r.test(t)) {
				regla = r;
				objeto = t;
				return true;
			}
		}
		return false;
	}

	public void accept() {
		regla.accept(objeto);
	}

}
