package p4.basedatos.implementacion;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import p4.basedatos.interfaces.DAO;
import p4.basedatos.interfaces.Entity;
import p4.basedatos.interfaces.Table;
import p4.basedatos.interfaces.TypeDescriptor;
import p4.exepcion.ExcepcionDAO;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class DAOImpl implements DAO {

	private List<Table> dao;

	/**
	 * Constructor para DAOUImpl.
	 */
	public DAOImpl() {
		this.dao = new ArrayList<Table>();
	}

	/**
	 * @param t
	 *            TypeDEscriptor a registrar
	 */
	@Override
	public void registerType(TypeDescriptor t) throws ExcepcionDAO {
		if (t == null) {
			throw new ExcepcionDAO("DAOImpl", "registerType",
					"el argumento es null");
		}
		if (this.dao.contains(t) == false) {
			Table ta = new TableImpl(t);
			this.dao.add(ta);
		}

	}

	/**
	 * @param type
	 *            tipo de la entidad
	 * 
	 * @param id
	 *            id de la entidad en la tabla
	 *
	 * @return entidad pelicula
	 */
	@Override
	public Entity getEntity(String type, Long id) throws ExcepcionDAO {
		if (type == null || id == null || type.isEmpty() || id < 0) {
			throw new ExcepcionDAO("DAOImpl", "getEntity",
					"error en los argumentos");
		}
		for (Table t : this.dao) {
			if (t.getType().getName().equalsIgnoreCase(type)) {

				return t.getEntity(id);
			}

		}
		return null;
	}

	/**
	 * @param e
	 *            entidad a actualizar
	 *
	 * @return id de la entidad actualizada
	 */
	@Override
	public long updateEntity(Entity e) throws ExcepcionDAO {
		if (e == null) {
			throw new ExcepcionDAO("DAOImpl", "updateEntity",
					"el argumento es null");
		}
		for (Table t : this.dao) {
			if (t.getType().getName().equalsIgnoreCase(e.getType())) {
				return t.updateEntity(e);
			}

		}

		return -1;
	}

	/**
	 * @param e
	 *            entidad a borrar
	 *
	 */
	@Override
	public void delete(Entity e) throws ExcepcionDAO {
		if (e == null) {
			throw new ExcepcionDAO("DAOImpl", "delete", "el argumento es null");
		}
		for (Table t : this.dao) {
			if (t.getType().getName().equals(e.getType())) {

				t.delete(e);
			}

		}

	}

	/**
	 * @param type
	 *            tipo a buscar
	 * 
	 * @param property
	 *            propiedad a buscar
	 *
	 * @param value
	 *            valor a buscar
	 * 
	 * @return Collection<Long> vacia si no hay resultados, si no con los datos
	 */
	@Override
	public Collection<Long> search(String type, String property, Object value)
			throws ExcepcionDAO {

		if (type == null || property == null || value == null || type.isEmpty()
				|| property.isEmpty()) {
			throw new ExcepcionDAO("DAOImpl", "search",
					"error en los argumentos");
		}
		for (Table t : this.dao) {
			if (t.getType().getName().equals(type)) {
				return t.search(property, value);
			}

		}

		return Collections.unmodifiableCollection(Collections.emptySet());
	}

	/**
	 * @param type
	 *            tipo a buscar
	 * 
	 * @param property
	 *            propiedad a buscar
	 *
	 * @param from
	 *            valor desde donde hay buscar
	 * 
	 * @param to
	 *            valor hasta donde hay buscar
	 * 
	 * @return Collection<Long> vacia si no hay resultados, si no con los datos
	 */
	@Override
	public Collection<Long> search(String type, String property, Object from,
			Object to) throws ExcepcionDAO {
		if (type == null || property == null || type.isEmpty()
				|| property.isEmpty()) {
			throw new ExcepcionDAO("DAOImpl", "search",
					"error en los argumentos");
		}
		for (Table t : this.dao) {
			if (t.getType().getName().equals(type)) {

				return t.search(property, from, to);
			}

		}
		return Collections.unmodifiableCollection(Collections.emptySet());
	}

}
