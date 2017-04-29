package implementaciones.grafo;

import java.util.*;
import java.util.function.Predicate;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class BlackBoxComparator<E, K> implements
		Comparator<ConstrainedGraph<E, K>> {

	private Map<Criteria, List<Predicate<Node<E>>>> criteria = new EnumMap<Criteria, List<Predicate<Node<E>>>>(
			Criteria.class);

	/**
	 * Asocia un predicado a un criteria
	 *
	 * @param c
	 *            tipo de criterio
	 *
	 * @param p
	 *            predicado de nodo
	 *
	 * @return un BlackBoxComparator
	 */
	public BlackBoxComparator<E, K> addCriteria(Criteria c, Predicate<Node<E>> p) {

		if (!this.criteria.containsKey(c)) {
			this.criteria.put(c, new ArrayList<Predicate<Node<E>>>());
		}
		this.criteria.get(c).add(p);

		return this;
	}

	/**
	 * Devuelve numero menor que 0 si el primero es menor, 0 si son iguales, numero mayor 0 si
	 * el segundo es menor
	 * 
	 * @param o1
	 *            primer ContrainedGraph
	 *
	 * @param o2
	 *            primer ContrainedGraph
	 *
	 * @return la diferencia entre ambos
	 */
	@Override
	public int compare(ConstrainedGraph<E, K> o1, ConstrainedGraph<E, K> o2) {
		int satisfaceo1 = 0;
		int satisfaceo2 = 0;

		for (Criteria c : this.criteria.keySet()) {
			for (Predicate<Node<E>> p : this.criteria.get(c)) {
				if (c.evaluacion(o1, p)) {
					satisfaceo1++;
				}
				if (c.evaluacion(o2, p)) {
					satisfaceo2++;
				}
			}
		}
		return satisfaceo1 - satisfaceo2;
	}

	/**
	 * @author Oscar Garcia de Lara
	 * @author Patricia Anza
	 *
	 */
	public enum Criteria {
		/**
		 * Criterio en que se evalua con exists.
		 */
		Existential {
			public <E, K> boolean evaluacion(ConstrainedGraph<E, K> g,
					Predicate<Node<E>> p) {
				return g.exists(p);
			}
		},
		/**
		 * Criterio en que se evalua con one.
		 */
		Unitary {
			public <E, K> boolean evaluacion(ConstrainedGraph<E, K> g,
					Predicate<Node<E>> p) {
				return g.one(p);
			}
		},
		/**
		 * Criterio en que se evalua con forAll.
		 */
		Universal {
			public <E, K> boolean evaluacion(ConstrainedGraph<E, K> g,
					Predicate<Node<E>> p) {
				return g.forAll(p);
			}
		};
		/**
		 * 
		 * @param g
		 *            grafo
		 * @param p
		 *            predicado a evaluar
		 * @return true si la evaluacion es positiva, false lo contrario
		 */
		public abstract <E, K> boolean evaluacion(ConstrainedGraph<E, K> g,
				Predicate<Node<E>> p);
	}

}
