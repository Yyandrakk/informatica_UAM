package p4.basedatos.implementacion;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import p4.basedatos.interfaces.Entity;
import p4.basedatos.interfaces.Index;
import p4.basedatos.interfaces.Table;
import p4.basedatos.interfaces.TypeDescriptor;
import p4.exepcion.ExcepcionDAO;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class TableImpl implements Table {

	private TypeDescriptor tipo;
	private SortedMap<String, Index> indices;
	private Map<Long, Map<String, Object>> tabla;
	private Long id_unico = 0L;

	/**
	 * Constructor para TableImpl.
	 * 
	 * @param e
	 *            TypeDescriptor de la tabla
	 */
	public TableImpl(TypeDescriptor e) {
		this.tipo = e;
		this.indices = new TreeMap<String, Index>();
		this.tabla = new TreeMap<Long, Map<String, Object>>();
	}

	/**
	 *
	 * @return the type
	 */
	@Override
	public TypeDescriptor getType() {
		// TODO Auto-generated method stub
		return this.tipo;
	}

	/**
	 * @param id
	 *            id de la entidad en la tabla
	 *
	 * @return entidad pelicula
	 */
	@Override
	public Entity getEntity(Long id) throws ExcepcionDAO {
		if (id == null || id < 0) {
			throw new ExcepcionDAO("TableImpl", "getEntity", "error en el id");
		}
		Map<String, Object> submap = this.tabla.get(id);
		if (submap == null) {
			return null;
		}
		Entity e = this.tipo.newEntity();
		for (String s : this.tipo.getProperties()) {
			e.setProperty(s, submap.get(s));
		}
		return e;
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
			throw new ExcepcionDAO("TableImpl", "updateEntity",
					"argumento null");
		}
		Long l = e.getId();
		Map<String, Object> submap;
		if (l == null) {
			e.setId(this.id_unico);
			this.id_unico++;

		} else {
			this.tabla.remove(e.getId());

		}

		submap = new TreeMap<String, Object>();

		for (String s : this.tipo.getProperties()) {
			submap.put(s, e.getProperty(s));
		}

		this.tabla.put(e.getId(), submap);

		for (String s : this.tipo.getProperties()) {
			Index i = this.indices.get(s);
			if (i == null) {
				i = new IndexImpl();
				this.indices.put(s, i);
			}
			i.add(submap.get(s), e.getId());

		}

		return e.getId();

	}

	/**
	 * @param e
	 *            entidad a borrar
	 *
	 */
	@Override
	public void delete(Entity e) throws ExcepcionDAO {
		if (e == null) {
			throw new ExcepcionDAO("TableImpl", "delete", "argumento null");
		}
		Map<String, Object> submap = (e.getId() != null) ? this.tabla.get(e
				.getId()) : null;
		if (submap != null) {

			for (String s : this.tipo.getProperties()) {
				Index i = this.indices.get(s);
				if (i == null) {
					i = new IndexImpl();
				}
				i.delete(submap.get(s), e.getId());
			}
			this.tabla.remove(e.getId());

		}

	}

	/**
	 * @param property
	 *            propiedad a buscar
	 *
	 * @param value
	 *            valor a buscar
	 * 
	 * @return Collection<Long> vacia si no hay resultados, si no con los datos
	 */
	@Override
	public Collection<Long> search(String property, Object value)
			throws ExcepcionDAO {
		if (value == null || property == null || property.isEmpty()) {
			throw new ExcepcionDAO("TableImpl", "search",
					"argumentos invalidos");
		}
		Index i = this.indices.get(property);
		if (i != null) {
			return i.search(value);
		}
		return Collections.unmodifiableCollection(Collections.emptySet());

	}

	/**
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
	public Collection<Long> search(String property, Object from, Object to)
			throws ExcepcionDAO {
		if (property == null || property.isEmpty()) {
			throw new ExcepcionDAO("TableImpl", "search",
					"argumentos invalidos");
		}
		Index i = this.indices.get(property);
		if (i != null)
			return i.search(from, to);

		return Collections.unmodifiableCollection(Collections.emptySet());

	}

}
