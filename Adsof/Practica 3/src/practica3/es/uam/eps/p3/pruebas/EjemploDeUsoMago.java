package practica3.es.uam.eps.p3.pruebas;

import practica3.es.uam.eps.p3.juego.camino.Camino;
import practica3.es.uam.eps.p3.juego.camino.Trampa;
import practica3.es.uam.eps.p3.juego.explorador.Mago;
import practica3.es.uam.eps.p3.juego.explorador.Mago.TMagos;
import practica3.es.uam.eps.p3.juego.posada.Posada;
import practica3.es.uam.eps.p3.juego.posada.Posada.Iluminacion;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */
public class EjemploDeUsoMago {
    public static void main(String[] args) {
	Posada solana = new Posada("Solana", 1);
	Posada romeral = new Posada("Romeral", 5, Iluminacion.BLANCA);
	Camino c1 = new Camino(solana, romeral, 3);
	Trampa t = new Trampa(romeral, solana, 1.5, 0.75, 8);
	Mago mago1 = new Mago("Patricia", 20, solana, 4, TMagos.HADA);
	Mago mago2 = new Mago("Oscar", 3, romeral, 2, TMagos.HECHICERO);

	if (mago1.recorre(c1) == true) {
	    System.out.println("OK: recorre se realizo correctamente");
	} else {
	    System.out.println("ERROR: recorre no se realizo correctamente");
	}
	if (mago2.recorre(t) == false) {
	    System.out
		    .println("OK: recorre con trampa se realizo correctamente");
	} else {
	    System.out
		    .println("ERROR: recorre con trampa no se realizo correctamente");
	}
	if (mago1.puedeAlojarseEn(solana) == true) {
	    System.out.println("OK: puedeAlojarse se realizo correctamente");
	} else {
	    System.out
		    .println("ERROR: puedeAlojarse no se realizo correctamente");
	}
    }
}
