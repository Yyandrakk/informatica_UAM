package p4.ejercicios;

import java.util.Collection;

import p4.basedatos.implementacion.DAOImpl;
import p4.basedatos.interfaces.DAO;
import p4.basedatos.tienda.Disco;
import p4.basedatos.tienda.Libro;
import p4.basedatos.tienda.Pelicula;
import p4.basedatos.tienda.usuarios.Autor;
import p4.basedatos.tienda.usuarios.Director;
import p4.basedatos.tienda.usuarios.Interprete;
import p4.exepcion.ExcepcionDAO;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 * 
 *         prueba la implementacion de DAO (DAOImpl)
 */
public class Ejecicio4 {
	/**
	 * punto de entrada a la aplicacion
	 * 
	 * @param args
	 *            los argumentos de linea de comandos no se usan
	 */
	public static void main(String[] args) {
		DAO dao = new DAOImpl();
		Libro l1 = new Libro();
		Autor a1 = new Autor();
		Disco d1 = new Disco();
		Director d = new Director();
		Interprete i = new Interprete();
		Pelicula p1 = new Pelicula();

		a1.setId(1L);
		d.setId(2l);
		i.setId(3l);
		l1.setTitulo("El Quijote");
		l1.setEditorial("Anaya");
		l1.setAutor(a1.getId());
		d1.setAnio(1994);
		d1.setInterprete(i.getId());
		d1.setTitulo("Dookie");
		p1.setDirector(d.getId());
		p1.setGenero("Drama");
		p1.setTitulo("Titanic");

		try {
			dao.registerType(Libro.getDescriptor());
			dao.registerType(Disco.getDescriptor());
			dao.registerType(Pelicula.getDescriptor());
			dao.updateEntity(l1);
			dao.updateEntity(d1);
			dao.updateEntity(p1);

			Libro l = (Libro) dao.getEntity(Libro.getDescriptor().getName(),
					l1.getId());

			if (l1.equals(l)) {
				System.out.println("Son iguales los libros");
			} else {
				System.out.println("No son iguales los libros");
			}
			Collection<Long> s = dao.search(Libro.getDescriptor().getName(),
					"titulo", "El Quijote");
			if (s.isEmpty()) {
				System.out.println("Esta vacia");
			} else {
				System.out.println(s);
			}
			dao.delete(l1);
			s = dao.search(Libro.getDescriptor().getName(), "titulo",
					"El Quijote");
			if (s.isEmpty()) {
				System.out.println("Esta vacia");
			} else {
				System.out.println(s);
			}
		} catch (ExcepcionDAO e) {
			// TODO Auto-generated catch block
			System.out.println(e);
		}

	}

}
