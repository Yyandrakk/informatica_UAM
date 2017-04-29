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
public class NodeTest {
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
	public void testIsConnectedToNodeOfE() {
		assertTrue(n1.isConnectedTo(n2));
	}

	@Test
	public void testGetValue() {
		assertEquals(new Integer(n1.getValue()), new Integer(1));
	}

	@Test
	public void testGetId() {

		assertNotNull(n1.getId());
	}

	@Test
	public void testIsConnectedToE() {
		assertTrue(n1.isConnectedTo(2));
	}

	@Test
	public void testNeighbours() {
		assertNotNull(n1.neighbours());
	}

	@Test
	public void testGetEdgeValues() {
		assertEquals(n1.getEdgeValues(n2).get(0), new Integer(10));
	}

}
