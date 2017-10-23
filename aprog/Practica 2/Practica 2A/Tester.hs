module Tester where

import API_Hundir_Flota

{- Este archivo contiene varios main de prueba que hemos usado.
    El juego principal es el metodo GUI_Hundir_Flota.mainPlay
-}


main :: IO ()
main = do
       let f = (BarcoVertical (Coordenada 1 2) 2):[]
       print f
       let f2 = agregarBarco f (BarcoVertical (Coordenada 3 4) 2) -- probamos agregar barco de manera directa
       print f2
       let t = (Casilla (Coordenada 1 1) Agua):(Casilla (Coordenada 2 2) Agua):(Casilla (Coordenada 3 1) Tocado):[]
       print t

main2 :: IO ()
main2 = do
        let b = (BarcoVertical (Coordenada 1 2) 2)
        let b2 = (BarcoVertical (Coordenada 5 1) 3)
        let f = b:b2:[]
        print f
        let t = realizarDisparo tableroInicial f f (Coordenada 3 3) -- probamos a realizar varios disparos
        print t
        let t2 = realizarDisparo t f f (Coordenada 5 1)
        print t2
        let t3 = realizarDisparo t2 f f (Coordenada 1 2)
        print t3
        let t4 = realizarDisparo t3 f f (Coordenada 1 3)
        print t4
        let t5 = realizarDisparo t4 f f ((posicionesBarco b)!!0)
        print t5

main3 :: IO ()
main3 = do
        let b = (BarcoVertical (Coordenada 1 2) 2)
        let b2 = (BarcoVertical (Coordenada 5 1) 3)
        let f = b:b2:[]
        print f
        let t = realizarDisparo tableroInicial f f (Coordenada 5 1)
        print t
        let t2 = realizarDisparo t f f (Coordenada 1 2)
        print t2
        let t3 = realizarDisparo t2 f f (Coordenada 1 3)
        print t3
