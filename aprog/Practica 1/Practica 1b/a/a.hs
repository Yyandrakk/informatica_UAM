module A where

data Bebida = Bebida {codigo::Integer, nombre::String,precio::Double} deriving (Show,Eq)
type Partida =(Bebida,Integer)
type Factura = [Partida]


precioPartida :: Partida -> Double
precioPartida (b,n) = precio b * fromIntegral n

precioListaPartida :: Factura -> Double
precioListaPartida [] = 0
precioListaPartida (f:fs) = precioPartida f + precioListaPartida fs

concatListaPartida :: Factura -> Factura -> Factura
concatListaPartida f1 f2 = f1 ++ f2

precioTotalBebida :: Factura -> Bebida -> Double
precioTotalBebida [] _ = 0
precioTotalBebida (f:fs) b =
 if fst f == b
 then precioPartida f + precioTotalBebida fs b
 else precioTotalBebida fs b

busquedaPartida :: Factura -> Bebida -> Factura
busquedaPartida [] _ = []
busquedaPartida (f:fs) b =
  if fst f == b
  then f : busquedaPartida fs b
  else busquedaPartida fs b

busquedasPartida :: Factura -> [Bebida] -> Factura
busquedasPartida [] _ = []
busquedasPartida _ [] = []
busquedasPartida f (b:bs)= busquedaPartida f b ++ busquedasPartida f bs

eliminarPartida :: Factura -> Bebida -> Factura
eliminarPartida [] _ = []
eliminarPartida (f:fs) b =
  if fst f /= b
  then f : eliminarPartida fs b
  else eliminarPartida fs b

eliminarPartidaCantidad :: Factura->Integer->Factura
eliminarPartidaCantidad [] _ = []
eliminarPartidaCantidad (f:fs) n =
  if snd f <= n
  then f : eliminarPartidaCantidad fs n
  else eliminarPartidaCantidad fs n


 {-PRUEBAS-}
main::IO ()
main=do
 let b1=Bebida 1 "cocacola" 2.5
 let b2=Bebida 2 "fanta" 3
 let b3=Bebida 3 "trina" 3.5
 let p1=(b1,2)
 let p2=(b2,3)
 let p3=(b1,4)
 let p4=(b3,2)
 let f=[p1,p2,p3,p4]
 print f
 print $ precioTotalBebida f b1
 print $ busquedaPartida f b1
 print $ busquedasPartida f [b1,b3]
 print $ eliminarPartida f b1
 print $ eliminarPartidaCantidad f 3
