package practica3.es.uam.eps.p3.juego.explorador;

import practica3.es.uam.eps.p3.juego.camino.Camino;

import practica3.es.uam.eps.p3.juego.posada.Posada;
import practica3.es.uam.eps.p3.juego.posada.Posada.Iluminacion;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */
public class Mago extends Explorador {
    private int poder;
    private TMagos tipo;

    /**
     * Constructor de la clase Mago
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
     * @param poder
     *            numero de poder que tiene
     * 
     * @param tipo
     *            Tipo de mago
     */
    public Mago(String nombre, int vida, Posada lugar, int poder, TMagos tipo) {
	super(nombre, vida, lugar);
	this.poder = poder;
	this.tipo = tipo;
    }

    /**
     * Comprueba que se pueda recorrer el camino, y si es asi, lo recorre
     * 
     * @param camino
     *            Camino que se quiere recorrer
     * @return true en caso que lo haya recorrido, false en caso de error o que
     *         no pueda recorrerlo
     */
    @Override
    public boolean recorre(Camino camino) {
	if (camino == null || camino.getOrigen() != super.getLugar()
		|| camino.esTrampa()) {
	    return false;
	}
	Posada dest = camino.getDestino();
	if (puedeRecorrerCamino(camino) && puedeAlojarseEn(dest)) {
	    super.setLugar(dest);
	    super.setVida(super.getVida() - camino.costeReal()
		    + dest.getRecuperacion());
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
    @Override
    public boolean puedeAlojarseEn(Posada p) {
	if (TMagos.HADA == this.tipo) {
	    if (p.getLuz() == Iluminacion.GRIS
		    || p.getLuz() == Iluminacion.CLARA
		    || p.getLuz() == Iluminacion.BLANCA
		    || p.getLuz() == Iluminacion.DIVINA) {
		return true;
	    } else {
		return false;
	    }
	} else {
	    if (p.getLuz() == Iluminacion.DIABOLICA
		    || p.getLuz() == Iluminacion.NEGRA
		    || p.getLuz() == Iluminacion.TENEBROSA
		    || (this.poder == 1 && p.getLuz() == Iluminacion.GRIS)
		    || (this.poder == 2 && (p.getLuz() == Iluminacion.GRIS || p
			    .getLuz() == Iluminacion.CLARA))
		    || (this.poder == 3 && (p.getLuz() == Iluminacion.GRIS
			    || p.getLuz() == Iluminacion.CLARA || p.getLuz() == Iluminacion.BLANCA))
		    || (this.poder >= 4 && (p.getLuz() == Iluminacion.GRIS
			    || p.getLuz() == Iluminacion.CLARA
			    || p.getLuz() == Iluminacion.BLANCA || p.getLuz() == Iluminacion.DIVINA))) {
		return true;
	    } else {
		return false;
	    }
	}
    }

    /**
     * Enumeracion de los tipos de Mago
     *
     */
    public enum TMagos {
	HADA, HECHICERO
    }
}
