/**
* @author Oscar Garcia de Lara Parreno
* @author Patricia Anza Mateos
* Esta aplicacion calcula la media de varios numeros.
*/
public class Apartado5 {
  /**
  * Punto de entrada a la aplicacion.
  *
  * Este metodo imprime la media de los numeros que se le pasa como entrada.
  *
  * @param args Los argumentos de la linea de comando. Se espera un numero indeterminado de parametros
  */
  public static void main(String[] args) {
    if (args.length<1) {
      System.out.println("El numero de parametros es 0");
      return;
    }
    int i=0,num_arg=args.length;
    double contador=0.0;

    while(i<num_arg)
    {
      contador = contador + Double.parseDouble(args[i]);
      i++;
    }
    if((num_arg%2)==0)
      System.out.println("Hay "+num_arg+" argumentos y es par y la media es: "+contador/num_arg);
    else
      System.out.println("Hay "+num_arg+" argumentos y es impar y la media es: "+contador/num_arg);
  }
}
