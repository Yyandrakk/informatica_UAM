package practica3.es.uam.eps.p3.juego.explorador;

import practica3.es.uam.eps.p3.juego.camino.Camino;
import practica3.es.uam.eps.p3.juego.posada.Posada;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */
public class Explorador {
    private String nombre;
    private Posada lugar;
    private int vida;

    /**
     * Constructor de la clase Explorador
     * 
     * @param nombre
     *            Nombre del explorador
     * 
     * @param vida
     *            Vida del explorador
     * 
     * @param lugar
     *            Posada donde se encuentra el explorador
     * 
     */
    public Explorador(String nombre, int vida, Posada lugar) {
	this.nombre = nombre;
	this.vida = vida;
	this.lugar = lugar;
    }

    public Posada getLugar() {
	return lugar;
    }

    public void setLugar(Posada lugar) {
	this.lugar = lugar;
    }

    public int getVida() {
	return vida;
    }

    public void setVida(int vida) {
	this.vida = vida;
    }

    public String getNombre() {
	return nombre;
    }

    /**
     * Comprueba que se pueda recorrer el camino, y si es asi, lo recorre
     * 
     * @param camino
     *            Camino que se quiere recorrer
     * @return true en caso que lo haya recorrido, false en caso de error o que
     *         no pueda recorrerlo
     */
    public boolean recorre(Camino camino) {
	if (camino == null || camino.getOrigen() != this.lugar) {
	    return false;
	}
	Posada dest = camino.getDestino();
	if (puedeRecorrerCamino(camino) && puedeAlojarseEn(dest)) {
	    this.lugar = dest;
	    this.vida = this.vida - camino.costeReal() + dest.getRecuperacion();
	    return true;
	}

	return false;
    }

    /**
     * Se le pasa una lista de posadas y va recorriendolas
     * 
     * @param posada
     *            Lista de posadas que se quiere recorrer
     * @return true si recorre todas, false si no puede recorrer dos seguidas
     */
    public boolean recorre(Posada... posada) {
	boolean status = true;
	for (int i = 0; i < posada.length; i++) {
	    if (recorre(this.lugar.getCamino(posada[i])) != true) {
		status = false;
	    }
	}
	return status;

    }

    /**
     * Comprueba que tenga suficiente vida para recorrerlo
     * 
     * @param camino
     *            camino a comprobar
     * @return true si puede, false si no
     */
    public boolean puedeRecorrerCamino(Camino camino) {
	if (this.vida > camino.costeReal()) {
	    return true;
	}
	return false;

    }

    /**
     * Comprueba que se pueda alojar en esta posada
     * 
     * @param p
     *            Posada en cual se aloja
     * @return true si puede, false si no
     */
    public boolean puedeAlojarseEn(Posada p) {
	return true;
    }

    public String toString() {
	return this.nombre + "(e:" + this.vida + ")" + "en "
		+ this.lugar.getNombre() + "";
    }

}
