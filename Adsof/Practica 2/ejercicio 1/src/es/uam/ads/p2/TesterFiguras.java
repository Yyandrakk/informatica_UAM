
package es.uam.ads.p2; 
 
import java.util.ArrayList; 
import java.util.List; 
 
import es.uam.ads.p2.figuras.Circulo; 
import es.uam.ads.p2.figuras.Figura; 
import es.uam.ads.p2.figuras.Rectangulo; 
/**@author Oscar Garcia de Lara
 * @author Patricia Anza
 * 
 * Esta aplicacion comprueba que las clases Figura, Rectangulo y Circulo funcionen correctamente.
 */
public class TesterFiguras { 
 /**
  * Punto de entrada de la aplicacion
  * @param args Los argumentos de la linea de comandos. No se usan.
  */
 public static void main(String[] args) { 
 List<Figura> figuras = new ArrayList<Figura>(); 
 Rectangulo rectangulo = new Rectangulo(1.25, 9.67); 
 Rectangulo rectangulo2 = new Rectangulo(1.25, 1.25); 
 
 figuras.add(new Circulo(5.5)); 
 figuras.add(new Rectangulo(3, 2.5)); 
 figuras.add(new Rectangulo(10, 15.3)); 
 figuras.add(new Circulo(2.2)); 
 
 for(Figura fig : figuras) { 
 System.out.println(rectangulo + 
 ((fig.esMayor(rectangulo)) ? " <= " : " > ") + fig); 
 } 
 
 System.out.println("\n" + rectangulo + " cuadrado? " + rectangulo.isCuadrado()); 
 System.out.println(rectangulo2 + " cuadrado? " + rectangulo2.isCuadrado()); 
 } 
}