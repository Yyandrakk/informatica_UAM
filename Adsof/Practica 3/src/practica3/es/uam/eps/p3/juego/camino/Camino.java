package practica3.es.uam.eps.p3.juego.camino;

import practica3.es.uam.eps.p3.juego.posada.Posada;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */

public class Camino {
    private Posada origen;
    private Posada destino;
    private int coste;
    private static int sumaCoste = 0;

    /**
     * Constructor de la clase Camino
     * 
     * @param origen
     *            Posada inicial
     * 
     * @param destino
     *            Posada final
     * 
     * @param coste
     *            Gasto de energia
     * 
     */
    public Camino(Posada origen, Posada destino, int coste) {
	this.origen = origen;
	this.destino = destino;
	if (coste <= 0) {
	    this.coste = 1;
	} else {
	    this.coste = coste;
	}
	Camino.sumaCoste += this.coste;
    }

    /**
     * 
     * @return Posada de Origen
     */
    public Posada getOrigen() {
	return origen;
    }

    /**
     * 
     * @return Posada de Destino
     */
    public Posada getDestino() {
	return destino;
    }

    /**
     * 
     * @return Coste de vida
     */
    public int getCoste() {
	return coste;
    }

    /**
     * Cambia la posada destino por otra nueva y actualiza el coste de energia
     * 
     * @param p
     *            Nueva posada final
     * 
     * @param energia
     *            Nuevo coste de enerc¡gia
     * 
     * @return true si ha funcionado, false lo contrario
     */
    public boolean cambiarDestino(Posada p, int energia) {
	if (p == null) {
	    return false;
	}
	this.destino = p;
	if (energia <= 0) {
	    this.coste = 1;
	} else {
	    this.coste = energia;
	}
	return true;
    }

    public String toString() {
	return "(" + this.origen.getNombre() + "--" + this.coste + "-->"
		+ this.destino.getNombre();
    }

    /**
     * Coste adicional del camino
     * 
     * @return el valor del coste adicional
     */
    public int costeEspecial() {
	return 0;
    }

    /**
     * El coste que se hace al realizar el camino
     * 
     * @return El valor del coste del camino, sumando el del camino y el
     *         especial
     * 
     */
    public int costeReal() {
	return this.coste + this.costeEspecial();
    }

    /**
     * Dice si el camino es una trampa
     * 
     * @return true si es una trampa, false lo contrario
     */
    public boolean esTrampa() {
	return false;
    }
}
