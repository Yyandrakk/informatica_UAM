package implementaciones.grafo;

import java.util.Optional;
import java.util.function.Predicate;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class ConstrainedGraph<E, K> extends Graph<E, K> {

	private Node<E> nodoTestigo = null;

	/**
	 * Comprueba que sea verdad para todos los elementos
	 * 
	 * @param pred
	 *            predicado de nodo
	 *
	 * @return true si es predicado, false si no
	 */
	public boolean forAll(Predicate<Node<E>> pred) {
		this.nodoTestigo = null;
		for (Node<E> n : this.nodos) {
			if (pred.test(n) == false) {
				this.nodoTestigo = null;
				return false;
			}
			this.nodoTestigo = n;
		}

		return true;
	}

	/**
	 * Comprueba que al menos se cumple una vez
	 * 
	 * @param pred
	 *            predicado de nodo
	 *
	 * @return true existe, false si no
	 */
	public boolean exists(Predicate<Node<E>> pred) {
		this.nodoTestigo = null;
		for (Node<E> n : this.nodos) {
			if (pred.test(n)) {
				this.nodoTestigo = n;
				return true;
			}
		}
		return false;

	}

	/**
	 * Comprueba que se cumpla solo una vez
	 * 
	 * @param pred
	 *            predicado de nodo
	 *
	 * @return true si existe uno, false si no
	 */
	public boolean one(Predicate<Node<E>> pred) {
		int cont = 0;
		this.nodoTestigo = null;
		for (Node<E> n : this.nodos) {
			if (pred.test(n)) {
				cont++;
				this.nodoTestigo = n;
			}
			if (cont > 1) {
				return false;
			}
		}
		if (cont == 1) {
			return true;
		}
		return false;
	}

	/**
	 * Retorna el nodo testigo como un Optional
	 * 
	 * @return el nodo testigo
	 */
	public Optional<Node<E>> getWitness() {
		return Optional.ofNullable(this.nodoTestigo);
	}

}
