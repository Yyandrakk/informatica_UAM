module Apartadod where
repetir::a->[a]
repetir x = x:repeat x

coger:: Integer -> [a]->[a]
coger n _ | n <= 0=[]
coger _ [] = []
coger n (x:xs) = x:take (fromInteger n -1) xs
