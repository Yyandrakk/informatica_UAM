package p4.ejercicios;

import p4.basedatos.implementacion.TableImpl;
import p4.basedatos.interfaces.Table;
import p4.basedatos.tienda.Libro;
import p4.basedatos.tienda.usuarios.Autor;
import p4.exepcion.ExcepcionDAO;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 * 
 *         prueba la implementacion Table (TableImpl)
 */
public class Ejercicio3 {
	/**
	 * punto de entrada a la aplicacion
	 * 
	 * @param args
	 *            los argumentos de linea de comandos no se usan
	 */
	public static void main(String[] args) {
		Table t = new TableImpl(Libro.getDescriptor());
		Libro l1 = new Libro();
		Autor a1 = new Autor();
		a1.setId(1L);
		l1.setTitulo("El Quijote");
		l1.setEditorial("Anaya");
		l1.setAutor(a1.getId());
		try {
			t.updateEntity(l1);

			t.updateEntity(l1);
			Libro l = (Libro) t.getEntity(l1.getId());
			if (l1.equals(l)) {
				System.out.println("Son iguales los libros");
			} else {
				System.out.println("No son iguales los libros");
			}
			t.delete(l1);
			l = (Libro) t.getEntity(l1.getId());
			if (l1.equals(l)) {
				System.out.println("Son iguales los libros");
			} else {
				System.out.println("No son iguales los libros");
			}
		} catch (ExcepcionDAO e) {
			System.out.println(e);
		}
	}
}
