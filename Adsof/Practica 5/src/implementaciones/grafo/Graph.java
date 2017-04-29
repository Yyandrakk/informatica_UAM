package implementaciones.grafo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Graph<E, K> implements Collection<Node<E>> {

	protected LinkedHashSet<Node<E>> nodos;
	protected LinkedHashMap<Node<E>, LinkedHashSet<Edge<K, E>>> aristas;

	/**
	 * Constructor para Graph.
	 * 
	 */
	public Graph() {
		this.nodos = new LinkedHashSet<Node<E>>();
		this.aristas = new LinkedHashMap<Node<E>, LinkedHashSet<Edge<K, E>>>();
	}

	/**
	 * Crea una arista entre los dos nodos
	 * 
	 * @param e1
	 *            primer nodo para conectar
	 * @param k
	 *            valor de la arista
	 * @param e2
	 *            segundo nodo para conectar
	 */
	public void connect(Node<E> e1, K k, Node<E> e2) {
		nodos.add(e1);
		nodos.add(e2);
		Edge<K, E> arista1 = new Edge<K, E>(e1, k, e2);
		LinkedHashSet<Edge<K, E>> enlaces;

		if (!this.aristas.containsKey(e1)) {
			enlaces = new LinkedHashSet<Edge<K, E>>();
			this.aristas.put(e1, enlaces);
		} else {
			enlaces = this.aristas.get(e1);
		}

		enlaces.add(arista1);
		e1.setGraph(this);
		e2.setGraph(this);

	}

	/**
	 *
	 * @param nodo1
	 *            primer nodo para ver si estan conectados
	 *
	 * @param nodo2
	 *            segundo nodo para ver si estan conectados
	 *
	 * @return true si estan conectados, false si no
	 */
	public boolean isConnected(Node<E> nodo1, Node<E> nodo2) {
		if (nodo1 == null || nodo2 == null || !this.aristas.containsKey(nodo1)) {
			return false;
		}
		LinkedHashSet<Edge<K, E>> fuente = this.aristas.get(nodo1);

		for (Edge<K, E> f : fuente) {
			if (f.getObjetivo().equals(nodo2)) {
				return true;
			}
		}
		return false;
	}

	/**
	 *
	 * @param nodo1
	 *            primer nodo para ver si estan conectados
	 *
	 * @param valor
	 *            valor para ver si estan conectados
	 *
	 * @return true si estan conectados, false si no
	 */
	public boolean isConnected(Node<E> nodo1, E valor) {
		if (nodo1 == null || valor == null || !this.aristas.containsKey(nodo1)) {
			return false;
		}
		Node<E> nodo2 = null;
		for (Node<E> n : this.nodos) {
			if (n.getValue().equals(valor)) {
				nodo2 = n;
				break;
			}
		}
		return this.isConnected(nodo1, nodo2);
	}

	/**
	 * @param n
	 *            nodo para ver sus vecinos
	 * 
	 * @return una collection con los vecinos del nodo
	 */
	public Collection<Node<E>> neighbours(Node<E> n) {
		if (!this.aristas.containsKey(n)) {
			return Collections.unmodifiableCollection(Collections.emptySet());
		}
		LinkedHashSet<Node<E>> vecinos = new LinkedHashSet<Node<E>>();
		for (Node<E> nodo : this.nodos) {
			if (this.isConnected(n, nodo)) {
				vecinos.add(nodo);
			}
		}
		if (vecinos.size() == 0) {
			return Collections.unmodifiableCollection(Collections.emptySet());
		}
		return Collections.unmodifiableCollection(vecinos);

	}

	/**
	 *
	 * @param nodo1
	 *            nodo 1 para conseguir las aristas
	 *
	 * @param nodo2
	 *            nodo 2 para conseguir las aristas
	 * 
	 * @return una lista con las aristas asociadas a esos nodos
	 */
	public List<K> getEdgeValues(Node<E> nodo1, Node<E> nodo2) {
		LinkedHashSet<Edge<K, E>> fuente = this.aristas.get(nodo1);
		List<K> comunes = new ArrayList<K>();
		for (Edge<K, E> f : fuente) {
			if (f.getObjetivo().equals(nodo2)) {
				comunes.add(f.getValor());
			}
		}
		return comunes;
	}

	@Override
	public String toString() {
		String cadena;
		cadena = "Nodes:\n";
		for (Node<E> n : this.nodos) {
			cadena += n;
			cadena += "\n";
		}
		cadena += "Edges:\n";
		for (LinkedHashSet<Edge<K, E>> aristas : this.aristas.values()) {
			for (Edge<K, E> a : aristas) {
				cadena += a;
				cadena += "\n";
			}
		}
		return cadena;
	}

	/**
	 * 
	 * @return el tamanio
	 */
	@Override
	public int size() {

		return this.nodos.size();
	}

	/**
	 * 
	 * @return true si esta vacio, false si no
	 */
	@Override
	public boolean isEmpty() {

		return this.nodos.isEmpty();
	}

	/**
	 * @param o
	 *            objeto para ver si lo contiene
	 * 
	 * @return true si lo contiene, false si no
	 */
	@Override
	public boolean contains(Object o) {
		if (o == null) {
			return false;
		}
		return this.nodos.contains(o);
	}

	/**
	 * 
	 * @return el siguiente valor dentro del map
	 */
	@Override
	public Iterator<Node<E>> iterator() {
		// TODO Auto-generated method stub

		return this.nodos.iterator();
	}

	/**
	 * 
	 * @return el mapa de nodos en forma de array
	 */
	@Override
	public Object[] toArray() {
		return this.nodos.toArray();
	}

	/**
	 * @param a
	 *            array
	 *
	 * @return el mapa de nodos en forma de array
	 */
	@Override
	public <T> T[] toArray(T[] a) {

		return this.nodos.toArray(a);
	}

	/**
	 * @param e
	 *            nodo a annadir
	 * 
	 * @return true si se annade bien, false si no
	 */
	@Override
	public boolean add(Node<E> e) {
		if (e == null) {
			return false;
		}
		if (this.nodos.add(e) == true) {
			e.setGraph(this);
			return true;
		}

		return false;
	}

	/**
	 * @param o
	 *            objeto a eliminar
	 * 
	 * @return true si se elimina bien, false si no
	 */
	@Override
	public boolean remove(Object o) {
		if (o == null) {
			return false;
		}
		if (this.nodos.remove(o) == true) {
			((Node<E>) o).setGraph(null);
			return true;
		}

		return false;
	}

	/**
	 * @param c
	 *            collection para ver si lo contiene
	 * 
	 * @return true si lo contiene, false si no
	 */
	@Override
	public boolean containsAll(Collection<?> c) {
		if (c == null) {
			return false;
		}
		return this.nodos.containsAll(c);
	}

	/**
	 * @param c
	 *            collection para annadir
	 * 
	 * @return true si lo annade bien, false si no
	 */
	@Override
	public boolean addAll(Collection<? extends Node<E>> c) {
		if (c == null) {
			return false;
		}
		if (this.nodos.addAll(c)) {
			for (Node<E> e : c) {
				e.setGraph(this);
			}
			return true;
		}
		return false;
	}

	/**
	 * @param c
	 *            collection para eliminar
	 * 
	 * @return true si lo elimina bien, false si no
	 */
	@Override
	public boolean removeAll(Collection<?> c) {
		if (c == null) {
			return false;
		}
		if (this.nodos.removeAll(c)) {
			for (Node<E> e : ((Collection<Node<E>>) c)) {
				e.setGraph(this);
			}
			return true;
		}
		return false;
	}

	/**
	 * @param c
	 *            collection para hacer la interseccion
	 * 
	 * @return la diferencia entre ambas colecciones
	 */
	@Override
	public boolean retainAll(Collection<?> c) {
		if (c == null) {
			return false;
		}
		return this.nodos.retainAll(c);
	}

	/**
	 * Limpia los nodos
	 */
	@Override
	public void clear() {

		this.nodos.clear();

	}
}
