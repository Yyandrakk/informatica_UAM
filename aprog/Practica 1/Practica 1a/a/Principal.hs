module Principal where
import Funciones

main = do 
    print ((coger 2 (repetir 3)) ++ [5,5])
    --print ((coger 2 repetir 3) ++ [5,5])
    print (coger 5 ([1,2,3,4] ++ repetir 5))
    print (coger 5 [1,2,3,4])
    