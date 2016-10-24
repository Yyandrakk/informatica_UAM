package p4.basedatos.tienda.usuarios;

import p4.basedatos.interfaces.Entity;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */

public class Usuario implements Entity {

	private String nombre;
	private String apellidos;
	private Long id;

	public Usuario() {

	}

	/**
	 * @return the nombre
	 */
	public String getNombre() {
		return nombre;
	}

	/**
	 * @return the apellidos
	 */
	public String getApellidos() {
		return apellidos;
	}

	/**
	 * @return the id
	 */
	@Override
	public Long getId() {
		return this.id;
	}

	/**
	 * @param id
	 *            Id que se quiere fijar
	 *
	 */
	@Override
	public void setId(Long id) {
		this.id = id;

	}

	/**
	 * @return the type
	 */
	@Override
	public String getType() {

		return "Usuario";
	}

	/**
	 * @param property
	 *            Propiedad que se quiere obtener
	 *
	 * @return the property
	 */
	@Override
	public Object getProperty(String property) {
		switch (property) {
		case "apellidos":
			return this.apellidos;
		case "nombre":
			return this.nombre;
		case "id":
			return this.id;
		default:
			return null;
		}

	}

	/**
	 * @param property
	 *            Propiedad que se quiere fijar
	 *
	 * @param value
	 *            Valor que se quiere fijar
	 *
	 */

	@Override
	public void setProperty(String property, Object value) {
		switch (property) {
		case "apellidos":
			this.apellidos = (String) value;
			break;
		case "nombre":
			this.nombre = (String) value;
			break;
		case "id":
			this.id = (Long) value;
			break;
		}
	}
}
