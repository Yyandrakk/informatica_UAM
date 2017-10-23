{-# LANGUAGE RankNTypes, FlexibleContexts,FlexibleInstances,TypeSynonymInstances,GADTs,KindSignatures #-}
module E where

import D


--Funciona para bebida y partida pero no factura

class Preciable  (p :: * -> * ) where
 precio::(Fractional b)=>p b->b

instance Preciable (Bebida a) where
-- precio::(Bebida a, Fractional b)=>a->b
 precio =precioBebida

instance (Integral a)=>Preciable (Partida a a) where
 precio = precioPartida

main::IO ()
main=do
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
 print b1
 print $ precio b1
 print p1
 print $ precio p1
