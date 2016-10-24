package practica3.es.uam.eps.p3.pruebas;

import practica3.es.uam.eps.p3.juego.camino.Camino;
import practica3.es.uam.eps.p3.juego.camino.Trampa;
import practica3.es.uam.eps.p3.juego.posada.Posada;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */
public class EjemploDeUsoCamino {
    public static void main(String[] args) {
	Posada solana = new Posada("Solana", 1);
	Posada romeral = new Posada("Romeral", 5);
	Posada tomelloso = new Posada("Tomelloso");

	System.out.println("AHORA PROBAMOS LA CLASE CAMINO DEBERIA DAR 4 OK");

	Camino cPrincipal = new Camino(solana, romeral, 3);

	if (cPrincipal.costeReal() == 3) {
	    System.out.println("OK: costeReal devolvio el valor establecido");
	} else {
	    System.out
		    .println("ERROR: CosteReal no devolvio el valor establecido");
	}

	if (cPrincipal.cambiarDestino(tomelloso, 5)) {
	    if (cPrincipal.getDestino() == tomelloso) {
		System.out.println("OK: cambiarDestino cambio el destino");
	    } else {
		System.out
			.println("ERROR: cambiarDestino no cambio el destino");
	    }

	} else {
	    System.out
		    .println("ERROR: cambiarDestino se le ha pasado argumentos validos, pero ha devuelto false");
	}
	if (cPrincipal.cambiarDestino(null, -4) == false) {
	    System.out
		    .println("OK:cambiarDestino se le paso null de posada y devolvio,false");
	} else {
	    System.out
		    .println("ERROR:cambiarDestino ha establecido una posada null");
	}
	if (cPrincipal.esTrampa() == false) {
	    System.out.println("OK: esTrampa devolvio false");
	} else {
	    System.out.println("ERROR: esTrampa devolvio true");
	}

	System.out.println("AHORA PROBAMOS LA CLASE TRAMPA DEBERIA DAR 3 OK");
	Trampa tPrueba1 = new Trampa(solana, romeral, 1.5, 1, 3);

	if (tPrueba1.costeReal() == 7) {
	    System.out.println("OK: costeReal devolvio el valor establecido");
	} else {
	    System.out
		    .println("ERROR: costeReal no devolvio el valor establecido");
	}

	if (tPrueba1.esTrampa()) {
	    System.out.println("OK: esTrampa devolvio true");
	} else {
	    System.out.println("ERROR: esTrampa devolvio false");
	}

	if (tPrueba1.getDestino() == solana) {
	    System.out
		    .println("OK: getDestino devolvio el origen ya que la probalidad de 100%");
	} else {
	    System.out
		    .println("ERROR: getDestino no devolvio origen teniendo la probalidad de 100%");
	}

    }
}
