;;; Funcion que inicia la busqueda y devuelve el siguiente estado elegido por el jugador que
;;; tiene el turno, segun algoritmo negamax
;;; RECIBE:   estado,
;;;           profundidad-max    : limite de profundidad
;;;           f-eval             : funcion de evaluacion
;;; DEVUELVE: estado siguiente del juego
;;; ------------------------------------------------------------------------------------------
(defun negamax-a-b (estado profundidad-max f-eval)
(let* ((oldverb *verb*)
       (*verb* (if *debug-nmx* *verb* nil))
       (estado2 (negamax-a-b-aux estado 0 t profundidad-max f-eval +min-val+ +max-val+))
       (*verb* oldverb))
  estado2))

  
;;; ------------------------------------------------------------------------------------------
;;; Funcion auxiliar negamax-a-b-aux
;;; RECIBE:   estado, profundidad-actual,
;;;           devolver-movimiento: flag que indica si devolver un estado (llamada raiz) o un valor numerico (resto de llamadas)
;;;           profundidad-max    : limite de profundidad
;;;           f-eval             : funcion de evaluacion
;;;           alfa: valor de alfa
;;;           beta: valor de beta
;;;           signo: turno del jugador
;;; DEVUELVE: valor negamax en todos los niveles de profundidad, excepto en el nivel 0 que devuelve el estado del juego tras el
;;;           movimiento que escoge realizar
;;; ------------------------------------------------------------------------------------------

(defun negamax-a-b-aux (estado profundidad devolver-movimiento profundidad-max f-eval alfa beta)
  (cond ((>= profundidad profundidad-max)
         (unless devolver-movimiento (funcall f-eval estado)))
        (t
         (let ((sucesores (generar-sucesores estado profundidad))
               (mejor-valor +min-val+)
               (mejor-sucesor nil))
           (cond ((null sucesores)
                  (unless devolver-movimiento (funcall f-eval estado)))
                 (t
                  (loop for sucesor in sucesores do
                        (let* ((result-sucesor (- (negamax-a-b-aux sucesor (1+ profundidad) nil profundidad-max f-eval alfa beta))))
                          (when (> result-sucesor mejor-valor)
                            (setq mejor-valor result-sucesor)
                            (setq mejor-sucesor  sucesor))
                          (when t
                            (setq alfa (max alfa result-sucesor)))
                          (if (>= alfa beta)
                              (if devolver-movimiento (return mejor-sucesor) (return mejor-valor)))))                
                  (if  devolver-movimiento mejor-sucesor mejor-valor)))))))
