package implementaciones;

import java.util.Date;
import java.util.Observable;
import java.util.concurrent.TimeUnit;

/**
 * @author Oscar Garcia de Lara
 * @author Patricia Anza
 */
public class Producto extends Observable {
    private double precio;
    private Date caducidad; // Otra opción es usar Calendar

    /**
     * Constructor para Producto.
     * 
     * @param p
     *            precio del producto
     * 
     * @param c
     *            fecha de caducidad
     */
    public Producto(double p, Date c) {
	this.precio = p;
	this.caducidad = c;
    }

    /**
     *
     * @return el precio
     */
    public double getPrecio() {
	return this.precio;
    }

    /**
     *
     * @param p
     *            precio del producto
     */
    public void setPrecio(double p) {
	this.precio = p;
	this.setChanged();
	this.notifyObservers("precio");
    }

    /**
     *
     * @return fecha de caducidad
     */
    public Date getCaducidad() {
	return this.caducidad;
    }

    /**
     * @param date1
     *            fecha 1
     *
     * @param date2
     *            fecha 2
     *
     * @param timeUnit
     *            unidad de tiempo
     *
     * @return la diferencia entre ambas fechas
     */
    public static long getDateDiff(Date date1, Date date2, TimeUnit timeUnit) {
	long diffInMillies = date2.getTime() - date1.getTime();
	return timeUnit.convert(diffInMillies, TimeUnit.MILLISECONDS);
    }

    @Override
    public String toString() {
	return this.precio + ", caducidad: " + this.caducidad;
    }
}

