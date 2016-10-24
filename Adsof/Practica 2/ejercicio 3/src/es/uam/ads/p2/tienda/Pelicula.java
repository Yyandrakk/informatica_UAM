package es.uam.ads.p2.tienda;
/**@author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Pelicula extends Articulo{
	private String genero;
	private String director;
	/**
	 * Constructor para Pelicula.
	 * @param id, numero del articulo.
	 * @param titulo,titulo de la pelicula.
	 * @param genero, genero de la pelicula.
	 * @param director, director de la pelicula.
	 */
	public Pelicula(int id, String titulo, String genero, String director) {
		super(id, titulo);
		this.genero=genero;
		this.director=director;
	}
	@Override
	public String toString() {
		return "["+super.getId()+"] "+ "PELICULA: "+super.getTitulo()+ " (" +this.genero+"). Dir: "+this.director;
	}
}
