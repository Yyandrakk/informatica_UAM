{-# LANGUAGE RankNTypes, FlexibleContexts,FlexibleInstances,GADTs #-}
module D where
import Data.List

data Bebida a b where
  Bebida :: (Integral a, Fractional b) => a -> String -> b -> Bebida a b

data Partida a b c where
  ParUnit :: (Integral a, Fractional b) => Bebida a b ->  Partida a b a
  ParMult :: (Integral a, Fractional b) => Bebida a b -> a -> Partida a b a

type Factura a b c=[Partida a b c]

-- funciones de acceso para Data partida polimorfico
bebida :: Partida a b a -> Bebida a b
bebida (ParUnit b) = b
bebida (ParMult b _) = b

cantidad :: Partida a b a -> a
cantidad (ParUnit _) = 1
cantidad (ParMult _ c) = c

codigo :: Bebida a b -> a
codigo (Bebida c _ _) = c

precio :: Bebida a b -> b
precio (Bebida _ _ p) = p


instance Num (Factura a b c) where
   (+)=(++)

instance (Integral a, Eq a,Eq b ,Fractional b)=>Eq (Bebida a b) where
  (==)x y = codigo  x == codigo  y

instance (Integral a, Ord a, Eq a,Eq b ,Fractional b, Ord b)=>Ord (Bebida a b) where
  compare x y =  x `compare`  y

instance (Integral a, Show a, Show b ,Fractional b)=>Show (Bebida a b) where
    show (Bebida c s p) = show c ++" "++show s ++ " "++show p


instance (Integral a, Eq a, Fractional b , Eq b)=> Eq (Partida a b a) where
  (==)x y= bebida x == bebida y

instance (Integral a, Ord a, Eq a,Eq b ,Fractional b, Ord b)=> Ord (Partida a b a) where
  compare x y = bebida x `compare` bebida y

instance (Integral a, Show a,Fractional b, Show b)=> Show (Partida a b a) where
 show (ParUnit b) = show b ++ "->1"
 show (ParMult b c) = show b ++ "->" ++ show c


precioPartida :: (Integral a, Fractional b) => Partida a b a -> b
precioPartida p = precio (bebida p) * fromIntegral (cantidad p)

precioListaPartida :: (Integral a, Fractional b) => Factura a b a -> b
precioListaPartida fs = sum [precioPartida f| f<-fs]


concatListaPartida :: Factura a b a -> Factura a b a -> Factura a b a
concatListaPartida f1 f2 = f1 + f2

precioTotalBebida :: (Integral a,Fractional b, Eq b) => Factura a b a -> Bebida a b -> b
precioTotalBebida ps b = sum [precioPartida p |p<-ps,bebida p == b]

busquedaPartida :: (Integral a,Fractional b,Eq b) => Factura a b a -> Bebida a b -> Factura a b a
busquedaPartida ps b = filter (\p->bebida p == b) ps


busquedasPartida :: (Integral a,Fractional b, Eq b) => Factura a b a -> [Bebida a b] -> Factura a b a
busquedasPartida f bs = concat [busquedaPartida f b| b<-bs]


eliminarPartida :: (Integral a,Fractional b, Eq b) => Factura a b a -> Bebida a b -> Factura a b a
eliminarPartida ps b = filter (\p->bebida p /= b) ps


eliminarPartidaCantidad :: (Integral a, Fractional b) => Factura a b a -> a -> Factura a b a
eliminarPartidaCantidad ps n = filter (\p -> cantidad p <= n) ps

agruparBebidasPartida :: (Integral a, Fractional b, Ord b) => Factura a b a -> Factura a b a
agruparBebidasPartida ps = zipWith (\x y->ParMult (bebida x) y) (agrupar ps)  [sum [cantidad p |p<-ps,b==p]| b<-(agrupar ps)]
 where agrupar = nubBy (\x y->bebida x == bebida y)


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
