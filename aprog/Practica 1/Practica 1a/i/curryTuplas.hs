module CurryTuplas where


curryTuplas :: ((a, b, c) -> d) -> a -> b -> c -> d
curryTuplas f x y z = f (x, y, z)

uncurryTuplas :: (a -> b -> c -> d) -> (a, b, c) -> d
uncurryTuplas f t = f (fst' t) (snd' t) (trd' t)
    where
      fst' (x, _, _) = x
      snd' (_, y, _) = y
      trd' (_, _, z) = z


prueba :: (Integer, Integer, Integer) -> Integer
prueba (a, b, c) = a + b + c

prueba' = curryTuplas prueba
prueba'' = uncurryTuplas prueba'

main :: IO ()
main = do
  print (prueba (1, 2, 3))
  print (prueba' 1 2 3)
  print (prueba'' (3, 4, 5))
