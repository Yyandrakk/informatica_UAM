package implementaciones.grafo;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Edge<K, E> {
	Node<E> fuente;
	K valor;
	Node<E> objetivo;

	/**
	 * Constructor para Graph.
	 *
	 * @param fuente
	 *            nodo de origen
	 *
	 * @param valor
	 *            valor de la arista
	 *
	 * @param objetivo
	 *            nodo de destino
	 * 
	 */
	public Edge(Node<E> fuente, K valor, Node<E> objetivo) {
		this.fuente = fuente;
		this.valor = valor;
		this.objetivo = objetivo;
	}

	/**
	 * 
	 * @return el valor de la arista
	 */
	public K getValor() {
		return this.valor;
	}

	/**
	 * 
	 * @return el nodo de origen de la arista
	 */
	public Node<E> getObjetivo() {
		return this.objetivo;
	}

	public String toString() {
		return "( " + fuente.getId() + " --" + valor + "--> "
				+ objetivo.getId() + " )";
	}
}
