using System;

namespace Practica_2b
{

    /* Funciones externas de manera que puedan ser reutilizadas mas adelante */
    public class GUI_Hundir_Flota
    {

        /* Dado un string bien formado, crea y devuelve un barco. */
        internal static Barco LecturaBarco(String sb)
        {
            string[] readBarco = sb.Split(' ');

            if (readBarco.Length < 4)
            {
                throw new ExcepcionBarcoErroneo();
            }

            int cx, cy, tam;

            bool p1 = int.TryParse(readBarco[1], out cx); // tryparse nos evita manejo de excepciones explicito
            bool p2 = int.TryParse(readBarco[2], out cy);
            bool p3 = int.TryParse(readBarco[3], out tam);

            if (p1 && p2 && p3)
            {
                switch (readBarco[0])
                {
                    case "v":
                    case "BarcoVertical":
                        return new BarcoVertical(new Coordenada(cx, cy), tam);
                    case "h":
                    case "BarcoHorizontal":
                        return new BarcoHorizontal(new Coordenada(cx, cy), tam);
                    default:
                        throw new ExcepcionBarcoErroneo();
                }
            }
            else { throw new ExcepcionBarcoErroneo(); }
        }


        /* Dado un string bien formado, crea y devuelve una coordenada. */
        internal static Coordenada LecturaCoordenada(string sc)
        {
            string[] readCoord = sc.Split(' ');

            if (readCoord.Length < 2)
            {
                throw new ExcepcionDisparoErroneo();
            }

            int cx, cy;

            bool p1 = int.TryParse(readCoord[0], out cx); // tryparse nos evita manejo de excepciones explicito
            bool p2 = int.TryParse(readCoord[1], out cy);

            if (p1 && p2)
            {
                return new Coordenada(cx, cy);
            }

            throw new ExcepcionDisparoErroneo();
        }
    }
}
