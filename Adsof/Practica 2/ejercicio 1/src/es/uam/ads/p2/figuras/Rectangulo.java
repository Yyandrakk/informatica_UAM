
package es.uam.ads.p2.figuras;
/**@author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Rectangulo extends Figura{
	private double altura;
	private double base;
	/**
	 * Constructor para Rectangulos.
	 * @param base: Dimension de la base del rectangulo a crear.
	 * @param altura: Dimension de la altura del rectangulo a crear.
	 */
	public Rectangulo(double base, double altura){
		this.base=base;
		this.altura=altura;
	}
	/**
	 * Calcula el perimetro, P=2*b+2*h
	 * @return Valor del perimetro
	 */
	public double getPerimetro(){
		return 2*this.base+2*this.altura;
	}
	/**
	 * Calcula el area, A=b*h
	 * @return Valor del area.
	 */
	public double getArea(){
		return this.base*this.altura;
	}
	/**
	 * Comprueba que si la base y la altura son iguales, tenemos un cuadrado, un caso especial de rectangulo.
	 * @return True si es un cuadrado, false lo contrario.
	 */
	public boolean isCuadrado(){
		return (this.base==this.altura);
	}
	@Override
	public String toString() {
		return "Rectangulo [area=" + this.getArea() + ", perimetro=" + this.getPerimetro() + "]";
	}
}
