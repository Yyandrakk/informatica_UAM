package junit;

import static org.junit.Assert.*;
import implementaciones.grafo.Edge;
import implementaciones.grafo.Node;

import org.junit.Before;
import org.junit.Test;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */

public class EdgeTest {
	private Edge<Integer, Integer> arista;
	private Node<Integer> n1;
	private Node<Integer> n2;

	@Before
	public void setUp() {
		this.n1 = new Node<>(1);
		this.n2 = new Node<>(2);
		this.arista = new Edge<Integer, Integer>(n1, 10, n2);
	}

	@Test
	public final void testGetValor() {
		assertEquals(this.arista.getValor(), new Integer(10));
	}

	@Test
	public final void testGetObjetivo() {
		assertEquals(this.arista.getObjetivo(), this.n2);
	}

}
