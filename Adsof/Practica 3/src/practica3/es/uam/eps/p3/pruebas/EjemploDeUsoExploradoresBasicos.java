package practica3.es.uam.eps.p3.pruebas;

import practica3.es.uam.eps.p3.juego.camino.Camino;
import practica3.es.uam.eps.p3.juego.explorador.Explorador;
import practica3.es.uam.eps.p3.juego.posada.Posada;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */
public class EjemploDeUsoExploradoresBasicos {
    public static void main(String[] args) {
	Posada solana = new Posada("Solana", 1);
	Posada romeral = new Posada("Romeral", 5);
	Posada tomelloso = new Posada("Tomelloso"); // por defecto energía
						    // recuperada 2

	Explorador sancho = new Explorador("Sancho", 50, solana);
	solana.addCamino(new Camino(solana, romeral, 68));
	solana.addCamino(new Camino(solana, tomelloso, 33));
	System.out.println(sancho);
	sancho.recorre(romeral, tomelloso); // irá directo a tomelloso sin pasar
					    // por romeral

	System.out.println(sancho); // energía 19 = 50 - 33 + 2
	tomelloso.addCamino(new Camino(tomelloso, romeral, 11));
	sancho.recorre(tomelloso.getCamino(romeral));
	System.out.println(sancho); // en Romeral con energía 13 = 19 - 11 + 5
    }
}
