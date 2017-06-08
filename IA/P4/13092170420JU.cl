; JU2P8VGSLA
; Sheks

(defun mi-f-ev (estado) 
  (cond ((juego-terminado-p estado)  
         (- (get-pts (estado-lado-sgte-jugador estado))
            (get-pts (lado-contrario (estado-lado-sgte-jugador estado)))))
       ((estado-debe-pasar-turno estado) (+ (- 10) (get-fichas (estado-tablero estado) (estado-lado-sgte-jugador estado) 0) (get-fichas (estado-tablero estado) (estado-lado-sgte-jugador estado) 1)))
        (t (count-semillas (estado-tablero estado) 
                           (estado-lado-sgte-jugador estado)(lado-contrario (estado-lado-sgte-jugador estado))))))

(defun count-semillas (tablero lado lado-rival) 
  (- (* (+ (* 1 (get-fichas tablero lado 0))
        (* 2 (get-fichas tablero lado 1))
        (* 3 (get-fichas tablero lado 2))
        (* 5 (get-fichas tablero lado 3))
        (* 8 (get-fichas tablero lado 4))
        (* 11 (get-fichas tablero lado 5))) (get-pts lado))
     (* (+ (* 1 (get-fichas tablero lado-rival 0))
        (* 2 (get-fichas tablero lado-rival 1))
        (* 3 (get-fichas tablero lado-rival 2))
        (* 5 (get-fichas tablero lado-rival 3))
        (* 8 (get-fichas tablero lado-rival 4))
        (* 11 (get-fichas tablero lado-rival 5))) (get-pts lado-rival))))  