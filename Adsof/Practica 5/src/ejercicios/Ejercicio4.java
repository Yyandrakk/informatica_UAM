package ejercicios;

import java.util.ArrayList;
import java.util.Arrays;

import implementaciones.estrategias.AsLongAsPossible;
import implementaciones.grafo.ConstrainedGraph;
import implementaciones.grafo.Node;
import implementaciones.regla.Rule;
import implementaciones.regla.RuleSetWithStrategy;

public class Ejercicio4 {
    public static void main(String[] args) {
    final int INIT_CONSTANT = 1000;
    ConstrainedGraph<Integer, Integer> g = new ConstrainedGraph<Integer, Integer>();
    Node<Integer> n0 = new Node<Integer>(0);
    // El valor del nodo es la longitud del camino. n0 es nodo inicial
    Node<Integer> n1 = new Node<Integer>(INIT_CONSTANT);
    // inicializamos el resto a un valor alto, que iremos reduciendo
    Node<Integer> n2 = new Node<Integer>(INIT_CONSTANT);
    Node<Integer> n3 = new Node<Integer>(INIT_CONSTANT);
    g.addAll(Arrays.asList(n0, n1, n2, n3));
    g.connect(n0,1, n1);
    g.connect(n0,7, n2);
    g.connect(n1, 2, n2);
    g.connect(n1, 10, n3);
    g.connect(n2,3, n3);
    System.out.println("Grafo inicial: \n"+g);
    // Estrategia de ejecución “as long as possible”
    RuleSetWithStrategy<Node<Integer>> rs = new RuleSetWithStrategy<Node<Integer>>(new AsLongAsPossible<>());
    rs.add( Rule.<Node<Integer>>rule("r1", "disminuye el valor del nodo") // Esta regla implementa Dijkstra!
    .when(z -> g.exists( x -> x.isConnectedTo(z) &&
    x.getValue() + (Integer)x.getEdgeValues(z).get(0) < z.getValue() ) )
    .exec(z -> z.setValue(g.getWitness().get().getValue()+
    (Integer) g.getWitness().get().getEdgeValues(z).get(0))));
    rs.setExecContext( g );
    rs.process();
    System.out.println("Nodos del grafo final: \n"+new ArrayList<>(g));
    System.out.println("(Algunos) tests de corrección: ");
    System.out.println("No hay nodos inalcanzables: "+g.forAll( n -> n.getValue() < INIT_CONSTANT));
    System.out.println("Hay un sólo nodo inicial: "+g.one( n -> n.getValue().equals(0)));
}
}
