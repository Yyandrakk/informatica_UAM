/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package practica1;

import java.awt.BorderLayout;
import java.util.ArrayList;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JPanel;

/**
 *
 * La clase TablaDerivaciones puede usarse para dibujar el árbol de derivación
 * para una forma sentencial de una gramática. A continuación se muestra un 
 * ejemplo.
 * 
 * <p>
 * La gramática es la siguiente:
 * 
 * <p>
 * S ::= aSb | a
 * 
 * <p>
 * Vamos a considerar la siguiente derivación:
 * 
 * <pre>
 * {@code
 * S -> aSb -> aaSbb -> aaabb
 * }
 * </pre>
 * 
 * Para dibujarla deberíamos hacer lo siguiente:
 * 
 * <p> 
 * 1. Crear una TablaDerivaciones pasándole al constructor el axioma S:
 * 
 * <pre>
 * {@code
 * axioma = [lista con una única cadena, el axioma S];
 * TablaDerivaciones tabla = new TablaDerivaciones(axioma);
 * }
 * </pre>
 * 
 * 2. Aplicar la primera derivación al axioma S, posición 0:
 * 
 * <pre>
 * {@code
 * lista = [lista con los elementos a, S, b];
 * tabla.deriva(0, lista);
 * }
 * </pre>
 * 
 * 3. Aplicar la segunda derivación a S, elemento en la posición 1:
 * 
 * <pre>
 * {@code
 * lista = [lista con los elementos a, S, b];
 * tabla.deriva(1, lista);
 * }
 * </pre>
 * 
 * 4. Aplicar la tercera derivación a S, elemento en la posición 2:
 * 
 * <pre>
 * {@code
 * lista = [lista con el elemento a];
 * tabla.deriva(2, lista);
 * }
 * </pre>
 * 
 * 5. Dibujar la tabla:
 * 
 * <pre>
 * {@code
 * tabla.dibuja();
 * }
 * </pre>
 * 
 * 
 */
public class TablaDerivaciones extends javax.swing.JFrame {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ArrayList <JPanel> listaPaneles;
    
    /**
     * Construye una nueva tabla de derivaciones a partir de la lista de cadenas
     * que recibe como argumento. 
     * <p>
     * La lista de argumentos representa la primera forma sentencial de la 
     * tabla. Todas las derivaciones que se realicen se aplicarán partiendo de
     * esta forma sentencial. Idealmente la lista debería contener una única
     * cadena que represente el axioma de la gramática.
     *
     * @param lista Lista de cadenas que representa la primera forma sentencial
     * de la tabla.
     */
    public TablaDerivaciones(ArrayList <String> lista){
        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        listaPaneles = new ArrayList <JPanel> ();
        JPanel panelPrincipal = new JPanel();
        panelPrincipal.setLayout(new BoxLayout(panelPrincipal,BoxLayout.LINE_AXIS));
        
        for (String s : lista) {
            JPanel panel = new JPanel();
            panel.setLayout(new BorderLayout());
            panel.add(new JButton(s),BorderLayout.NORTH);
            JPanel nuevoPanel = new JPanel();
            panel.add(nuevoPanel,BorderLayout.CENTER);
            listaPaneles.add(nuevoPanel);
            panelPrincipal.add(panel);
        }

        this.add(panelPrincipal);
    }

    /**
     * Dibuja la tabla de derivaciones.
     * <p>
     * Debe invocarse después de hacer todas las derivaciones.
     */
    public void dibuja() {
        this.pack();
        this.setVisible(true);
    }
    
    /**
     * Realiza una derivación en la tabla.
     * <p>
     * Este método se invoca para realizar derivaciones sobre la última forma
     * sentencial generada. La primera forma sentencial se establece con el 
     * constructor de la clase. Cuando se aplica una derivación se sustituye
     * el elemento en la posición pos (primer argumento) de la forma sentencial 
     * actual por la lista que se pasa como segundo argumento.
     * 
     * @param pos Posición del elemento a derivar en la forma sentencial actual
     * @param lista Lista de cadenas que representa la parte derecha de la regla 
     * a aplicar, y que sustituirá al elemento a derivar
     */
    public void deriva(int pos, ArrayList <String> lista) {

        JPanel panelPrincipal = listaPaneles.get(pos);
        panelPrincipal.setLayout(new BoxLayout(panelPrincipal,BoxLayout.LINE_AXIS));
        
        listaPaneles.remove(pos);
        
        if (lista.isEmpty()) {
            JPanel panel = new JPanel();
            panel.setLayout(new BorderLayout());
            panel.add(new JButton("\u03bb"), BorderLayout.NORTH);
            JPanel nuevoPanel = new JPanel();
            panel.add(nuevoPanel, BorderLayout.CENTER);
            panelPrincipal.add(panel);
        } else {
            for (String s : lista) {
                JPanel panel = new JPanel();
                panel.setLayout(new BorderLayout());
                panel.add(new JButton(s), BorderLayout.NORTH);
                JPanel nuevoPanel = new JPanel();
                panel.add(nuevoPanel, BorderLayout.CENTER);
                listaPaneles.add(pos, nuevoPanel);
                panelPrincipal.add(panel);
                pos++;
            }
        }
    }    
}
