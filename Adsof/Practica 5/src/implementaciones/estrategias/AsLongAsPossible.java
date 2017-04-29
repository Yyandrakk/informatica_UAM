package implementaciones.estrategias;

import implementaciones.regla.RuleSetWithStrategy;
import interfaces.estrategias.Estrategia;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class AsLongAsPossible<T> implements Estrategia<T> {

    /**
     * Ejecuta la estrategia Mientras encuentre algun elemento donde se pueda
     * una regla se siguen ejecutando la regla con ese elemento
     * 
     * @param rs
     *            el RuleSetStrategy
     */
    @Override
    public void ejecutar(RuleSetWithStrategy<T> rs) {
	while (rs.getExecutionContext().stream().anyMatch(rs)) {
	    rs.accept();
	}
    }
}
