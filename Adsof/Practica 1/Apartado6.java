/**
* @author Oscar Garcia de Lara Parreno
* @author Patricia Anza Mateos
* Esta aplicacion calcula la mediana de una array.
*/
public class Apartado6 {


  /**
  * Punto de entrada a la aplicacion.
  *
  * Este metodo imprime la mediana de los numeros que se le pasa como entrada
  *
  * @param args Los argumentos de la linea de comando. Se espera un numero maximo de 20 parametros
  */
  public static void main(String[] args) {
    if (args.length>20||args.length<1) {
      System.out.println("El numero de parametros debe ser menor de 21 y mayor de 0");
      return;
    }
    int i=0,num_arg=args.length;
    double[] numeros = new double[num_arg];
    for (String s : args )
    {
      numeros[i] = Double.valueOf(s);
      i++;
    }
    SelectSort(numeros,0,num_arg-1);

    for (Double d : numeros )
      System.out.println(d);

    if((num_arg%2)==0)
      System.out.println("La mediana de la tabla es: " + (numeros[num_arg/2]+numeros[(num_arg/2)-1])/2);
    else
      System.out.println("La mediana de la tabla es: " + numeros[num_arg/2]);
  }
  /**
  *
  * Este metodo ordena una tabla double mediante SelectSort
  *
  * @param tabla array de numeros double
  * @param ip indice del primer numero de la array
  * @param iu indice del ultimo numero de la array
  */

    public static void SelectSort(double[] tabla, int ip, int iu)
  {
    int min=0,principio=0;
    double swap;

    for(principio=ip;principio<iu;principio++)
    {
      int j=0;
      min=principio;

      for (j=principio+1;j<=iu;j++)
      {
        if(tabla[j]<tabla[min])
        min=j;
      }

      swap=tabla[principio];
      tabla[principio]=tabla[min];
      tabla[min]=swap;
    }
  }
}
