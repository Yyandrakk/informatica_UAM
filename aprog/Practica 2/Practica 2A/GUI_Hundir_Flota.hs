{-# LANGUAGE RankNTypes, FlexibleContexts, FlexibleInstances, TypeSynonymInstances, GADTs #-}
module GUI_Hundir_Flota where

import API_Hundir_Flota
import Text.Read (readMaybe)


{- Funcion IO que introduce una flota en la flotaInicial -}
introducirFlota :: IO Flota
introducirFlota = introducirFlota' flotaInicial

{- Introduce iterativamente los barcos en una flota hasta que se ocupe como maximo
    el 20% de las casillas
-}
introducirFlota' :: Flota -> IO Flota
introducirFlota' flota =
                    do
                       let restante = (0.2 * fromIntegral(dimension * dimension)) - fromIntegral(tamFlota flota)
                       putStrLn ("Introduce un barco (" ++ show restante ++ " casillas restantes) [  tipobarco (Coordenada x y) tam  ]")
                       barco <- getLine

                       case readMaybe barco of -- readMaybe para evitar manejo de excepciones explicito con barcos invalidos
                         Just b -> do
                           let flotaN = agregarBarco flota b
                           putStrLn ("Casillas ocupadas: " ++ show (tamFlota flotaN))
                           print flotaN
                           mostrarSeparador

                           if (restante - fromIntegral(tam b)) /= 0 -- comprobamos si queda espacio
                           then do
                             putStrLn "Pulsa s para introducir otro barco"
                             letra <- getChar

                             if letra == 's' then introducirFlota' flotaN
                             else return flotaN
                           else return flotaN

                         Nothing -> do
                           putStrLn "Barco invalido"
                           introducirFlota' flota


{- Funcion IO que realiza disparos y actualiza un tableroInicial -}
realizarDisparos:: Flota -> IO Tablero
realizarDisparos = realizarDisparos' tableroInicial

{- Realiza disparos iterativamente con coordenadas leidas de teclado hasta lograr hundir la flota -}
realizarDisparos' :: Tablero -> Flota -> IO Tablero
realizarDisparos' tablero flota =
                            do
                              putStrLn "Introduzca una coordenada ([   Coordenada x y   ])"
                              coord <- getLine

                              case readMaybe coord of -- readMaybe para evitar manejo de excepciones explicito con coordenadas invalidas
                                Just c -> do
                                    print tabN
                                    mostrarSeparador

                                    if haGanado tabN
                                    then return tabN
                                    else realizarDisparos' tabN flota
                                    where tabN = realizarDisparo tablero flota flota c

                                Nothing -> do
                                     putStrLn "Coordenada invalida"
                                     realizarDisparos' tablero flota


mostrarSeparador :: IO ()
mostrarSeparador = putStrLn $ replicate 20 '-'


{- Main principal de juego, a este se debe llamar para jugar -}
mainPlay :: IO ()
mainPlay = do putStrLn "Instruciones: Las coordenadas son X e Y de 1 a 5 inclusive, en el plano cartesiano [x, y]"
              putStrLn "Ahora va a introducir la  flota"
              mostrarSeparador
              flota <- introducirFlota
              mostrarSeparador
              print flota
              mostrarSeparador
              putStrLn "Ahora va a realizar disparos para hundir la flota"
              mostrarSeparador
              tab<-realizarDisparos flota
              putStrLn "Felicidades, ha ganado"
