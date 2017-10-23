module Principal where
import Funciones

main :: IO()
main = do
    print ((coger 2 (repetir 3)) ++ [5,5])
    --print ((coger 2 repetir 3) ++ [5,5])
    print (coger 5 ([1,2,3,4] ++ repetir 5))
    print (coger 5 [1,2,3,4])
    --print (coger' 100 [1,2,3])
    print (comprobar [1..3] (\x -> 2*x==x+x))


    -- en la lambda la x infiere el tipo de la llamada a take (por lo que x es del tipo int)
    print (comprobar [1,2,3] (\x -> take x ['a'..'z'] == coger (toInteger x) ['a'..'z']))

    -- con fromIntegral se convierte x de Int a Integer y viceversa
    print (comprobar [11,22,33,44,1,3,2] (\x -> take x ['a'..'z'] == coger (fromIntegral x::Integer) ['a'..'z']))
    print (comprobar [9,8,7,6,5,6,71,2] (\x -> coger x ['a'..'z'] == take (fromIntegral x::Int) ['a'..'z']))
    print (comprobar [1,2,3,4,5] (\x -> coger x ['b'..'z'] == take (fromIntegral x::Int) ['a'..'z']))
