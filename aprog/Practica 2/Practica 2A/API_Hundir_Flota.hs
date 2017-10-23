{-# LANGUAGE RankNTypes, FlexibleContexts, FlexibleInstances, TypeSynonymInstances, GADTs #-}
module API_Hundir_Flota where

import Data.List

{- Definiciones de tipos y datos -}
data Coordenada   = Coordenada  Integer Integer                         deriving (Show,Read)
data Estado       = Agua | Tocado | Hundido | Destruida                 deriving (Show, Enum, Eq, Ord)
data Casilla      = Casilla {coord :: Coordenada, estado :: Estado}     deriving (Show)
data Barco        = BarcoVertical Coordenada Integer
                    | BarcoHorizontal Coordenada Integer                deriving (Show,Read)

type Tablero = [Casilla]
type Flota = [Barco]
type Mosaico = [String]

{- Funciones de acceso -}
coordX, coordY :: Coordenada -> Integer
coordX (Coordenada x _) = x
coordY (Coordenada _ y) = y

pos :: Barco -> Coordenada
pos (BarcoVertical c _) = c
pos (BarcoHorizontal c _) = c

tam :: Barco -> Integer
tam (BarcoVertical _ t) = t
tam (BarcoHorizontal _ t) = t


{- Instancias (con overlap) -}
instance {-# OVERLAPPING #-} Show Tablero where
  show t = unlines $ incluirTablero t

instance {-# OVERLAPPING #-} Show Flota where
  show t = unlines $ incluirFlota t

instance Eq Coordenada where
  (==) c1 c2 = coordX c1 == coordX c2 && coordY c1 == coordY c2


{- Dimension de cada lado del tablero (cuadrado) -}
dimension :: Integer
dimension = 5

{- Variables iniciales -}
mosaicoInicial :: Mosaico
mosaicoInicial = replicate (fromInteger dimension) (replicate (fromInteger dimension) '.')

tableroInicial :: Tablero
tableroInicial = []

flotaInicial :: Flota
flotaInicial = []


{- Convierte una flota en un mosaico ([String]) para poder ser impresa por pantalla -}
incluirFlota :: Flota -> Mosaico
incluirFlota = foldl incluirBarco mosaicoInicial

{- Funcion auxiliar que da valores Char a la casilla de un barco -}
incluirBarco :: Mosaico -> Barco -> Mosaico
incluirBarco mosaico barco = map fila [1..dimension]
        where fila n = map (letra n) [1..dimension]
              (letra n) m | dentroBarco n m = 'X'
                          | otherwise = (mosaico !! ((fromInteger n) - 1)) !! ((fromInteger m) - 1)
                  where dentroBarco n m = case barco of
                                           (BarcoVertical c t) -> (coordY c <= n) && (n < coordY c + t) && (coordX c == m)
                                           (BarcoHorizontal c t) -> (coordY c == n) && (coordX c <= m) && (m < coordX c + t)


{- Convierte un tablero en un mosaico ([String]) para poder ser impreso por pantalla -}
incluirTablero :: Tablero -> Mosaico
incluirTablero = foldl incluirCasilla mosaicoInicial

{- Funcion auxiliar que da valores Char a la casilla de un tablero -}
incluirCasilla :: Mosaico -> Casilla -> Mosaico
incluirCasilla mosaico casilla = map fila [1..dimension]
     where
           fila n = map (letra n) [1..dimension]
           (letra n) m | coordY (coord casilla) == n && coordX (coord casilla) == m =
                                                                                    case estado casilla of
                                                                                       Agua -> 'A'
                                                                                       Tocado -> 'T'
                                                                                       Hundido -> 'H'
                                                                                       Destruida -> 'D'
                        | otherwise = (mosaico !! ((fromInteger n)-1)) !! ((fromInteger m)-1)


{- Agrega un barco a una flota si este cumple las condiciones -}
agregarBarco :: Flota -> Barco -> Flota
agregarBarco f b = if comprobarBarco f b then f ++ [b] else f


{- Comprueba si un barco es admisible en una flota:
    - sus coordenadas estan dentro de 1 -> dimension
    - tiene espacio en la flota
-}
comprobarBarco :: Flota -> Barco -> Bool
comprobarBarco f b = case b of
                      (BarcoVertical c t) -> (coordX c >= 1) && (coordY c >= 1) && (coordY c + t <= dimension + 1) && (comprobarEspacio f b)
                      (BarcoHorizontal c t) -> (coordX c >= 1) && (coordY c >= 1) && (coordX c + t <= dimension + 1) && (comprobarEspacio f b)


{- Comprueba si la flota estaria llena incluyendo un barco dado
    (hay mas del 20% de casillas ocupadas por barcos)
-}
flotaLlena :: Flota -> Barco -> Bool
flotaLlena f b = fromInteger (tamFlota f + tam b ) > (0.2 * fromInteger (dimension * dimension))


{- Comprueba si un barco tiene espacio en una flota:
    - el tam actual mas el del nuevo barco no debe sobrepasar el 20% de dimension
    - todas las casillas adyacentes a las que ocupe el nuevo barco deben estar vacias
-}
comprobarEspacio :: Flota -> Barco -> Bool
comprobarEspacio [] _ = True
comprobarEspacio (f:fs) b = if flotaLlena (f:fs) b
                            then
                              False
                            else
                              (l \\ posicionesBarco f) == l -- las posiciones que necesito (menos) las que ocupa f
                              && comprobarEspacio fs b
  where
    l = case b of  -- "l" lista las coordenadas que TIENEN que tener hueco libre
        (BarcoVertical c t) ->         [ Coordenada (coordX c - 1) y  | y <- r ] -- a la izquierda
                                    ++ [ Coordenada (coordX c) y      | y <- r ]
                                    ++ [ Coordenada (coordX c + 1) y  | y <- r ] -- a la derecha
                  where r = [(coordY c - 1)..((coordY c) + t)]

        (BarcoHorizontal c t) ->       [ Coordenada x (coordY c - 1)  | x <- r ] -- abajo
                                    ++ [ Coordenada x (coordY c)      | x <- r ]
                                    ++ [ Coordenada x (coordY c + 1)  | x <- r ] -- arriba
                  where r = [(coordX c - 1)..((coordX c) + t)]


{- Devuelve las coordenadas que ocupa un barco -}
posicionesBarco :: Barco -> [Coordenada]
posicionesBarco (BarcoVertical c t) = [ Coordenada (coordX c) y | y <- [(coordY c)..(coordY c) + t - 1] ]
posicionesBarco (BarcoHorizontal c t) = [ Coordenada x (coordY c) | x <- [(coordX c)..(coordX c) + t - 1] ]


{- Devuelve la dimension total de una flota -}
tamFlota :: Flota -> Integer
tamFlota fs = sum (map tam fs)


{- Realiza un disparo y anota el resultado en el tablero
    (la segunda flota se pasa para que no se pierdan barcos en cada iteracion de f:fs)
-}
realizarDisparo :: Tablero -> Flota -> Flota -> Coordenada -> Tablero
realizarDisparo t [] _ c = if coordenadaEnRango c then (Casilla c Agua) : t else t -- solo si no se ha tocado ningun barco, ponemos un Agua
realizarDisparo t (f:fs) f2 c = if coordenadaEnRango c
                             then
                                    if c `elem` posicionesBarco f
                                      then
                                          if barcoHundido ((Casilla c Tocado):t) f -- si f esta hundido, comprobamos si estan todos hundidos
                                          then
                                            let t2 = hundirBarco ((Casilla c Tocado):t) f in -- actualizamos t con la casilla tocada y hundimos el barco
                                              if
                                                flotaDestruida t2 f2 -- si la flota esta destruida, la destruimos y actualizamos vecinos
                                              then
                                                destruirFlota t2 ++ actualizarVecinos' f ++ actualizarVecinos c
                                              else
                                                t2 ++ actualizarVecinos' f ++ actualizarVecinos c
                                          else
                                              (Casilla c Tocado) : (actualizarVecinos c ++ t)
                                      else
                                        realizarDisparo t fs f2 c
                             else
                               t


{- Comprueba si una coordenada esta dentro del tablero -}
coordenadaEnRango :: Coordenada -> Bool
coordenadaEnRango (Coordenada x y) = x > 0 && x <= dimension && y > 0 && y <= dimension


{- Actualiza con el estado de Agua los vecinos en las diagonales de una casilla
    (para cuando un barco sea tocado pero no hundido)
    Devuelve la lista de casillas con el estado ya cambiado para ser agregado a un tablero
-}
actualizarVecinos :: Coordenada -> [Casilla]
actualizarVecinos c = map (\(x,y) -> Casilla (Coordenada x y) Agua) $ filter (\(x,y) -> x > 0 && y > 0 && x <= dimension && y <= dimension) l -- filtramos las casillas en rango dentro de las diagonales
  where x = coordX c
        y = coordY c
        l = [(x - 1, y - 1), (x + 1, y + 1), (x - 1, y + 1), (x + 1, y - 1)]


{- Actualiza con el estado de Agua los vecinos de la casilla anterior al inicio y siguiente al final del barco
    (para cuando un barco sea hundido)
    Devuelve la lista de casillas con el estado ya cambiado para ser agregado a un tablero
-}
actualizarVecinos' :: Barco -> [Casilla]
actualizarVecinos' (BarcoVertical c t) = (map (\(x,y) -> Casilla (Coordenada x y) Agua) $ filter (\(x,y) -> x > 0 && y > 0 && x <= dimension && y <= dimension) lv)
 where x = coordX c
       y = coordY c
       lv = [(x, y - 1), (x, y + t)]

actualizarVecinos'(BarcoHorizontal c t) = (map (\(x,y) -> Casilla (Coordenada x y) Agua) $ filter (\(x,y) -> x > 0 && y > 0 && x <= dimension && y <= dimension) lh)
 where x = coordX c
       y = coordY c
       lh = [(x - 1, y), (x + t, y)]


{- Comprueba si todas las coordenadas de un barco tienen un
    cierto estado en un tablero (es implica que todas las coordenadas
    del barco estan en el tablero)
-}
barcoEstado :: Estado -> Tablero -> Barco -> Bool
barcoEstado e t b = (all (\c -> estado c == e) l) && not (null l) && (length l == length cordB)
  where
       cordB = posicionesBarco b
       l = filter (\c -> (coord c `elem` cordB )) t


{- Dado un barco, comprueba si todas sus posiciones han sido TOCADAS
   en un tablero:
    - todas sus casillas estan en Tablero con el estado de tocado
-}
barcoHundido :: Tablero -> Barco -> Bool
barcoHundido = barcoEstado Tocado


{- Actualiza todas las posiciones de un barco en un tablero como hundido
  dejando las de los otros barcos intactas
  (queda fuera del alcance de la funcion comprobar que el barco
  efectivamente esta hundido)
-}
hundirBarco :: Tablero -> Barco -> Tablero
hundirBarco [] _ = []
hundirBarco ts b = (map (\t -> Casilla (coord t) Hundido) (filter (\x -> coord x `elem` posicionesBarco b) ts))
                    ++ (filter (\x -> coord x `notElem` posicionesBarco b) ts)


{- Dada una flota, comprueba si ha sido destruida completamente:
    - todas las casillas de todos los barcos tiene el estado de HUNDIDO
-}
flotaDestruida :: Tablero -> Flota -> Bool
flotaDestruida [] _ = False
flotaDestruida _ [] = True
flotaDestruida t bs = all (barcoEstado Hundido t) bs


{- Actualiza todas las posiciones de una flota en un tablero como destruida
  (queda fuera del alcance de la funcion comprobar que la flota
  efectivamente esta destruida)
  Dado que en un tablero solo cabe una flota, no hace falta pasarle la flota
-}
destruirFlota :: Tablero -> Tablero
destruirFlota [] = []
destruirFlota ts = (map (\t -> Casilla (coord t) Destruida) (filter (\t -> estado t > Agua) ts))
                    ++ (filter (\t -> estado t == Agua) ts)


{- Comprueba si hay alguna casilla con estado destruida y, por lo
    tanto, se ha ganado l partida
 -}
haGanado :: Tablero -> Bool
haGanado = any (\c -> estado c == Destruida)
