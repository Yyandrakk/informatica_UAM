
package es.uam.ads.p2.figuras;
/**@author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Circulo extends Figura {
	private double radio;
	
	/**
	 * Constructor para Circulos. 
	 * @param Valor del radio
	 */
	public Circulo(double radio){
		this.radio=radio;
	}
	@Override
	public String toString() {
		return "Circulo [area=" + this.getArea() + ", perimetro=" + this.getPerimetro() + "]";
	}
	/**
	 * Calcula el perimetro, P=2*PI*r
	 * @return Valor del perimetro
	 */
	public double getPerimetro(){
		return Math.PI*2*this.radio;
	}
	/**
	 * Calcula el area, A=PI*r²
	 * @return Valor del area.
	 */
	public double getArea(){
		return Math.PI*this.radio*this.radio;
	}
	
}
