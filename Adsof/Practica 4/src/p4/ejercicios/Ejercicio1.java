package p4.ejercicios;

import p4.basedatos.interfaces.TypeDescriptor;
import p4.basedatos.tienda.Libro;
import p4.basedatos.tienda.usuarios.Autor;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 * 
 *         prueba la implementacion de Entity y TypeDescriptor
 */
public class Ejercicio1 {
	/**
	 * punto de entrada a la aplicacion
	 * 
	 * @param args
	 *            los argumentos de linea de comandos no se usan
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Libro l1 = new Libro();
		l1.setTitulo("El Quijote");
		String titulo = (String) l1.getProperty("titulo"); // devuelve “El
															// Quijote”
		TypeDescriptor t1 = Libro.getDescriptor(); // Ejemplo de método para
													// obtener el descriptor
		// Nota: Se deja a criterio del alumno la mejor forma de crear y obtener
		// los descriptores
		t1.getName(); // devuelve “Libro”
		t1.getType("titulo"); // devuelve Type.String
		t1.getType("autor"); // devuelve Type.Long, ya que libro guarda el id
								// del autor
		Autor a1 = new Autor();
		a1.setId(1L); // simulamos que la base de datos le dio el id 1 al autor
		a1.setProperty("apellidos", "Cervantes");
		a1.getApellidos(); // devolverá “Cervantes”
		l1.setAutor(a1.getId());
		System.out.println(titulo);
	}
}
