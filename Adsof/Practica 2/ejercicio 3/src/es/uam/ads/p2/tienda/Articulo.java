package es.uam.ads.p2.tienda;
/**@author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public abstract class Articulo {

	private int id;
	private String titulo;
	/**
	 * Constructor para Articulo. 
	 * @param id, numero para el id.
	 * @param titulo, nombre para aignar al titulo.
	 */
	public Articulo(int id, String titulo){
		this.id=id;
		this.titulo=titulo;
	}
	/**
	 * Para obtener el titulo.
	 * @return devuelve el titulo.
	 */
	public String getTitulo() {
		return titulo;
	}
	/**
	 * Para obtener la id.
	 * @return devuelve el id.
	 */
	public int getId() {
		return id;
	}
	@Override
	public String toString() {
		return "Articulo [id=" + id + ", titulo=" + titulo + "]";
	}
	
}
