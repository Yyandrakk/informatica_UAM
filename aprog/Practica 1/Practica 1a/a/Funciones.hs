module Funciones where

repetir :: a -> [a]
repetir x = x:repetir x

coger :: Integer -> [a] -> [a]
coger n _      | n <= 0 = []
coger _ []     = []
coger n (x:xs) = x : coger (n-1) xs
