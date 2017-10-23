{-# LANGUAGE RankNTypes, FlexibleContexts,FlexibleInstances,GADTs #-}
module C where
import Data.List

data Bebida = Bebida {codigo::Integer, nombre::String,precio::Double} deriving (Show,Eq)
data Partida = ParUnit Bebida | ParMult Bebida Integer deriving (Show,Eq)
type Factura = [Partida]

-- funciones de acceso para Partida
bebida :: Partida -> Bebida
bebida (ParUnit b) = b
bebida (ParMult b _) = b

cantidad :: Partida -> Integer
cantidad (ParUnit _) = 1
cantidad (ParMult _ x) = x

instance Num Factura where
   (+)=(++)


-- instancias de la clase Ord para permitir ordenacion de Bebidas y Partidas
instance Ord Bebida where
  compare x y = codigo  x `compare` codigo  y

instance Ord Partida where
  compare x y = bebida x `compare` bebida y


precioPartida :: Partida -> Double
precioPartida p = precio (bebida p) * fromIntegral (cantidad p)

precioListaPartida :: Factura -> Double
precioListaPartida fs = sum [precioPartida f | f<-fs]


concatListaPartida :: Factura -> Factura -> Factura
concatListaPartida f1 f2 = f1 + f2

precioTotalBebida :: Factura -> Bebida -> Double
precioTotalBebida ps b = sum [precioPartida p | p <- ps, bebida p == b]

busquedaPartida :: Factura -> Bebida -> Factura
busquedaPartida ps b = filter (\p -> bebida p == b) ps


busquedasPartida :: Factura -> [Bebida] -> Factura
busquedasPartida f bs = concat [busquedaPartida f b | b <- bs]


eliminarPartida :: Factura -> Bebida -> Factura
eliminarPartida ps b = filter (\p -> bebida p /= b) ps


eliminarPartidaCantidad :: Factura -> Integer -> Factura
eliminarPartidaCantidad ps n = filter (\p -> cantidad p <= n) ps


-- la funcion auxiliar agrupar_ordenar hace un agrupado de las bebidas por su codigo despues de ordenarlas
-- despues, se mapea a esa factura resultante creando un nuevo ParMult con el nombre de la bebida correspondiente
-- y la suma de todas las cantidades de sus apariciones
agruparBebidasPartida :: Factura -> Factura
agruparBebidasPartida ps = map (\xs-> ParMult (bebida (head xs)) $ sum [cantidad  x | x <- xs]) $ agrupar_ordenar ps
  where agrupar_ordenar fs = groupBy (\x y-> codigo (bebida x) == codigo (bebida y)) $ sort fs


{-PRUEBAS-}
main::IO ()
main=do
let b1=Bebida 1 "cocacola" 2.5
let b2=Bebida 2 "fanta" 3
let b3=Bebida 3 "trina" 3.5
let p1=ParMult b1 2
let p2=ParMult b2 3
let p3=ParMult b1 4
let p4=ParMult b3 2
let p5=ParMult b3 4
let p6=ParUnit b2
let f=[p1,p2,p5,p3,p4,p6]
let f2=[p4]
print $ f+f2
print $ precioTotalBebida f b1
print $ busquedaPartida f b1
print $ busquedasPartida f [b1,b3]
print $ eliminarPartida f b1
print $ eliminarPartidaCantidad f 3
print $ agruparBebidasPartida f
