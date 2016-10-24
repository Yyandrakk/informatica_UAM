package p4.basedatos.tienda;

import p4.basedatos.interfaces.Entity;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public abstract class Articulo implements Entity {

	private Long id;
	private static long nArticulo = 0;

	/**
	 * Constructor para Articulo.
	 * 
	 */
	public Articulo() {
		this.id = Articulo.nArticulo++;
	}

	/**
	 *
	 * @return the id
	 */
	@Override
	public Long getId() {

		return this.id;
	}

	/**
	 * @param id
	 *            id to set
	 *
	 * @return the property
	 */
	@Override
	public void setId(Long id) {

		this.id = id;
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
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		if (!(obj instanceof Articulo)) {
			return false;
		}
		Articulo other = (Articulo) obj;
		if (id == null) {
			if (other.id != null) {
				return false;
			}
		} else if (!id.equals(other.id)) {
			return false;
		}
		return true;
	}

}
