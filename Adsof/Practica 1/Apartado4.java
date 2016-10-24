/**
* @author Oscar Garcia de Lara Parreno
* @author Patricia Anza Mateos
* Esta aplicacion calcula la media de dos numeros.
*/
public class Apartado4 {
  /**
  * Punto de entrada a la aplicacion.
  *
  * Este metodo imprime la media de los numeros que se le pasa como entrada
  *
  * @param args Los argumentos de la linea de comando. Se espera dos numeros como parametro
  */
  public static void main(String[] args) {

    if (args.length!=2) {
      System.out.println("Se espera dos numeros como parametros.");
      return;
    }

    System.out.println("La media de " + args[0] + " y "+ args[1] + " es: " + (Double.parseDouble(args[0])+Double.parseDouble(args[1]))/2);
  }
}
