package es.uam.ads.p2.tienda;
/**@author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Disco extends Articulo{
	private String interprete;
	private int anio;
	/**
	 * Constructor para Disco.
	 * @param id, numero del articulo.
	 * @param interprete, grupo de musica.
	 * @param titulo, titulo del disco.
	 * @param anio, fecha de la publicacion.
	 */
	public Disco(int id,  String interprete,String titulo, int anio) {
		super(id, titulo);
		this.interprete=interprete;
		this.anio=anio;
	}

	@Override
	public String toString() {
		return "["+super.getId()+"] "+ "DISCO: "+this.interprete+ " - "+ super.getTitulo()+ " (" +this.anio+")";
	}
	

}
