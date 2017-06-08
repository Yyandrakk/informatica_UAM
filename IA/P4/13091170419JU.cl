; JU2P8VGSLA
; JakePastor

(defun mi-f-ev (estado)
  
  (-  
   
   ; nuestro kalaha * nuestros puntos
   (* 
    (get-fichas (estado-tablero estado) (estado-lado-sgte-jugador estado) 6)
    (get-pts (estado-lado-sgte-jugador estado)))
   
   ; su kalaha * sus puntos
   (* 
    (get-fichas (estado-tablero estado) (lado-contrario (estado-lado-sgte-jugador estado)) 6)
    (get-pts (lado-contrario (estado-lado-sgte-jugador estado))))))