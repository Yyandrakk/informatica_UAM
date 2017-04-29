package ejercicios;

import implementaciones.grafo.Graph;
import implementaciones.grafo.Node;

import java.util.ArrayList;
import java.util.List;



public class Ejercicio1 {
    public static void main(String... args) {
	Graph<String, Integer> g = new Graph<String, Integer>();
	Node<String> s0 = new Node<String>("s0");
	Node<String> s1 = new Node<String>("s1");
	//g.addAll(Arrays.asList(s0, s1, s0)); // no admite repetidos,
					     // considerando igualdad
					     // referencial
	g.connect(s0, 0, s0); // conectamos s0 consigo mismo a través de enlace
			      // con valor 0
	g.connect(s0, 1, s1);
	g.connect(s0, 0, s1);
	g.connect(s1, 0, s0);
	g.connect(s1, 1, s0);
	System.out.println(g); // El grafo contiene 2 nodos y 5 enlaces
	for (Node<String> n : g){
	    // Colección de dos nodos (s0 y s1)
	    System.out.println("Nodo " + n);}
	List<Node<String>> nodos = new ArrayList<Node<String>>(g);
	System.out.println(nodos);
	System.out.println("s0 conectado con 's1': " + s0.isConnectedTo("s1"));
	System.out.println("s0 conectado con s1: " + s0.isConnectedTo(s1));
	System.out.println("vecinos de s0: " + s0.neighbours());
	System.out.println("valores de los enlaces desde s0 a s1: "
		+ s0.getEdgeValues(s1));
    }
}
