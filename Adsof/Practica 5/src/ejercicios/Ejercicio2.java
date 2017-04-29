package ejercicios;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import implementaciones.grafo.BlackBoxComparator;
import implementaciones.grafo.ConstrainedGraph;
import implementaciones.grafo.Node;
import implementaciones.grafo.BlackBoxComparator.Criteria;

public class Ejercicio2 {
    public static void main(String... args) {
	
	ConstrainedGraph<Integer, Integer> g = new ConstrainedGraph<Integer, Integer>();
	Node<Integer> n1 = new Node<Integer>(1);
	Node<Integer> n2 = new Node<Integer>(2);
	Node<Integer> n3 = new Node<Integer>(3);
	g.addAll(Arrays.asList(n1, n2, n3));
	g.connect(n1, 1, n2);
	g.connect(n1, 7, n3);
	g.connect(n2, 1, n3);
	System.out.println("Todo nodo de g conectado con n3? "+g.forAll(n -> n.equals(n3) || n.isConnectedTo(n3)));
	System.out.println("Existe exactamente un nodo de g conectado con n2? "+g.one( n -> n.isConnectedTo(n2)));
	System.out.println("Existe al menos un nodo de g conectado con n2? "+g.exists( n -> n.isConnectedTo(n2)));
	
	g.exists( n -> n.getValue().equals(89));
	// No se cumple: el nodo witness es null
	g.getWitness().ifPresent( w -> System.out.println("Witness 1 = "+g.getWitness().get()));
	g.exists( n -> n.isConnectedTo(n2));
	// Se cumple: el nodo witness está definido
	g.getWitness().ifPresent( w -> System.out.println("Witness 2 = "+g.getWitness().get()));
	
	
	ConstrainedGraph<Integer, Integer> g1 = new ConstrainedGraph<Integer, Integer>();
	g1.addAll(Arrays.asList(new Node<Integer>(4)));
	BlackBoxComparator<Integer, Integer> bbc = new BlackBoxComparator<Integer, Integer>();
	bbc.addCriteria( Criteria.Existential, n -> n.isConnectedTo(2)).
	addCriteria( Criteria.Unitary, n -> n.neighbours().isEmpty()).
	addCriteria( Criteria.Universal, n -> n.getValue().equals(4));

	List<ConstrainedGraph<Integer, Integer>> cgs = Arrays.asList(g, g1);
	Collections.sort(cgs, bbc);
	// Usamos el comparador para ordenar una lista de dos grafos
	System.out.println(cgs);
	// imprime g (cumple la 1a propiedad) y luego g1 (cumple la 2o y 3o)
    }
    
    
}
