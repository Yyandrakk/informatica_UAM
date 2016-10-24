package es.uam.ads.p2.tienda; 
/**@author Oscar Garcia de Lara
 * @author Patricia Anza
 * 
 * Esta aplicacion comprueba que las clases Articulo, Disco, Pelicula y Libro funcionen correctamente.
 */
public class TesterTienda01 { 
 /**
  * Punto de entrada de la aplicacion
  * @param args Los argumentos de la linea de comandos. No se usan.
  */
 public static void main(String[] args) { 
	 Libro l = new Libro(1, "La historia interminable", "Ende, Michael", "Ed. Alfaguara"); 
	 Disco d = new Disco(12, "Evanescence", "Fallen", 2003); 
	 Pelicula p = new Pelicula(34, "Cadena Perpetua", "Drama", "Frank Darabont"); 
	 
	 System.out.println(l); 
	 System.out.println(d); 
	 System.out.println(p); 
 } 
} 
