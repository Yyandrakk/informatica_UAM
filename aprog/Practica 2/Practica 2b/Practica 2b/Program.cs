using System;
using System.Collections.Generic;
using System.Reflection;
//using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica_2b
{
    class Program
    {
        static void Main(string[] args)
        {
            API_Hundir_Flota juego = new API_Hundir_Flota();

            Console.WriteLine("Instruciones: Las coordenadas son X e Y de 1 a 5 inclusive, en el plano cartesiano [x, y]");
            Console.WriteLine("Ahora va a introducir la  flota ([ BarcoHorizontal | BarcoVertical | h | v ] x y tam)");
            Console.WriteLine("\n******************************\n");

            Flota f = IntroducirFlota();
            juego.flota = juego.AgregarFlota(f);

            Console.WriteLine("\n******************************\n");

            Console.WriteLine(juego.flota);
            Console.WriteLine("\n******************************\n");

            Console.WriteLine("Ahora va a realizar disparos para hundir la flota");
            Console.WriteLine("\n******************************\n");


            while (juego.tab.HaGanado() == false)
            {
                Coordenada cd = IntroducirCoordenada();
                juego.RealizarDisparo(cd);
                Console.WriteLine(juego.tab);
            }

            Console.WriteLine("Felicidades, ha ganado...");
        }


        /* Avisa al usuario y procesa una coordenada leida de teclado. */
        private static Coordenada IntroducirCoordenada()
        {

            while (true)
            {
                try
                {
                    Console.WriteLine("Introduzca una coordenada");
                    String c = Console.ReadLine();
                    return GUI_Hundir_Flota.LecturaCoordenada(c); // sale del bucle
                }
                catch (Exception e)
                {
                    Console.WriteLine("Excepcion:" + e.GetType());
                }
            }
        }


        /* Avisa al usuario y procesa una flota leida de teclado. */
        private static Flota IntroducirFlota()
        {
            double restante = (0.2 * API_Hundir_Flota.dimension * API_Hundir_Flota.dimension);
            Flota f = new Flota();

            while (restante > 0)
            {
                Console.WriteLine("Introduce un barco (" + restante + " casillas restantes)");
                String s = Console.ReadLine();

                try // formateamos el barco leido
                {
                    Barco n = GUI_Hundir_Flota.LecturaBarco(s);
                    f = new Flota(f.flota, n); // no se ejecuta si hay excepcion
                    restante -= n.tam;
                }
                catch (Exception e)
                {
                    Console.WriteLine("Excepcion:" + e.GetType());
                }


                if (restante <= 0) break;
                else if (restante < API_Hundir_Flota.dimension) // asi evitamos jugar contra una flota vacia
                {
                    Console.WriteLine("Pulsa s para introducir otro barco");
                    string opt = Console.ReadLine();
                    if (opt != "s") break;
                }
            }

            return f;
        }
    }
}
