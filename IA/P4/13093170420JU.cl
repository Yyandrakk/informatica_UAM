; JU2P8VGSLA
; MuyDEP


(defun mi-f-ev (estado)
  (fichas-ponderadas (estado-tablero estado) (estado-lado-sgte-jugador estado) (lado-contrario (estado-lado-sgte-jugador estado))))

(defun fichas-ponderadas (tablero lado lado2)
  (+
   (* 2 (get-fichas tablero lado 3))
   (* 3 (get-fichas tablero lado 4))
   (* 4 (get-fichas tablero lado 5))
   (* 5 (get-fichas tablero lado 6))
   
   (* -2 (get-fichas tablero lado2 3))
   (* -3 (get-fichas tablero lado2 4))
   (* -4 (get-fichas tablero lado2 5))
   (* -5 (get-fichas tablero lado2 6))
   ))
