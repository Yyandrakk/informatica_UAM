module Funciones where

repetir :: a -> [a]
repetir x = x:repetir x

coger :: Integer -> [a] -> [a]
coger n _      | n <= 0 = []
coger _ []     = []
coger n (x:xs) = x : coger (n-1) xs


coger' :: Int -> [a] -> [a]
coger' _ []     = []
coger' n (x:xs) = (if n > length (x:xs) then error "n > longitud lista" else
    (if n <= 0 then [] else
        (x : coger' (n-1) xs)))


-- coge una lista y un predicado y devuelve un booleano
comprobar :: Num a => [a] -> (a -> Bool) -> Bool
comprobar a p = all p a
