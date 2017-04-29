package implementaciones.estrategias;

import implementaciones.regla.Rule;
import implementaciones.regla.RuleSetWithStrategy;
import interfaces.estrategias.Estrategia;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Sequence<T> implements Estrategia<T> {

    /**
     * Ejecuta la estrategia, encuentra un elemento y una regla compatible y la
     * ejecuta, solo lo hace una vez
     * 
     * @param rs
     *            el RuleSetStrategy
     *
     */
    @Override
    public void ejecutar(RuleSetWithStrategy<T> rs) {

	for (T t : rs.getExecutionContext()) {
	    for (Rule<T> r : rs.getReglas()) {
		if (r.process(t)) {
		    return;
		}
	    }
	}
    }

}
