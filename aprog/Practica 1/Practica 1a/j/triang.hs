{-# LANGUAGE RankNTypes, FlexibleContexts, GADTs #-}

module Triang where

-- dado un x,
-- devuelve la lista de parejas (x, y) tal que y siempre es mayor que x
listaParejas :: Integer -> [(Integer, Integer)]
listaParejas x = map (\y -> (x,y)) [x..10]

-- dado una pareja (x, y) con y >= x
-- devuelve las trios (x, y, z) tal que z >= y
listaTrios :: (Integer, Integer) -> [(Integer, Integer, Integer)]
listaTrios (x, y) = map (\z -> (x, y, z)) [y..10]


-- triangulos :: [(Integer, Integer, Integer)]
-- triangulos = do
--    let l1 = concat (map listaParejas [1..10])
--    let l2 = concatMap listaTrios l1
--    let l3 = filter (\(x,y,z) -> (x+y+z == 24)) l2
--    filter (\(x,y,z) -> x^2 + y^2 == z^2) l3
triangulos :: [(Integer, Integer, Integer)]
triangulos = filter (\(x,y,z) -> x^2 + y^2 == z^2) l3
 where l1 = concat (map listaParejas [1..10])
       l2 = concatMap listaTrios l1
       l3 = filter (\(x,y,z) -> (x+y+z == 24)) l2
