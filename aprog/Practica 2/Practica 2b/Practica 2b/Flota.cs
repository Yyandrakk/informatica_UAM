using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica_2b
{
    public class Flota
    {

        public Flota()
        {
            this.flota = new List<Barco>();
        }

        // Constructores para simular inmutabilidad
        public Flota(List<Barco> f)
        {
            List<Barco> f2 = new List<Barco>();
            foreach (Barco bn in f)
            {
                f2.Add(bn.Clone());
            }

            this.flota = f2;

        }

        public Flota(List<Barco> f, Barco b)
        {
            List<Barco> f2 = new List<Barco>();
            foreach (Barco bn in f)
            {
                f2.Add(bn.Clone());
            }

            f2.Add(b);
            this.flota = f2;
        }



        public List<Barco> flota
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

                    if (cordT.Contains(new Coordenada(x, y)))
                    {
                        mosaico = mosaico + "X ";
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


        /* Devuelve todas las coordenadas de la flota (sin contar perimetro) */
        public List<Coordenada> Coordenadas()
        {
            List<Coordenada> cordF = new List<Coordenada>();

            foreach (Barco b in flota)
            {
                cordF.AddRange(b.PosicionesBarco());
            }

            return cordF;
        }

        /* Devuelve el tamano de toda la flota */
        internal int Tam()
        {
            int tam = 0;
            foreach (Barco b in this.flota)
            {
                tam += b.tam;
            }

            return tam;
        }
    }
}
