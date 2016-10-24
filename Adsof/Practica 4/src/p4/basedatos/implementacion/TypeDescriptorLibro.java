package p4.basedatos.implementacion;

import java.util.ArrayList;
import java.util.List;

import p4.basedatos.interfaces.Entity;
import p4.basedatos.interfaces.TypeDescriptor;
import p4.basedatos.tienda.Libro;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class TypeDescriptorLibro implements TypeDescriptor {

	private final String name = "Libro";
	private List<String> propiedades;

	/**
	 * Constructor para TypeDescriptorLibro.
	 */
	public TypeDescriptorLibro() {
		this.propiedades = new ArrayList<String>();
		this.propiedades.add("id");
		this.propiedades.add("titulo");
		this.propiedades.add("autor");
		this.propiedades.add("editorial");
	}

	/**
	 *
	 * @return the name
	 */
	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return this.name;
	}

	/**
	 *
	 * @return the list of properties
	 */
	@Override
	public List<String> getProperties() {
		// TODO Auto-generated method stub
		return this.propiedades;
	}

	/**
	 *
	 * @return the type
	 */
	@Override
	public Type getType(String property) {
		switch (property) {
		case "id":
			return Type.Long;
		case "titulo":
			return Type.String;
		case "autor":
			return Type.Long;
		case "editorial":
			return Type.String;
		default:
			return null;
		}
	}

	/**
	 *
	 * @return entidad libro
	 */
	@Override
	public Entity newEntity() {

		return new Libro();
	}

}
