; JU2P8VGSLA
; HojaDFirma

(defun mi-f-ev (estado) 
  (let* ((tab (estado-tablero estado))
         (jug (estado-lado-sgte-jugador estado))
         (cont (lado-contrario (estado-lado-sgte-jugador estado)))
         (sem-j (+ (cuenta-fichas tab jug 0) (get-fichas tab jug 6) ))
         (sem-c (+ (cuenta-fichas tab cont 0) (get-fichas tab cont 6))))
    
    (-
     (* (- sem-j sem-c)(- sem-j sem-c) ) 
     (* -3 (- 18 sem-j)) 
     (* 5 (get-fichas tab jug 5))
     (* -5 (get-fichas tab jug 0))
     (get-fichas tab jug 3))))

