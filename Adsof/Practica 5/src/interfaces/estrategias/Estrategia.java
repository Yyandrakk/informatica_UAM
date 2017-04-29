package interfaces.estrategias;

import implementaciones.regla.RuleSetWithStrategy;
/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */

@FunctionalInterface
public interface Estrategia<T> {
    void ejecutar(RuleSetWithStrategy<T> rs);
}
