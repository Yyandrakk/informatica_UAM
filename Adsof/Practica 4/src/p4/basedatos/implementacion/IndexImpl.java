package p4.basedatos.implementacion;

import java.util.*;

import p4.basedatos.interfaces.Index;
import p4.exepcion.ExcepcionDAO;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class IndexImpl implements Index {
	private SortedMap<Object, Set<Long>> indice;

	/**
	 * Constructor para IndexImpl.
	 * 
	 */
	public IndexImpl() {
		this.indice = new TreeMap<Object, Set<Long>>(CompararNull.instance);
	}

	/**
	 * @param key
	 *            objeto a annadir
	 *
	 * @param value
	 *            valor a annadir
	 */
	@Override
	public Long add(Object key, Long value) throws ExcepcionDAO {
		if (key == null || value == null || value < -1) {
			throw new ExcepcionDAO("IndexImpl", "add", "argumentos invalidos");
		}
		Set<Long> s;
		if (indice.containsKey(key) == false) {
			s = new HashSet<Long>();
			this.indice.put(key, s);
		}
		s = indice.get(key);

		s.add(value);
		return value;
	}

	/**
	 * @param key
	 *            objeto a borrar
	 *
	 * @param value
	 *            valor a borrar
	 */
	@Override
	public void delete(Object key, Long value) throws ExcepcionDAO {
		if (key == null || value == null || value < -1) {
			throw new ExcepcionDAO("IndexImpl", "delete",
					"argumentos invalidos");
		}

		if (indice.containsKey(key)) {
			Set<Long> s = indice.get(key);
			s.remove(value);

		}
	}

	/**
	 *
	 * @param key
	 *            valor a buscar
	 * 
	 * @return Collection<Long> vacia si no hay resultados, si no con los datos
	 */
	@Override
	public Collection<Long> search(Object key) throws ExcepcionDAO {
		if (key == null) {
			throw new ExcepcionDAO("IndexImpl", "search", "argumento es null");
		}
		if (indice.get(key) == null) {
			return Collections.unmodifiableCollection(Collections.emptySet());
		} else {
			return Collections.unmodifiableCollection(indice.get(key));
		}

	}

	/**
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
	public Collection<Long> search(Object from, Object to) {

		SortedMap<Object, Set<Long>> subindice;
		Set<Long> dev = new HashSet<Long>();
		if (from == null && to == null) {

			for (Object o : this.indice.keySet()) {
				dev.addAll(this.indice.get(o));
			}
		} else if (from == null) {
			subindice = this.indice.subMap(this.indice.firstKey(), to);

			for (Object o : subindice.keySet()) {
				if (subindice.get(o) != null)
					dev.addAll(subindice.get(o));
			}
			dev.addAll(this.indice.get(to));
		} else if (to == null) {
			subindice = this.indice.subMap(from, this.indice.lastKey());

			for (Object o : subindice.keySet()) {
				if (subindice.get(o) != null)
					dev.addAll(subindice.get(o));
			}

			dev.addAll(this.indice.get(this.indice.lastKey()));
		} else {
			subindice = this.indice.subMap(from, to);

			for (Object o : subindice.keySet()) {
				if (subindice.get(o) != null)
					dev.addAll(subindice.get(o));
			}
			dev.addAll(this.indice.get(to));
		}
		if (dev.size() == 0) {
			return Collections.unmodifiableCollection(Collections.emptySet());
		} else {
			return Collections.unmodifiableCollection(dev);
		}
	}
}
