package practica3.es.uam.eps.p3.simulacion;

import java.io.*;
import java.util.*;

import practica3.es.uam.eps.p3.juego.camino.Camino;
import practica3.es.uam.eps.p3.juego.explorador.Explorador;
import practica3.es.uam.eps.p3.juego.posada.Posada;

/**
 * @author Oscar Garcia de Lara Parreño
 * @author Patricia Anza Mateos
 */
public class Simulacion {
    private List<Posada> posadas;
    private List<Camino> caminos;
    private Explorador explorador;

    /**
     * Constructor de la clase Simulacion
     * 
     * @param txt_posada
     *            Nombre del fichero que contiene las posadas
     * @param txt_caminos
     *            Nombre del fichero que contiene los caminos
     * @param txt_explorador
     *            Nombre del fichero que contiene al explorador y sus
     *            movimientos
     * @throws IOException Al abrir o trabajar con los ficheros
     */
    public Simulacion(String txt_posada, String txt_caminos,
	    String txt_explorador) throws IOException {
	this.posadas = new ArrayList<Posada>();
	this.caminos = new ArrayList<Camino>();
	leer_posadas(txt_posada);
	leer_caminos(txt_caminos);
	leer_explorador(txt_explorador);

    }

    /**
     * Lee las posadas y las añade a su lista
     * 
     * @param txt_posada
     *            Nombre del fichero de las posadas
     * @throws IOException
     */
    private void leer_posadas(String txt_posada) throws IOException {
	@SuppressWarnings("resource")
	BufferedReader buffer = new BufferedReader(new InputStreamReader(
		new FileInputStream(txt_posada)));
	String linea;
	String[] palabras;
	while ((linea = buffer.readLine()) != null) {
	    palabras = linea.split(" ");
	    if (palabras.length == 2) {
		this.posadas.add(new Posada(palabras[0], Integer
			.parseInt(palabras[1])));
	    } else {
		throw new IOException();

	    }
	}
	buffer.close();

    }

    /**
     * Lee los caminos y los añade en su lista
     * 
     * @param txt_caminos
     *            Nombre del fichero que contiene los caminos
     * @throws NumberFormatException
     * @throws IOException
     */
    private void leer_caminos(String txt_caminos) throws NumberFormatException,
	    IOException {
	@SuppressWarnings("resource")
	BufferedReader buffer = new BufferedReader(new InputStreamReader(
		new FileInputStream(txt_caminos)));
	String linea;
	String[] palabras;
	while ((linea = buffer.readLine()) != null) {
	    palabras = linea.split(" ");
	    if (palabras.length == 3) {
		for (Posada o : posadas) {
		    if (o.getNombre().equals(palabras[0])) {
			for (Posada d : posadas) {
			    if (d.getNombre().equals(palabras[1])) {
				this.caminos.add(new Camino(o, d, Integer
					.parseInt(palabras[2])));
				o.addCamino(this.caminos.get(this.caminos
					.size() - 1));
				break;
			    }
			}
		    }
		}

	    } else {
		throw new IOException();

	    }
	}
	buffer.close();

    }

    /**
     * Lee el explorador y realiza los movimientos
     * 
     * @param txt_explorador
     *            Nombre del fichero del explorador
     * @throws NumberFormatException
     * @throws IOException
     */
    private void leer_explorador(String txt_explorador)
	    throws NumberFormatException, IOException {

	@SuppressWarnings("resource")
	BufferedReader buffer = new BufferedReader(new InputStreamReader(
		new FileInputStream(txt_explorador)));
	String linea;
	String[] palabras;
	while ((linea = buffer.readLine()) != null) {
	    palabras = linea.split(" ");
	    if (palabras.length == 3) {
		for (Posada o : this.posadas) {
		    if (o.getNombre().equals(palabras[2])) {
			this.explorador = new Explorador(palabras[0],
				Integer.parseInt(palabras[1]), o);
			break;
		    }
		}
	    } else if (palabras.length == 1) {
		for (Posada d : this.posadas) {
		    if (d.getNombre().equals(palabras[0])) {
			this.explorador.recorre(d);
			System.out.println(this.explorador);
		    }
		}
	    } else {
		throw new IOException();
		// MIRAR SI ESTA BIEN
	    }
	}
	buffer.close();

    }
}
