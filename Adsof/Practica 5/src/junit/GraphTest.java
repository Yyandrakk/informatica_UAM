package junit;

import static org.junit.Assert.*;
import implementaciones.grafo.Graph;
import implementaciones.grafo.Node;

import org.junit.Before;
import org.junit.Test;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class GraphTest {
	private Graph<Integer, Integer> grafo;
	private Node<Integer> n1;
	private Node<Integer> n2;

	@Before
	public void setUp() {
		this.grafo = new Graph<>();
		this.n1 = new Node<>(1);
		this.n2 = new Node<>(2);
		this.grafo.add(n1);
		this.grafo.add(n2);
		this.grafo.connect(n1, 10, n2);
	}

	@Test
	public final void testIsConnectedNodeOfENodeOfE() {
		assertTrue(this.grafo.isConnected(n1, n2));
	}

	@Test
	public final void testIsConnectedNodeOfEE() {
		assertTrue(this.grafo.isConnected(n1, 2));
	}

	@Test
	public final void testNeighbours() {
		assertNotNull(this.grafo.neighbours(n1));
	}

	@Test
	public final void testGetEdgeValues() {
		assertEquals(this.grafo.getEdgeValues(n1, n2).get(0), new Integer(10));
	}

}
