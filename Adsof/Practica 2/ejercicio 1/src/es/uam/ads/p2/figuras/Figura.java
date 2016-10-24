
package es.uam.ads.p2.figuras;
/**@author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public abstract class Figura {
	/**
	 * Calcula y devuelve el valor del perimetro.
	 * @return valor del perimetro.
	 */
	public abstract double getPerimetro();
	/**
	 * Calcula y devuelve el valor del area.
	 * @return valor del area.
	 */
	public abstract double getArea();
	/**
	 * Compara el area de dos figuras para determinar cual es mayor.
	 * @param Figura con la que se realiza la comparacion.
	 * @return True si la figura es mayor, false si lo contrario.
	 */
	public boolean esMayor(Figura figura){
		return this.getArea()>figura.getArea();
	}
}
