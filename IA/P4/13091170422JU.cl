; JU2P8VGSLA
; DEPBATEia

(defun mi-f-ev (estado) 
  
  (let* ((tab (estado-tablero estado))
         (jug (estado-lado-sgte-jugador estado))
         (cont (lado-contrario (estado-lado-sgte-jugador estado)))
         (sem-j (+ (cuenta-fichas tab jug 0) (get-fichas tab jug 6) ))
         (sem-c (+ (cuenta-fichas tab cont 0) (get-fichas tab cont 6))))
    
    ; suma ponderada
    (+
     
     ; semillas
     (* (- sem-j sem-c) (- sem-j sem-c))
     
     ; cada uno de mis hoyos
     (* 0.1 (get-fichas tab jug 0))
     (* 0.2 (get-fichas tab jug 1))
     (* 0.5 (get-fichas tab jug 2))
     (* 0.75 (get-fichas tab jug 3)) 
     (* 1.25 (get-fichas tab jug 4)) 
     (* 1.75 (get-fichas tab jug 5)) 
     (* 1.5 (get-fichas tab jug 6))
     
     ; longitud de mis hoyos vacios
     (* 6 (length (remove-if-not #'(lambda (x) (= x 0)) (list-lado estado jug))))
     
     ; suma de mis hoyos
     (* 0.5  (suma-fila tab jug)))))
