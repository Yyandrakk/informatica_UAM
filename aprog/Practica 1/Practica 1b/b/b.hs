{-# LANGUAGE RankNTypes, FlexibleContexts,FlexibleInstances,GADTs #-}
module B where

data Bebida = Bebida {codigo::Integer, nombre::String,precio::Double} deriving (Show,Eq)
data Partida = ParUnit Bebida | ParMult Bebida Integer deriving (Show,Eq)
type Factura = [Partida]

-- funciones de acceso para Partida
bebida :: Partida->Bebida
bebida (ParUnit b) = b
bebida (ParMult b _) = b

cantidad :: Partida->Integer
cantidad (ParUnit _) = 1
cantidad (ParMult _ x) = x

instance Num Factura where
 (+)=(++)


precioPartida :: Partida -> Double
precioPartida p = precio (bebida p) * fromIntegral (cantidad p)

precioListaPartida :: Factura -> Double
precioListaPartida [] = 0
precioListaPartida (f:fs) = precioPartida f + precioListaPartida fs

concatListaPartida :: Factura -> Factura -> Factura
concatListaPartida f1 f2 = f1 + f2

precioTotalBebida::Factura -> Bebida -> Double
precioTotalBebida [] _ = 0
precioTotalBebida (p:ps) b =
 if bebida p == b
 then precioPartida p + precioTotalBebida ps b
 else precioTotalBebida ps b

busquedaPartida::Factura -> Bebida -> Factura
busquedaPartida [] _ = []
busquedaPartida (p:ps) b =
  if bebida p == b
  then p : busquedaPartida ps b
  else busquedaPartida ps b

busquedasPartida::Factura -> [Bebida] -> Factura
busquedasPartida [] _ = []
busquedasPartida _ [] = []
busquedasPartida f (b:bs)= busquedaPartida f b ++ busquedasPartida f bs

eliminarPartida::Factura -> Bebida -> Factura
eliminarPartida [] _ = []
eliminarPartida (p:ps) b =
  if (bebida p) /= b
  then p : eliminarPartida ps b
  else eliminarPartida ps b

eliminarPartidaCantidad::Factura -> Integer -> Factura
eliminarPartidaCantidad [] _ = []
eliminarPartidaCantidad (p:ps) n =
  if (cantidad p) <= n
  then p : eliminarPartidaCantidad ps n
  else eliminarPartidaCantidad ps n


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
 let f=[p1,p2,p3,p4]
 let f2=[p4]
 print $ f+f2
 print $ precioTotalBebida f b1
 print $ busquedaPartida f b1
 print $ busquedasPartida f [b1,b3]
 print $ eliminarPartida f b1
 print $ eliminarPartidaCantidad f 3
