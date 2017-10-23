using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica_2b
{
    /* Clase abstracta que representa un barco */
    public abstract class Barco
    {
        public Barco(Coordenada c, int tam)
        {
            this.coord = c;
            this.tam = tam;
        }

        public Coordenada coord
        {
            get;
            private set;
        }

        public int tam
        {
            get;
            private set;
        }

        /* Devuelve las posiciones de coordenada que ocupa un barco */
        public abstract List<Coordenada> PosicionesBarco();

        /* Devuelve las posiciones de coordenada que necesita un barco (las suyas + perimetro) */
        public abstract List<Coordenada> PosicionesNecesarias();

        /* Devuelve la coordenada superior del barco (anterior a la primera) */
        public abstract Coordenada CoordenadaSuperior();

        /* Devuelve la coordenada inferior del barco (siguiente a la ultima) */
        public abstract Coordenada CoordenadaInferior();

        /* Devuelve una copia del barco instanciado */
        public abstract Barco Clone();
    }

    public class BarcoVertical : Barco
    {
        public BarcoVertical(Coordenada c, int tam)
            : base(c, tam)
        {
        }

        public override Barco Clone()
        {
            return new BarcoVertical(this.coord.Clone(), this.tam);
        }


        public override List<Coordenada> PosicionesBarco()
        {
            List<Coordenada> cordB = new List<Coordenada>();

            for (int i = 0; i < tam; i++)
            {
                if (coord.X > 0 && coord.X <= API_Hundir_Flota.dimension && coord.Y + i > 0 && coord.Y + i <= API_Hundir_Flota.dimension)
                {
                    cordB.Add(new Coordenada(coord.X, coord.Y + i));
                }
            }

            return cordB;
        }

        public override List<Coordenada> PosicionesNecesarias()
        {
            List<Coordenada> cordN = new List<Coordenada>();

            for (int i = -1; i <= tam; i++)
            {
                Coordenada c1 = new Coordenada(coord.X, coord.Y + i);
                Coordenada c2 = new Coordenada(coord.X - 1, coord.Y + i);
                Coordenada c3 = new Coordenada(coord.X + 1, coord.Y + i);

                if (c1.EnRango()) cordN.Add(c1);
                if (c2.EnRango()) cordN.Add(c2);
                if (c3.EnRango()) cordN.Add(c3);
            }

            return cordN;
        }

        public override Coordenada CoordenadaSuperior()
        {
            return new Coordenada(this.coord.X, this.coord.Y - 1);
        }

        public override Coordenada CoordenadaInferior()
        {
            return new Coordenada(this.coord.X, this.coord.Y + this.tam);
        }

    }

    public class BarcoHorizontal : Barco
    {
        public BarcoHorizontal(Coordenada c, int tam)
            : base(c, tam)
        {
        }

        public override Barco Clone()
        {
            return new BarcoHorizontal(this.coord.Clone(), this.tam);
        }

        public override List<Coordenada> PosicionesBarco()
        {
            List<Coordenada> cordB = new List<Coordenada>();

            for (int i = 0; i < tam; i++)
            {
                if (coord.Y > 0 && coord.Y <= API_Hundir_Flota.dimension && coord.X + i > 0 && coord.X + i <= API_Hundir_Flota.dimension)
                {
                    cordB.Add(new Coordenada(coord.X + i, coord.Y));
                }
            }
            
            return cordB;
        }

        public override List<Coordenada> PosicionesNecesarias()
        {
            List<Coordenada> cordN = new List<Coordenada>();

            for (int i = -1; i <= tam; i++)
            {
                Coordenada c1 = new Coordenada(coord.X + i, coord.Y - 1);
                Coordenada c2 = new Coordenada(coord.X + i, coord.Y);
                Coordenada c3 = new Coordenada(coord.X + i, coord.Y + 1);

                if (c1.EnRango()) cordN.Add(c1);
                if (c2.EnRango()) cordN.Add(c2);
                if (c3.EnRango()) cordN.Add(c3);
            }

            return cordN;
        }

        public override Coordenada CoordenadaSuperior()
        {
            return new Coordenada(this.coord.X - 1, this.coord.Y);
        }

        public override Coordenada CoordenadaInferior()
        {
            return new Coordenada(this.coord.X + this.tam, this.coord.Y);
        }

    }
}
