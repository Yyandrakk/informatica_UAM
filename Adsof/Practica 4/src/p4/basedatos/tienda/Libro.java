package p4.basedatos.tienda;

import p4.basedatos.implementacion.TypeDescriptorLibro;
import p4.basedatos.interfaces.TypeDescriptor;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Libro extends Articulo {

	private String titulo;
	private Long autor;
	private String editorial;

	/**
	 * Constructor para Libro.
	 * 
	 */
	public Libro() {
		super();

	}

	/**
	 *
	 * @return the type
	 */
	@Override
	public String getType() {
		return "Libro";
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
		case "editorial":
			return this.editorial;
		case "autor":
			return this.autor;
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
		case "editorial":
			this.editorial = (String) value;
			break;
		case "autor":
			this.autor = (Long) value;
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
	 * @param autor
	 *            the autor to set
	 */
	public void setAutor(Long autor) {
		this.autor = autor;
	}

	/**
	 * @param editorial
	 *            the editorial to set
	 */
	public void setEditorial(String editorial) {
		this.editorial = editorial;
	}

	/**
	 * @return the TypeDescriptor
	 */
	public static TypeDescriptor getDescriptor() {
		return new TypeDescriptorLibro();

	}

	/**
	 * Hash code
	 *
	 * @return the hash code
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((autor == null) ? 0 : autor.hashCode());
		result = prime * result
				+ ((editorial == null) ? 0 : editorial.hashCode());
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
		if (obj == null) {
			return false;
		}
		if (!(obj instanceof Libro)) {
			return false;
		}
		Libro other = (Libro) obj;
		if (autor == null) {
			if (other.autor != null) {
				return false;
			}
		} else if (!autor.equals(other.autor)) {
			return false;
		}
		if (editorial == null) {
			if (other.editorial != null) {
				return false;
			}
		} else if (!editorial.equals(other.editorial)) {
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

}
