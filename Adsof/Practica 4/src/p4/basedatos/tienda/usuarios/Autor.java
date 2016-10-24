package p4.basedatos.tienda.usuarios;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */

public class Autor extends Usuario {
	/**
	 * Constructor de la clase autor
	 * 
	 */
	public Autor() {
		super();
	}

	@Override
	public String getType() {

		return "Autor";
	}

}
