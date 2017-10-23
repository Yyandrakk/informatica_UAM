using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica_2b
{
    /* Esta clase es la contenedora en si del juego, por lo que
        va a tener un tablero y flota internos.
    */
    class API_Hundir_Flota
    {

        /* Dimension de cada uno de los cuatro lados del tablero */
        static internal int dimension = 5;

        public API_Hundir_Flota()
        {
            tab = new Tablero();
            flota = new Flota();
        }

        public Tablero tab
        {
            get;
            private set;
        }

        public Flota flota
        {
            get;
            set;
        }


        /* Comprueba si un barco es admisible en una flota:
            - sus coordenadas estan dentro de 1 -> dimension
            - tiene espacio en la flota
        */
        private bool ComprobarBarco(Barco b)
        {
            return b.coord.X > 0 && b.coord.X <= dimension && b.coord.Y > 0 && b.coord.Y <= dimension && ComprobarEspacio(b);
        }


        /* Comprueba si un barco tiene espacio en una flota:
            - el tam actual mas el del nuevo barco no debe sobrepasar el 20% de dimension
            - todas las casillas adyacentes a las que ocupe el nuevo barco deben estar vacias
        */
        private bool ComprobarEspacio(Barco b)
        {
            if (FlotaLlena(b)) return false;

            foreach (Coordenada c in b.PosicionesNecesarias())
            {
                if (this.flota.Coordenadas().Contains(c))
                {
                    return false;
                }
            }

            return true;
        }


        /* Comprueba si la flota estaria llena incluyendo un barco dado
            (hay mas del 20% de casillas ocupadas por barcos)
        */
        private bool FlotaLlena(Barco b)
        {
            return (flota.Tam() + b.tam) > (0.2 * dimension * dimension);
        }


        /* Realiza un disparo y anota el resultado en el tablero */
        public void RealizarDisparo(Coordenada c)
        {
            if (c == null || c.EnRango() == false) return;

            int flag = 0;
            foreach (Barco b in this.flota.flota)
            {
                if (b.PosicionesBarco().Contains(c))
                {
                    flag = 1;

                    // this.tab.Add(new Casilla(c, Estado.Tocado));
                    this.tab = new Tablero(this.tab.tablero, new Casilla(c, Estado.Tocado));
                    this.tab = this.tab.ActualizarVecinosTocado(b, c);

                    // comprobamos si el barco queda hundido y en caso afirmativo lo actualizamos
                    if (this.tab.BarcoEstado(Estado.Tocado, b))
                    {
                        this.tab = this.tab.HundirBarco(b);
                        this.tab = this.tab.ActualizarVecinosHundido(b, c);

                        // comprobamos si toda la flota queda hundida
                        if (this.tab.FlotaDestruida(this.flota))
                        {
                            this.tab = this.tab.DestruirFlota();
                        }
                    }
                }
            }

            // solo ponemos el agua si ningun barco ha sido tocado
            if (flag == 0) {
                //this.tab.Add(new Casilla(c, Estado.Agua));
                this.tab = new Tablero(this.tab.tablero, new Casilla(c, Estado.Agua));
            }
        }


        /* Coge de una flota los elementos validos y la devuelve */
        internal Flota AgregarFlota(Flota f)
        {
            Flota f2 = new Flota();

            foreach (Barco b in f.flota)
            {
                if (ComprobarBarco(b))
                {
                    f2.flota.Add(b);
                }
            }

            return f2;
        }

    }
}
