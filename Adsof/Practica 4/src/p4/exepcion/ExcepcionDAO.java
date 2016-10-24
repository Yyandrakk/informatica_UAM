package p4.exepcion;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 * 
 *         excepcion para los componentes del DAO
 */
public class ExcepcionDAO extends Exception {

	private static final long serialVersionUID = 9168992012389290343L;
	private String clase, tipo, metodo;

	public ExcepcionDAO(String clase, String metodo, String tipo) {
		this.clase = clase;
		this.tipo = tipo;
		this.metodo = metodo;
	}

	@Override
	public String toString() {
		return "El error se ha producido en la clase " + this.clase
				+ "en el metodo " + this.metodo + ", el error es " + this.tipo;
	}

}
