package ejercicios;

import implementaciones.Producto;
import implementaciones.regla.TriggeredRule;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;

public class Ejercicio5 {
    public static void main(String[] args) {
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Producto p1;
	try {
	    p1 = new Producto(10, sdf.parse("15/03/2015"));
	    TriggeredRule.<Producto>trigRule("r1")
		.trigger(p1, "precio")
		.when(pro -> Producto.getDateDiff(Calendar.getInstance().getTime(), pro.getCaducidad(), TimeUnit.DAYS) < 2 )
		.exec(pro -> { System.out.println("Ojo! cambias el precio de un producto próximo a caducar"); });
		p1.setPrecio(17);
	} catch (ParseException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	} // “similar” a la clase Producto del apartado 2
	
    }
}
