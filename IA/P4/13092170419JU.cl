; JU2P8VGSLA
; MasterDeIA

(defun mi-f-ev (estado)
  (-   
   (apply #'+ (fichas-ponderadas (estado-tablero estado) (estado-lado-sgte-jugador estado)))
   (apply #'+  (fichas-ponderadas (estado-tablero estado) (lado-contrario (estado-lado-sgte-jugador estado)) )
   )))


(defun fichas-ponderadas (tablero lado) 
  (mapcar  #'*
    (mapcar (lambda (x) (get-fichas tablero lado x))
      (posiciones-con-fichas-lado tablero lado 0))
    '(1 2 3 4 5 6 7)))