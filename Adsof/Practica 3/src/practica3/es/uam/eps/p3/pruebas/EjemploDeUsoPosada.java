package practica3.es.uam.eps.p3.pruebas;

import practica3.es.uam.eps.p3.juego.camino.Camino;
import practica3.es.uam.eps.p3.juego.posada.Posada;
import practica3.es.uam.eps.p3.juego.posada.Posada.Iluminacion;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */
public class EjemploDeUsoPosada {
    public static void main(String[] args) {
	Posada solana = new Posada("Solana", 1);
	Posada romeral = new Posada("Romeral", 5, Iluminacion.NEGRA);
	Posada tomelloso = new Posada("Tomelloso");
	Camino c1 = new Camino(solana, romeral, 3);
	Camino c2 = new Camino(solana, tomelloso, 5);
	Camino c3;

	solana.addCamino(c2);
	romeral.cambiarLuz(Iluminacion.BLANCA);
	if (romeral.getLuz() == Iluminacion.BLANCA) {
	    System.out.println("OK: cambiarLuz se realizo correctamente");
	} else {
	    System.out.println("ERROR: cambiarLuz no se realizo correctamente");
	}
	if (solana.addCamino(c1) == true) {
	    System.out.println("OK: addCamino annadio un camino correctamente");
	} else {
	    System.out
		    .println("ERROR: addCamino no annadio un camino correctamente");
	}
	c3 = solana.getCamino(tomelloso);
	if (c3 == c2) {
	    System.out.println("OK: getCamino funciona correctamente");
	} else {
	    System.out.println("ERROR: getCamino no funciona correctamente");
	}

	System.out.println(solana);
    }
}
