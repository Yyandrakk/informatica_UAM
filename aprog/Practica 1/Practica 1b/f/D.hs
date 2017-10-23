{-# LANGUAGE RankNTypes, FlexibleContexts,FlexibleInstances,GADTs #-}
module D where
import Data.List

data Bebida a b where
  Bebida::(Integral a,Fractional b)=>a->String->b->Bebida a b

data Partida a b c where
  ParUnit:: (Integral a,Fractional b)=>Bebida a b-> Partida a a b
  ParMult:: (Integral a,Fractional b)=>a->Bebida a b->Partida a a b

type Factura a b c=[Partida a b c]

bebida::Partida a a b->Bebida a b
bebida (ParUnit b)=b
bebida (ParMult _ b)=b

cantidad::Partida a a b->a
cantidad (ParUnit _)=1
cantidad (ParMult c _)=c

codigo::Bebida a b->a
codigo (Bebida c _ _)=c

precioBebida::Bebida a b->b
precioBebida (Bebida _ _ p)=p
instance Num (Factura a b c) where
   (+)=(++)

instance (Integral a, Eq a,Eq b ,Fractional b)=>Eq (Bebida a b) where
  (==)x y=codigo  x == codigo  y
instance (Integral a, Ord a, Eq a,Eq b ,Fractional b, Ord b)=>Ord (Bebida a b) where
  compare x y =  x `compare`  y

instance (Integral a, Show a, Show b ,Fractional b)=>Show (Bebida a b) where
    show (Bebida c s p)=show c ++" "++show s ++ " "++show p
instance (Integral a, Eq a, Fractional b , Eq b)=> Eq (Partida a a b) where
  (==)x y= bebida x == bebida y
instance (Integral a, Ord a, Eq a,Eq b ,Fractional b, Ord b)=> Ord (Partida a a b) where
  compare x y = bebida x `compare` bebida y
instance (Integral a, Show a,Fractional b, Show b)=> Show (Partida a a b) where
 show (ParUnit b)=show b ++ "->1"
 show (ParMult b c)=show b ++"->"++show c


precioPartida::(Integral a, Fractional b)=>Partida a a b->b
precioPartida p=precioBebida (bebida p) * fromIntegral (cantidad p)

precioListaPartida::(Integral a, Fractional b)=>Factura a a b->b
precioListaPartida fs = sum [precioPartida f| f<-fs]


concatListaPartida::Factura a a b->Factura a a b->Factura a a b
concatListaPartida f1 f2 = f1+f2

precioTotalBebida::(Integral a,Fractional b, Eq b)=>Factura a a b->Bebida a b->b
precioTotalBebida ps b=sum [precioPartida p |p<-ps,bebida p == b]

busquedaPartida::(Integral a,Fractional b,Eq b)=>Factura a a b->Bebida a b->Factura a a b
busquedaPartida ps b = filter (\ p->bebida p==b) ps


busquedasPartida::(Integral a,Fractional b, Eq b)=>Factura a a b->[Bebida a b]->Factura a a b
busquedasPartida f bs=concat [busquedaPartida f b| b<-bs]


eliminarPartida::(Integral a,Fractional b, Eq b)=>Factura a a b->Bebida a b->Factura a a b
eliminarPartida ps b=filter (\ p->bebida p/=b) ps


eliminarPartidaCantidad::(Integral a, Fractional b)=>Factura a a b->a->Factura a a b
eliminarPartidaCantidad ps n=filter (\ p->cantidad p<=n) ps

agruparBebidasPartida:: (Integral a, Fractional b, Ord b)=>Factura a a b->Factura a a b
agruparBebidasPartida ps= zipWith (\x y->ParMult y (bebida x)) (agrupar ps)  [sum [cantidad p |p<-ps,b==p]| b<-(agrupar ps)]
 where agrupar = nubBy (\x y->bebida x == bebida y)




{-PRUEBAS-}
main'::IO ()
main'=do
 let b1=Bebida 1 "cocacola" 2.5
 let b2=Bebida 2 "fanta" 3
 let b3=Bebida 3 "trina" 3.5
 let p1=ParMult 2 b1
 let p2=ParMult 3 b2
 let p3=ParMult 4 b1
 let p4=ParMult 2 b3
 let p5=ParMult 4 b3
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
