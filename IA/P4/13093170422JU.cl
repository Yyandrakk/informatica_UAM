; JU2P8VGSLA
; IRCLOVE

(defun mi-f-ev (estado) 
  (let* ((tab (estado-tablero estado))
         (jug (estado-lado-sgte-jugador estado))
         (cont (lado-contrario (estado-lado-sgte-jugador estado)))
         (sem-j (+ (cuenta-fichas tab jug 0) (get-fichas tab jug 6) ))
         (sem-c (+ (cuenta-fichas tab cont 0) (get-fichas tab cont 6)))
         (cap-m (n-vac estado jug))
         (cap-c (n-vac estado cont))
         (rob-c (n-robo estado cont))
         (rob-m (n-robo estado jug))
         (arob-c (n-antirobo estado cont))
         (arob-m (n-antirobo estado jug)) )
    
    (+
     (* (- sem-j sem-c)(- sem-j sem-c) ) 
     (* -3 (- cap-m cap-c))
     (* 3 (- rob-c rob-m))
     (* -7 (- arob-m arob-c)))))


(defun n-vac (estado jug) 
  (apply #'+ (mapcar #'(lambda (i)(if ( = i 0)
                                      1
                                    0
                                    )) (list-lado estado jug) ) ))

(defun n-robo (estado jug) 
  (apply #'+ (mapcar #'(lambda (i)(if (>= i 6)
                                      1
                                    0
                                    )) (list-lado estado jug) ) ))

(defun n-antirobo (estado jug) 
  (apply #'+ (mapcar #'(lambda (i)(if (< i 6)
                                      1
                                    0
                                    )) (list-lado estado jug) ) ))
