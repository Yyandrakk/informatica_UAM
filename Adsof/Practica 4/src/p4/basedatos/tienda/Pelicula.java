package p4.basedatos.tienda;

import p4.basedatos.implementacion.TypeDescriptorPelicula;
import p4.basedatos.interfaces.TypeDescriptor;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Pelicula extends Articulo {
	private String titulo;
	private String genero;
	private Long director;

	/**
	 * Constructor para Pelicula.
	 */
	public Pelicula() {
		super();

	}

	/**
	 *
	 * @return the type
	 */

	@Override
	public String getType() {
		return "Pelicula";
	}

	/**
	 * @param property
	 *            Propiedad que se quiere obtener
	 *
	 * @return the property
	 */

	@Override
	public Object getProperty(String property) {
		// return Disco.class.getDeclaredField(property); Interesante para
		// TypeDescriptor
		switch (property) {
		case "titulo":
			return this.titulo;
		case "genero":
			return this.genero;
		case "director":
			return this.director;
		case "id":
			return this.getId();
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
		case "titulo":
			this.titulo = (String) value;
			break;
		case "genero":
			this.genero = (String) value;
			break;
		case "director":
			this.director = (Long) value;
			break;
		case "id":
			this.setId((Long) value);
			break;
		}

	}

	/**
	 * @param titulo
	 *            the titulo to set
	 */
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	/**
	 * @param genero
	 *            the genero to set
	 */
	public void setGenero(String genero) {
		this.genero = genero;
	}

	/**
	 * @param director
	 *            the director to set
	 */
	public void setDirector(Long director) {
		this.director = director;
	}

	/**
	 * Hash code
	 *
	 * @return the hash code
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result
				+ ((director == null) ? 0 : director.hashCode());
		result = prime * result + ((genero == null) ? 0 : genero.hashCode());
		result = prime * result + ((titulo == null) ? 0 : titulo.hashCode());
		return result;
	}

	/**
	 * equals code
	 *
	 * @return true if they are equals else false
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (!super.equals(obj)) {
			return false;
		}
		if (!(obj instanceof Pelicula)) {
			return false;
		}
		Pelicula other = (Pelicula) obj;
		if (director == null) {
			if (other.director != null) {
				return false;
			}
		} else if (!director.equals(other.director)) {
			return false;
		}
		if (genero == null) {
			if (other.genero != null) {
				return false;
			}
		} else if (!genero.equals(other.genero)) {
			return false;
		}
		if (titulo == null) {
			if (other.titulo != null) {
				return false;
			}
		} else if (!titulo.equals(other.titulo)) {
			return false;
		}
		return true;
	}

	/**
	 * @return the TypeDescriptor
	 */

	public static TypeDescriptor getDescriptor() {
		return new TypeDescriptorPelicula();

	}

}
