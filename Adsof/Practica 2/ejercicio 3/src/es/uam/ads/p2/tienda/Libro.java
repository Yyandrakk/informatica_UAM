package es.uam.ads.p2.tienda;

/**@author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Libro extends Articulo {
	private String autor;
	private String editorial;
	/**
	 * Constructor para Libro.
	 * @param id, numero del articulo.
	 * @param titulo, titulo del libro.
	 * @param autor, autor del libro.
	 * @param editorial, editorial del libro.
	 */
	public Libro(int id, String titulo, String autor, String editorial) {
		super(id, titulo);
		this.autor=autor;
		this.editorial=editorial;
	}
	@Override
	public String toString() {
		return "["+super.getId()+"] "+ "LIBRO: "+ super.getTitulo()+ ". " +this.autor+". "+this.editorial;
	}


}
