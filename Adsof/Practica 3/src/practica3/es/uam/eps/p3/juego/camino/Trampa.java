package practica3.es.uam.eps.p3.juego.camino;

import practica3.es.uam.eps.p3.juego.posada.Posada;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */
public class Trampa extends Camino {
    private double coste_extra;
    private double prob_retorno;

    /**
     * Constructor de la clase Trampa
     * 
     * @param p
     *            Posada inicial
     * 
     * @param d
     *            Posada final
     * 
     * @param c_extra
     *            Coste extra de la trampa
     * 
     * @param prob
     *            Probalidad de caer en la trampa
     * 
     * @param coste
     *            Gasto de energia
     * 
     */
    public Trampa(Posada p, Posada d, double c_extra, double prob, int coste) {
	super(p, d, coste);
	this.coste_extra = c_extra;
	this.prob_retorno = prob;
    }

    /**
     * Coste adicional del camino
     * 
     * @return el valor del coste adicional
     */
    @Override
    public int costeEspecial() {
	return (int) (super.getCoste() * this.coste_extra);
    }

    /**
     * Elige un numero al azar, si es menorigual que la probalidad, devuelve la
     * posada de origen si no la de destino
     * 
     * @return devuelve la posada destino de la trampa
     */
    @Override
    public Posada getDestino() {

	double azar = Math.random();

	if (azar <= this.prob_retorno)
	    return super.getOrigen();

	return super.getDestino();
    }

    /**
     * Dice si el camino es una trampa
     * 
     * @return true si es una trampa, false lo contrario
     */
    @Override
    public boolean esTrampa() {
	return true;
    }

}
