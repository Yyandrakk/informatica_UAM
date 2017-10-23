using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica_2b
{
    public class Tablero
    {
        public Tablero()
        {
            this.tablero = new List<Casilla>();
        }

        /* Constructores para la inmutabilidad */
        public Tablero(List<Casilla> oldTab, Casilla c)
        {
            List<Casilla> t2 = new List<Casilla>();
            foreach (Casilla cs in oldTab)
            {
                t2.Add(cs.Clone()); // clonamos cada casilla para que no sea la referencia anterior, sino una nueva
            }

            t2.Add(c);
            this.tablero = t2;
        }

        public Tablero(List<Casilla> oldTab)
        {
            List<Casilla> t2 = new List<Casilla>();
            foreach (Casilla cs in oldTab)
            {
                t2.Add(cs.Clone());
            }

            this.tablero = t2;
        }


        public List<Casilla> tablero
        {
            get;
            private set;
        }

        public override string ToString()
        {
            string mosaico = "";
            List<Coordenada> cordT = this.Coordenadas();

            for (int y = 1; y <= API_Hundir_Flota.dimension; y++)
            {
                for (int x = 1; x <= API_Hundir_Flota.dimension; x++)
                {
                    Coordenada pos = new Coordenada(x, y);
                    if (cordT.Contains(pos))
                    {
                        Estado e = this.tablero.Find(c => c.coord == pos).estado;
                        switch (e)
                        {
                            case Estado.Agua:
                                mosaico = mosaico + "A ";
                                break;
                            case Estado.Tocado:
                                mosaico = mosaico + "T ";
                                break;
                            case Estado.Hundido:
                                mosaico = mosaico + "H ";
                                break;
                            case Estado.Destruida:
                                mosaico = mosaico + "D ";
                                break;
                        }
                    }
                    else
                    {
                        mosaico = mosaico + ". ";
                    }

                }
                mosaico = mosaico + "\n";
            }
            return mosaico;
        }


        /* Devuelve las coordenadas de un tablero (las que tienen Estado por haber
          sido objeto de disparo) */
        private List<Coordenada> Coordenadas()
        {
            List<Coordenada> cs = new List<Coordenada>();
            foreach (Casilla c in this.tablero)
            {
                cs.Add(c.coord);
            }

            return cs;
        }


        /* Comprueba si todas las coordenadas de un barco tienen un
            cierto estado en este tablero
        */
        public bool BarcoEstado(Estado e, Barco b)
        {
            List<Coordenada> cordB = b.PosicionesBarco();
            List<Coordenada> cordT = this.Coordenadas();

            // Comprobamos que todas las coordenadas del barco estan en el tablero
            foreach (Coordenada c in cordB)
            {
                if (cordT.Contains(c) == false)
                {
                    return false;
                }
            }

            // Comprobamos que todas esas coordenadas tienen el estado dicho
            foreach (Casilla c in this.tablero)
            {
                if (c.estado != e && cordB.Contains(c.coord))
                {
                    return false;
                }
            }

            return true;
        }


        /* Actualiza todas las posiciones de un barco en un tablero como hundido
            dejando las de los otros barcos intactas
            (queda fuera del alcance de la funcion comprobar que el barco
            efectivamente esta hundido)
        */
        public Tablero HundirBarco(Barco b)
        {

            Tablero t = new Tablero(this.tablero);

            foreach (Casilla c in t.tablero)
            {
                if (b.PosicionesBarco().Contains(c.coord))
                {
                    c.estado = Estado.Hundido;
                }
            }

            return t;

        }

        /* Dada una flota, comprueba si ha sido destruida completamente:
            todas las casillas de todos los barcos tiene el estado de HUNDIDO
         */
        public bool FlotaDestruida(Flota f)
        {
            foreach (Barco b in f.flota)
            {
                if (BarcoEstado(Estado.Hundido, b) == false) return false;
            }

            return true;
        }


        /* Actualiza todas las posiciones de una flota en un tablero como destruida
            (queda fuera del alcance de la funcion comprobar que la flota
            efectivamente esta destruida)
            Dado que en un tablero solo cabe una flota, no hace falta pasarle la flota
        */
        public Tablero DestruirFlota()
        {

            Tablero t = new Tablero(this.tablero);

            foreach (Casilla c in t.tablero)
            {
                if (c.estado != Estado.Agua) c.estado = Estado.Destruida;
            }

            return t;
        }


        /* Comprueba si hay alguna casilla con estado destruida */
        public bool HaGanado()
        {
            foreach (Casilla c in this.tablero)
            {
                if (c.estado == Estado.Destruida)
                {
                    return true;
                }
            }

            return false;
        }


        /* Actualiza los vecinos cuando un barco es tocado (es decir, las
         * diagonales de la casilla tocada). */
        internal Tablero ActualizarVecinosTocado(Barco b, Coordenada c)
        {
            Tablero t = new Tablero(this.tablero);

            Coordenada c1 = new Coordenada(c.X + 1, c.Y + 1);
            Coordenada c2 = new Coordenada(c.X + 1, c.Y - 1);
            Coordenada c3 = new Coordenada(c.X - 1, c.Y + 1);
            Coordenada c4 = new Coordenada(c.X - 1, c.Y - 1);

            if (c1.EnRango()) t.tablero.Add(new Casilla(c1, Estado.Agua));
            if (c2.EnRango()) t.tablero.Add(new Casilla(c2, Estado.Agua));
            if (c3.EnRango()) t.tablero.Add(new Casilla(c3, Estado.Agua)); ;
            if (c4.EnRango()) t.tablero.Add(new Casilla(c4, Estado.Agua));

            return t;
        }


        /* Actualiza los vecinos cuando un barco es hundido (es decir, las
         * casillas anterior y siguiente al barco). */
        internal Tablero ActualizarVecinosHundido(Barco b, Coordenada c)
        {
            Tablero t = new Tablero(this.tablero);

            Coordenada c1 = b.CoordenadaSuperior();
            Coordenada c2 = b.CoordenadaInferior();

            if (c1.EnRango()) t.tablero.Add(new Casilla(c1, Estado.Agua));
            if (c2.EnRango()) t.tablero.Add(new Casilla(c2, Estado.Agua));

            return t;
        }

    }
}
