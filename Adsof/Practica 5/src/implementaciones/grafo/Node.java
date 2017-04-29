package implementaciones.grafo;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Node<E> {

	private E ele;
	private Graph<E, ?> grafo = null;
	private final Long id;
	public static Long numNodos = 0l;

	/**
	 * Constructor para Node.
	 * 
	 * @param element
	 *            valor del nodo
	 * 
	 */
	public Node(E element) {
		this.ele = element;
		id = Node.numNodos;
		Node.numNodos++;
	}

	/**
	 *
	 * @param grafo
	 *            grafo para asignarle al nodo
	 */
	public void setGraph(Graph<E, ?> grafo) {
		this.grafo = grafo;

	}

	/**
	 *
	 * @param n
	 *            nodo para ver si estan conectados
	 * 
	 * @return true si están conectados, false si no
	 */
	public boolean isConnectedTo(Node<E> n) {
		if (this.grafo != null) {
			return this.grafo.isConnected(this, n);
		}
		return false;
	}

	/**
	 *
	 * @return el valor del nodo
	 */
	public E getValue() {
		return this.ele;
	}

	/**
	 *
	 * @return el id del nodo
	 */
	public Long getId() {
		return this.id;
	}

	/**
	 *
	 * @param e
	 *            elemento para ver si estan conectados
	 * 
	 * @return true si están conectados, false si no
	 */
	public boolean isConnectedTo(E e) {

		if (this.grafo != null) {
			return this.grafo.isConnected(this, e);
		}
		return false;

	}

	/**
	 * 
	 * @return una collection con los vecinos del nodo
	 */
	public Collection<Node<E>> neighbours() {
		if (this.grafo == null) {
			return Collections.unmodifiableCollection(Collections.emptySet());
		}

		return this.grafo.neighbours(this);
	}

	/**
	 *
	 * @param n
	 *            nodo para conseguir las aristas
	 * 
	 * @return una lista con las aristas asociadas a ese nodo
	 */
	public List<?> getEdgeValues(Node<E> n) {
		if (this.grafo == null || !this.isConnectedTo(n)) {
			return Collections.emptyList();
		}

		return this.grafo.getEdgeValues(this, n);

	}

	public String toString() {
		return this.id + " [" + this.ele + "]";
	}

	/**
	 *
	 * @param e
	 *            valor a asignar al valor del nodo
	 * 
	 */
	public void setValue(E e) {
		// TODO Auto-generated method stub
		this.ele = e;
	}
}
