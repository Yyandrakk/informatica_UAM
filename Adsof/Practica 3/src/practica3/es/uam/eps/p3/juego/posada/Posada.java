package practica3.es.uam.eps.p3.juego.posada;

import java.util.*;

import practica3.es.uam.eps.p3.juego.camino.Camino;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */
public class Posada {

    private String nombre;
    private int recuperacion;
    private List<Camino> caminos;
    private Iluminacion luz;

    /**
     * Constructor de la clase Pasada La energia sera 2 y la iluminacion Blanca
     * 
     * @param nombre
     *            Nombre de la posada
     */
    public Posada(String nombre) {
	this(nombre, 2);
    }

    /**
     * Constructor de la clase Pasada
     * 
     * @param nombre
     *            Nombre de la posada
     * @param energia
     *            Energia que recupera
     * @param luz
     *            Iluminacion de la posada
     */
    public Posada(String nombre, int energia, Iluminacion luz) {
	this.nombre = nombre;
	this.recuperacion = energia;
	this.caminos = new ArrayList<Camino>();
	this.luz = luz;
    }

    /**
     * Constructor de la clase Pasada La iluminacion sera Blanca
     * 
     * @param nombre
     *            Nombre de la posada
     * @param energia
     *            Energia que recupera
     */
    public Posada(String nombre, int energia) {
	this(nombre, energia, Iluminacion.BLANCA);
    }

    /**
     * 
     * @return Nombre de la posada
     */
    public String getNombre() {
	return nombre;
    }

    /**
     * 
     * @return Vida que recupera
     */
    public int getRecuperacion() {
	return recuperacion;
    }

    /**
     * 
     * @param index
     *            indice del camino a devolver
     * @return Camino
     */
    public Camino getCamino(int index) {
	return this.caminos.get(index);
    }

    /**
     * 
     * @return Numero de caminos
     */
    public int getNumCaminos() {
	return this.caminos.size();
    }

    /**
     * 
     * @return Iluminacion
     */
    public Iluminacion getLuz() {
	return this.luz;
    }

    /**
     * Es como un setter de luz
     * 
     * @param luz
     *            que se quiere poner
     */
    public void cambiarLuz(Iluminacion luz) {
	this.luz = luz;
    }

    /**
     * Devuelve un camino entre la posada de origen y la de destino
     * 
     * @param posada
     *            Posada de destino
     * @return camino si existe, null en caso contrario
     */
    public Camino getCamino(Posada posada) {
	for (Camino c : this.caminos) {
	    if (c.getDestino() == posada) {
		return c;
	    }
	}
	return null;
    }

    /**
     * Añade un camino a la lista de caminos
     * 
     * @param camino
     *            Camino a añadir
     * @return true si puede, false si da error
     */
    public boolean addCamino(Camino camino) {
	if (camino == null || camino.getOrigen() != this
		|| this.caminos.contains(camino)) {
	    return false;
	}
	this.caminos.add(camino);
	return true;
    }

    public String toString() {
	return this.nombre + "(" + this.recuperacion + ")" + "[" + this.caminos
		+ "]";
    }

    /**
     * Enumeracion de los tipos de Iluminacion de cada Posada
     * 
     *
     */
    public enum Iluminacion {
	DIABOLICA, NEGRA, TENEBROSA, GRIS, CLARA, BLANCA, DIVINA
    }
}
