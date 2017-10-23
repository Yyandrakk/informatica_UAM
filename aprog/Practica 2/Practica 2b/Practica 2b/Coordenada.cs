using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica_2b
{
    public class Coordenada
    {
        public Coordenada(int x, int y)
        {
            this.X = x;
            this.Y = y;
        }

        public int X
        {
            get;
            private set;
        }

        public int Y
        {
            get;
            private set;
        }


        /* Sobrecargamos el metodo == para poder comaprar nuestras coordenadas */
        public static bool operator ==(Coordenada c1, Coordenada c2)
        {
            if (System.Object.ReferenceEquals(c1, c2))
            {
                return true;
            }

            if ((object)c1 == null || (object)c2 == null)
            {
                return false;
            }

            return c1.X == c2.X && c1.Y == c2.Y;
        }


        public static bool operator !=(Coordenada c1, Coordenada c2)
        {
            return !(c1 == c2);
        }


        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType())
            {
                return false;
            }

            return this == (Coordenada)obj;
        }


        public Coordenada Clone()
        {
            return new Coordenada(this.X, this.Y); // x e y son tipo valor, no se clona mas alla de Coordenada
        }


        /* Comprueba si una coordenada esta dentro del tablero */
        public bool EnRango()
        {
            return X > 0 && X <= API_Hundir_Flota.dimension && Y > 0 && Y <= API_Hundir_Flota.dimension;
        }


        public override int GetHashCode()
        {
            return base.GetHashCode() + this.X + this.Y;
        }


        public override string ToString()
        {
            return "Coordenada (" + this.X + ", " + this.Y + ") ";
        }
    }
}
