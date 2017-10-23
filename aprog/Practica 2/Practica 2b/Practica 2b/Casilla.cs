using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica_2b
{
    /* Estado posible de una casilla. */
    public enum Estado { Agua, Tocado, Hundido, Destruida };

    public class Casilla
    {
        public Casilla(Coordenada c, Estado s)
        {
            this.coord = c;
            this.estado = s;
        }

        public Coordenada coord
        {
            get;
            private set;
        }

        public Estado estado
        {
            get;
            internal set;
        }

        public Casilla Clone()
        {
            return new Casilla(this.coord.Clone(), this.estado);
        }
    }
}
