package p4.basedatos.tienda;

import p4.basedatos.implementacion.TypeDescriptorDisco;

import p4.basedatos.interfaces.TypeDescriptor;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Disco extends Articulo {
	private String titulo;
	private Long interprete;
	private double anio;

	/**
	 * Constructor para Disco.
	 *
	 */
	public Disco() {
		super();
	}

	/**
	 *
	 * @return the type
	 */

	@Override
	public String getType() {
		return "Disco";
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
		case "anio":
			return this.anio;
		case "interprete":
			return this.interprete;
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
		case "anio":
			this.anio = (int) value;
			break;
		case "interprete":
			this.interprete = (Long) value;
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
	 * @param interprete
	 *            the interprete to set
	 */
	public void setInterprete(long interprete) {
		this.interprete = interprete;
	}

	/**
	 * @param anio
	 *            the anio to set
	 */
	public void setAnio(double anio) {
		this.anio = anio;
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
		long temp;
		temp = Double.doubleToLongBits(anio);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result
				+ ((interprete == null) ? 0 : interprete.hashCode());
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
		if (!(obj instanceof Disco)) {
			return false;
		}
		Disco other = (Disco) obj;
		if (Double.doubleToLongBits(anio) != Double
				.doubleToLongBits(other.anio)) {
			return false;
		}
		if (interprete == null) {
			if (other.interprete != null) {
				return false;
			}
		} else if (!interprete.equals(other.interprete)) {
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
		return new TypeDescriptorDisco();

	}

}
