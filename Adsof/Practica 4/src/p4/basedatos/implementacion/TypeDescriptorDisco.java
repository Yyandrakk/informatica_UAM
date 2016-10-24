package p4.basedatos.implementacion;

import java.util.ArrayList;
import java.util.List;

import p4.basedatos.interfaces.Entity;
import p4.basedatos.interfaces.TypeDescriptor;
import p4.basedatos.tienda.Disco;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class TypeDescriptorDisco implements TypeDescriptor {
	private final String name = "Disco";
	private List<String> propiedades;

	/**
	 * Constructor para TypeDescriptorDisco.
	 */
	public TypeDescriptorDisco() {
		this.propiedades = new ArrayList<String>();
		this.propiedades.add("id");
		this.propiedades.add("titulo");
		this.propiedades.add("anio");
		this.propiedades.add("interprete");
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
		case "anio":
			return Type.Double;
		case "interprete":
			return Type.Long;
		default:
			return null;
		}
	}

	/**
	 *
	 * @return entidad disco
	 */
	@Override
	public Entity newEntity() {

		return new Disco();
	}
}
