package practica3.es.uam.eps.p3.pruebas;

import java.io.IOException;

import practica3.es.uam.eps.p3.simulacion.Simulacion;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */
public class EjemploDeUsoSimulacion {

    public static void main(String[] args) {
	// TODO Auto-generated method stub
	try {
	    Simulacion s;
	    s = new Simulacion("POSADAS.txt", "CAMINOS.txt", "EXPLORADOR.txt");
	    s = new Simulacion("POSADAS.txt", "CAMINOS.txt", "EXPLORADOR2.txt");
	} catch (IOException e) {
	    System.out.println("Error en archivos");
	}

    }

}
