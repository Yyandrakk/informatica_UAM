
;; EJERCICIO 1 ;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; lp-rec-aux (x p)
;;; funcion auxiliar que suma todos los elementos de una lista elevados a p
;;;
;;; INPUT: x: vector, representado como una lista
;;; p: orden de la norma que se quiere calcular
;;;
;;; OUTPUT: real de la suma elevada a p
;;;
(defun lp-rec-aux (x p)
	(if (null x)
		0.0
	(+ (expt (abs (first x)) p) (lp-rec-aux (rest x) p))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; lp-rec (x p)
;;; Calcula la norma Lp de un vector de forma recursiva
;;;
;;; INPUT: x: vector, representado como una lista
;;; p: orden de la norma que se quiere calcular
;;;
;;; OUTPUT: norma Lp de x
;;;
(defun lp-rec (x p)
	(if (or (null x) (<= p 0))
		nil
 (expt (lp-rec-aux x p) (/ 1 p))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; lp-mapcar (x p)
;;; Calcula la norma Lp de un vector usando mapcar
;;;
;;; INPUT: x: vector, representado como una lista
;;; p: orden de la norma que se quiere calcular
;;;
;;; OUTPUT: norma Lp de x
;;;
(defun lp-mapcar (x p)
  (if (<= p 0)
  	nil
 (expt  (apply #'+ (mapcar #'(lambda (i)(expt (abs i) p)) x)) (/ 1 p))
))

;Ejemplos
; (lp-rec '(2 3 4 5) 0)
; NIL
; (lp-rec '(2 3 4 5) 5)
; 5,359978
; (lp-rec '(2 3 4 5) -1)
; NIL
; (lp-rec '() 2)
; NIL
; (lp-mapcar '(2 3 4 5) 0)
; NIL
; (lp-mapcar '(2 3 4 5) 5)
; 5,359978
; (lp-mapcar '(2 3 4 5) -1)
; NIL
; (lp-mapcar '() 2) ;NIL


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; l2-rec(x)
;;; Calcula la norma L2 de un vector de forma recursiva
;;;
;;; INPUT:   x: vector
;;;
;;; OUTPUT:  norma L2 de x
;;;
(defun l2-rec(x)
	(lp-rec x 2))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; l2-mapcar(x)
;;; Calcula la norma L2 de un vector usando mapcar
;;;
;;; INPUT:   x: vector
;;;
;;; OUTPUT:  norma L2 de x
;;;
(defun l2-mapcar(x)
	(lp-mapcar x 2))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 	l1-rec(x)
;;;	Calcula la norma L1 de un vector de	forma recursiva
;;;
;;;   INPUT:   x: vector
;;;
;;;   OUTPUT:  norma L1 de x
;;;
(defun l1-rec	(x)
  (lp-rec x 1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; l1-mapcar(x)
;;;	Calcula la norma L1 de un vector usando mapcar
;;;
;;;   INPUT:   x: vector
;
;;
;;;   OUTPUT:  norma L1 de x
;;;
(defun l1-mapcar(x)
  (lp-mapcar x 1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; nearest (lst-vectors vector fn-dist)
;;; Calcula de una lista de vectores el vector mas cercano a uno dado,
;;; usando la funcion de distancia especificada
;;;
;;; INPUT: lst-vectors: lista de vectores para los que calcular la distancia
;;; vector: vector referencia, representado como una lista
;;; fn-dist: referencia a funcion para medir distancias
;;;
;;; OUTPUT: vector de entre los de lst-vectors mas cercano al de referencia
;;;
(defun nearest (lst-vectors vector fn-dist)
  (if (or (null lst-vectors) (some #'null lst-vectors) (null vector))
   	nil
    (let ((vd(mapcar fn-dist (mapcar #'(lambda (xs) (mapcar #'- xs vector)) lst-vectors))))
     	(elt lst-vectors (position (apply #'min vd) vd)))
    ))

;Ejemplos
; (setf vectors '((0.1 0.1 0.1) (0.2 -0.1 -0.1)))
; (nearest vectors '(1.0 -2.0 3.0) #'l2-mapcar)
; (0.1 0.1 0.1)
; (nearest vectors '(1.0 -2.0 3.0) #'l1-rec)
; (0.2 -0.1 -0.1)
; (nearest vectors '() #'l1-rec)
; NIL
; (nearest '() '(1.0 -2.0 3.0) #'l1-rec)
; NIL
; (nearest '((1 2 3) ()) '(1.0 -2.0 3.0) #'l1-rec)
; NIL



;; EJERCICIO 2 ;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; secante (f tol-abs max-iter par-semillas)
;;;   Estima el cero de una funcion mediante el metodo de la secante
;;;
;;;   INPUT:      f:  funcion cuyo cero se desea encontrar
;;;          			tol-abs:  tolerancia para convergencia
;;;          			max-iter:  maximo numero de iteraciones
;;;    			 			par-semillas:  estimaciones iniciales del cero(x0 x1)
;;;
;;;   OUTPUT:  estimacion del cero de f, o NIL si no converge
;;;
(defun secante (f tol-abs max-iter par-semillas)

  (if (null par-semillas)
    nil
    (let ((xn1  (first (rest par-semillas)))
          (xn (first par-semillas)
              ))

      ; comprobamos si se acerca con el valor de tolerancia
      (if (< (abs (- xn1 (first par-semillas))) tol-abs)
        xn1
        (if (= max-iter 0)
          NIL
          (secante f tol-abs (- max-iter 1) (list xn1 ; si no hemos llegado al max de iteraciones, la llamamos sobre par-semillas incrementado
                                                  (-
                                                   xn1
                                                   (*
                                                    (funcall f xn1)
                                                    (/ (- xn1 xn) (- (funcall f xn1) (funcall f xn)))
                                                    )
                                                   )
                                                  )
                   )
          )
        )
      )
    )
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	un-cero-secante (f tol-abs max-iter	pares-semillas)
;;; 	Prueba con distintos pares de semillas iniciales hasta que
;;;   la secante converge
;;;
;;;   INPUT:        f:  funcion de la que se desea encontrar un cero
;;;           tol-abs:  tolerancia para convergencia
;;;          max-iter:	maximo numero de iteraciones
;;;    pares-semillas:  pares de semillas con las que invocar a secante
;;;
;;;   OUTPUT:  el primer cero de f que se encuentre, o NIL si se diverge
;;;       para todos los pares de semillas
;;;
(defun un-cero-secante (f	tol-abs	max-iter pares-semillas)

  (let ((sec (secante f tol-abs max-iter (first pares-semillas))))

    (if (null pares-semillas)
      NIL
      (if	(null sec)
        (un-cero-secante f tol-abs max-iter (rest pares-semillas))
        sec
        )
      )
    )
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	todos-ceros-secante (f tol-abs max-iter	pares-semillas)
;;;	Prueba con distintas pares de semillas iniciales y devuelve
;;;  las raices	encontradas por la secante para dichos pares
;;;
;;;  INPUT:        f:  funcion de la que se desea encontrar un cero
;;;           tol-abs:  tolerancia para convergencia
;;;          max-iter:  maximo numero de iteraciones
;;;    pares-semillas:  pares de semillas con las que invocar a secante
;;;
;;;   OUTPUT: todas las raices que se encuentren, o NIL si se diverge
;;;       para todos los pares de semillas
;;;
(defun todos-ceros-secante (f tol-abs	max-iter pares-semillas)

  (if (null pares-semillas)
    NIL
    (mapcar #' (lambda (sem) (secante f tol-abs max-iter sem)) pares-semillas)
    )
  )

;Ejemplos
; (setf tol 1e-6)
; (setf iters 50)
; (setf funcion (lambda (x) (+ (* x 3) (sin x) (-(exp x)))))
; (setf semillas1 '(0 1))
; (setf semillas2 '(3 5))

; (secante funcion tol iters '())
; NIL
; (secante funcion tol '1 semillas2)
; NIL
; (secante funcion tol iters semillas1)
; 0.3604217
; (secante funcion tol iters semillas2)
; 1.8900298

; (un-cero-secante funcion tol iters '())
; NIL
; (un-cero-secante funcion tol iters (list semillas1 semillas2))
; 0.3604217
; (un-cero-secante funcion tol iters (list semillas2 semillas1))
; 1.8900298
;(un-cero-secante funcion '25 iters (list semillas1 semillas2))
; 1

;(todos-ceros-secante funcion tol iters (list semillas1 semillas2))
; (0.3604217 1.8900298)
; (todos-ceros-secante funcion tol iters (list semillas2 semillas1))
; (1.8900298 0.3604217)
; (todos-ceros-secante funcion '1 iters (list semillas2 semillas1))
; (2.684089 0.47098958)


;; EJERCICIO 3 ;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 flatten-lst (lst)
;;;	 Aplana una lista que dentro tenga atomos u otras listas
;;;
;;;
;;;   INPUT:        lst:  lista a aplanar
;;;
;;;
;;;   OUTPUT: lista sin sublistas encadenadas con todos los atomos de lst
;;;
(defun flatten-lst (lst)
  (let (
        (prim (first lst)) (resto (rest lst))
                           )
    (if (null lst)
      nil
      (if (atom prim) ; si es un elemento solo (atomo y no lista)
        (cons prim (flatten-lst resto)) ; nueva lista con el atomo y el aplanamiento del resto
        (append (flatten-lst prim) (flatten-lst resto))) ; aplanamiento del primer elemento y del resto
      ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 combine-elt-lst (elt lst)
;;;	 Genera una lista de listas, donde cada lista esta formada
;;;  por la combinacion del elemento y un elemento de la lista
;;;
;;;
;;;   INPUT: elt: elemento a combinar
;;;		       lst:  lista de elementos a combinar
;;;
;;;   OUTPUT: lista de listas
;;;
(defun combine-elt-lst (elt lst)
  (if (null lst)
    nil
    (mapcar #'(lambda (x)(list elt x)) lst))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 combine-lst-lst (lst1 lst2)
;;;	 Genera una lista de listas, donde cada lista esta formada
;;;  por la combinacion del un elemento de la primera lista
;;;  y un elemento de la otra lista
;;;
;;;
;;;   INPUT: lst1: lista de elementos a combinar
;;;		       lst2:  lista de elementos a combinar
;;;
;;;   OUTPUT: lista de listas
;;;
(defun combine-lst-lst (lst1 lst2)
  (if (or (null lst1) (null lst2))
    nil
    (mapcan #'(lambda (x)(combine-elt-lst x lst2)) lst1 ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 combine-list-of-lsts (lstolsts)
;;;	 Genera una lista de listas, donde cada elemento de la sublistas,
;;;  se combina con los demas elementos de las siguientes listas
;;;
;;;
;;;   INPUT: lstolsts: Lista de listas
;;;
;;;
;;;   OUTPUT: lista de listas
;;;
(defun combine-list-of-lsts (lstolsts)
  (cond ((some #'null lstolsts) nil)
    ((null (rest lstolsts)) (mapcar #'list (first lstolsts)) ) ; en la ultima llamada recursiva crea una lista con cada elemento de la ultima lista
    (T (let ((prim (first lstolsts)))
         (mapcar #'(lambda (x) (cons (first x) (first (rest x))))
                 (combine-lst-lst prim (combine-list-of-lsts (rest lstolsts)))))
       )
    ))




;; EJERCICIO 4 ;;

(defconstant +bicond+ '<=>)
(defconstant +cond+ '=>)
(defconstant +and+ '^)
(defconstant +or+ 'v)
(defconstant +not+ '¨)

(defun truth-value-p (x) ; indica si x es de tipo booleano (T o F)
  (or (eql x t) (eql x nil)))

(defun unary-connector-p (x) ; indica si es conector de un argumento (solo la negacion)
  (eql x +not+))

(defun binnary-connector-p (x) ; indica si es conector binario
  (or (eql x +bicond+) (eql x +cond+)))

(defun n-ary-connector-p (x) ; indica si es conector n-ario
  (or (eql x +and+) (eql x +or+)))

(defun connector-p (x) ; indica si es conector logico
  (or (unary-connector-p x)
      (binnary-connector-p x)
      (n-ary-connector-p x)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 proposicion-p (expr)
;;;	 Decide si una proposicion esta bien formada en formato prefijo
;;;
;;;   INPUT: expr: expresion logica
;;;
;;;   OUTPUT: T o NIL
;;;
(defun proposicion-p (expr)
  (if (null expr)
    nil
    (if (and (atom expr) (connector-p expr))
      nil
      (if (atom expr)
        T
        (cond
          ; conector unario: un solo operando
          ((unary-connector-p (first expr))
           (if (null (third expr)) ; si no tiene segundo operando
             (proposicion-p (first (rest expr)))
             nil
             ))
          ; conector binario: dos operandos
          ((binnary-connector-p (first expr))
           (if (null (fourth expr)) ; si no tiene tercer operando
             (and (proposicion-p (first (rest expr))) (proposicion-p(first (rest (rest expr)))))
             nil
             ))
          ; conector n-ario: n operandos
          ((n-ary-connector-p (first expr))
           (every #'proposicion-p (rest expr)))
          ; default
          (T nil)
          )
        )
      )
    )
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 base-p (expr)
;;;	 Decide si una base esta bien formada en formato prefijo
;;;
;;;   INPUT: expr: lista de proposiciones logicas
;;;
;;;   OUTPUT: T o NIL
;;;
(defun base-p (expr)
  (if (atom expr)
    nil
   	(let ((res (mapcar #'(lambda (prop) (proposicion-p prop)) expr)))
      (every #'(lambda(elt) (equal elt t)) res)
      )
    )
  )

;Ejemplos
; (proposicion-p' A)
; T
; (proposicion-p	'(H <=> (¨ H)))
; NIL
; (proposicion-p	'(<=> H (¨ H)))
; T

; (base-p 'A)
; NIL
; (base-p '(A))
; T
; (base-p	'(<=> H (¨ H)))
; NIL
; (base-p	'((<=> H (¨ H))))
; T
; (base-p	'(H <=> (¨ H)))
; NIL
; (base-p' ((<=> A (¨ H)) (<=> P (^ A H)) (<=> H P)))
; T
; (base-p' ((<=> A (¨ H)) (<=> P (^ A H)) (H <=> P)))
; NIL



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 extrae-simbolos (kb)
;;;	 Extrae los simbolos de una base de conocimiento
;;;
;;;   INPUT: kb: base de conocimiento
;;;
;;;   OUTPUT: lista de simbolos
;;;
(defun extrae-simbolos (kb)
  (if (atom kb)
    nil
    (remove-duplicates (remove-if #'connector-p (flatten-lst kb))))
  )

;Ejemplos
; (extrae-simbolos '())
; NIL
; (extrae-simbolos '(A))
; (A)
; (extrae-simbolos '((v (¨ A) A B (¨ B))))
; (A B)
; extrae-simbolos '((=> A (¨ H)) (<=> P (^ A (¨ H))) (=> H P)))
; (A H P)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 genera-lista-interpretaciones (lst-simbolos)
;;;	 Genera todas las interpretaciones posibles
;;;
;;;   INPUT: lst-simbolos: lista de simbolos a intepretar
;;;
;;;   OUTPUT: lista de listas de interpretaciones
(defun genera-lista-interpretaciones (lst-simbolos)
  (unless (null lst-simbolos)
    nil
    (combine-list-of-lsts
     (mapcar #'(lambda (atomo-simb) (list (list atomo-simb 'T) (list atomo-simb 'NIL))) lst-simbolos)))
  )

;Ejemplos
; (genera-lista-interpretaciones nil)
; NIL
; (genera-lista-interpretaciones '(P))
; (((P T)) ((P NIL)))
; (genera-lista-interpretaciones '(P I L))
; (((P T) (I T) (L T)) ((P T) (I T) (L NIL)) ((P T) (I NIL) (L T))
;    ((P T) (I NIL) (L NIL)) ((P NIL) (I T) (L T)) ((P NIL) (I T) (L NIL))
;    ((P NIL) (I NIL) (L T)) ((P NIL) (I NIL) (L NIL)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 eval-prop (expr)
;;;	 Evalua el valor de una proposicion
;;;
;;;   INPUT: expr: expresion logica con Ts y NILs
;;;
;;;   OUTPUT: T o NIL
;;;
(defun eval-prop (expr)
  (if (atom expr)
    expr
    (cond
      ; conector unario: un solo operando
      ((unary-connector-p (first expr))
       (not (eval-prop (second expr)))
       )
      ; conector binario: dos operandos
      ((binnary-connector-p (first expr))
       (if (eql (first expr) +cond+)
         (or (not (eval-prop (second expr))) (eval-prop (third expr))) ; (p => q) es igual a (¨ p or q)
         (eql (eval-prop (second expr)) (eval-prop (third expr))) ; bicond
         ))
      ; conector n-ario: n operandos
      ((n-ary-connector-p (first expr))
       (if (eql (first expr) +and+)
         ; (print (rest expr))
         (every #'(lambda(x) (eql t (eval-prop x))) (rest expr)) ; and
         (some #'(lambda(x) (eql t (eval-prop x))) (rest expr)) ; or
         ))
      ; default
      (T nil)
      )
    )
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 interpretacion-modelo-p (interp kb)
;;;	 Comprueba si una interpretacion es modelo de una base de conocimiento
;;;
;;;   INPUT: interp: interpretacion
;;;          kb: base de conocimiento
;;;
;;;   OUTPUT: T o NIL
;;;
(defun interpretacion-modelo-p (interp kb)
  (if (null kb)
    nil
    (if (null interp)
      (every #'(lambda(x) (eql t x)) (mapcar #'eval-prop kb))
      (let* (
             (prop (first interp))
             (sust (subst (second prop) (first prop) kb)) ; sust simb por t nil
             )
        (interpretacion-modelo-p (rest interp) sust) ; itero hasta que se acabe interp
        )
      )
    )
  )

;Ejemplos
; (eval-prop '(v T nil))
; T
; (eval-prop '(<=> T T))
; T

; (interpretacion-modelo-p '() '())
; NIL
; (interpretacion-modelo-p' ((A nil) (P nil) (H t))'((<=> A (¨ H)) (<=> P (^ A H))(=> H P)))
; NIL
; (interpretacion-modelo-p' ((A t) (P nil) (H nil))'((<=> A (¨ H)) (<=> P (^ A H))(=> H P)))
; T



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 encuentra-modelos (kb)
;;;	 Busca todas las interpretaciones que son modelo de la base de
;;;   conocimiento
;;;
;;;   INPUT: kb: base de conocimiento
;;;
;;;   OUTPUT: lista de modelos
;;;
(defun encuentra-modelos (kb)
  (if (some #'null kb)
    nil
    (let* ((l-simb (extrae-simbolos kb)) ; conseguimos todos los simbolos
           (l-inter (genera-lista-interpretaciones l-simb))) ; conseguimos todas las combinaciones posibles
      (mapcan #'(lambda(x) (if (interpretacion-modelo-p x kb)
                             (list x)
                             nil
                             )) l-inter))
    ))

;Ejemplos:
; (encuentra-modelos '((=> A (¨ H)) (<=> P (^ A H)) (=> H P)))
; (((A T) (P NIL) (H NIL)) ((A NIL) (P NIL) (H NIL)))
; (encuentra-modelos '((^ A B) (=> A (¨ B))))
; NIL



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 consecuencia-p (prop kb)
;;;	 Comprueba si una proposicion es consecuencia logica de una
;;;  base de conocimiento (prop es consecuencia logica de kb si al incluir
;;;  prop en kb se siguen cumpliendo todos los modelos de kb)
;;;
;;;   INPUT: prop: nueva proposicion
;;;          kb: base de conocimiento
;;;
;;;   OUTPUT: T o NIL
(defun consecuencia-p (prop kb)
  (if (atom prop)
    ; si es un atomo suelto lo convertimos en lista
    (consecuencia-p (list prop) kb)
    ; si es una lista suelta lo convertimos en lista de lista
    (if (atom (first kb))
      (consecuencia-p prop (list kb))
      ; si las dos listas son la misma, prop es consecuencia-p de kb
      (let ( (new-kb (append (list prop) kb )) )
        (equal (encuentra-modelos kb) (encuentra-modelos new-kb))
        )
      )
    )
  )

;Ejemplos:
; (consecuencia-p 'A '(A))
; T
; (consecuencia-p 'A '(¨ A))
; NIL
; (consecuencia-p '(¨ H) '((=> A (¨ H)) (<=> P (^ A H)) (=> H P)))
; T
; (consecuencia-p '(¨ P) '((=> A (¨ H)) (<=> P (^ A H)) (=> H P)))
; T
; (consecuencia-p '(^ (¨ H) (¨ P)) '((=> A (¨ H)) (<=> P (^ A H)) (=> H P)))
; T
; (consecuencia-p '(^ A (¨ H) (¨ P)) '((=> A (¨ H)) (<=> P (^ A H)) (=> H P)))
; NIL





;; EJERCICIO 5 ;;

;5.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 bfs (end queue net)
;;;	 Algoritmo busqueda en anchura con busqueda en grafo
;;;
;;;   INPUT:        end:  nodo final
;;;                 queue: Lista que contiene la lista con el nodo inicial
;;;                 net: grafo
;;;
;;;   OUTPUT: Si termina con exito lista desde el inicial al objectivo, si no nil
;;;
(defun bfs (end queue net) ;;Se le pasan 3 argmentos, el final, la cola con el nodo inicial, y el grafo
  (if (null queue) nil ;Si la cola esta vacia no tendriamos donde empezar por tanto devuelve nil
    (let ((path (car queue)))  ;coje la primera lista de la cola (path)
      (let ((node (car path)))  ;coje el nodo inicial de path
        (if (eql node end) (reverse path) ;Comprueba si es el nodo final, si es devuelve la ruta del nodo inicial a el, por eso el reverse
          (bfs end (append  ;Si no, llamada recursiva, pasandole el final,
                            (cdr queue)
                            (new-paths path node net));La union del resto de la cola (puede estar vacia) y la expansion de ese nodo
               net))))));Y el grafo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 new-paths (path node net)
;;;	 Explora el nodo
;;;
;;;   INPUT:        path: camino
;;;                 node: nodo a explorar
;;;                 net: grafo
;;;
;;;   OUTPUT: lista de nodos a explorar
;;;
(defun new-paths (path node net);le pasa la lista del nodo y de donde viene, el nodo, y el grafo
  (mapcar #'(lambda(n);(ver primero el ultimo) a los sucesores les a√±ade la ruta que es el nodo padre, el padre del padre, etc hasta el inicial
                   (cons n path))
          (cdr (assoc node net))));Con assoc busca en el grafo al nodo y sus sucesores, y coger los sucesores
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;5.5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 shortest-path (start end net)
;;;	 Busqueda de camino mas corto
;;;
;;;   INPUT:        start: nodo desde que se empieza
;;;                 end: nodo final
;;;                 net: grafo
;;;
;;;   OUTPUT: el camino o nil si no lo encuentra
;;;
(defun shortest-path (start end net)
  (bfs end (list (list start)) net))

;;5.6
;;(shortest-path 'a 'f '((a d) (b d f) (c e) (d f) (e b f) (f)))
;;  0: (SHORTEST-PATH A F ((A D) (B D F) (C E) (D F) (E B F) (F)))
;;    1: (BFS F ((A)) ((A D) (B D F) (C E) (D F) (E B F) (F)))
;;      2: (NEW-PATHS (A) A ((A D) (B D F) (C E) (D F) (E B F) (F)))
;;      2: NEW-PATHS returned ((D A))
;;      2: (BFS F ((D A)) ((A D) (B D F) (C E) (D F) (E B F) (F)))
;;        3: (NEW-PATHS (D A) D ((A D) (B D F) (C E) (D F) (E B F) (F)))
;;        3: NEW-PATHS returned ((F D A))
;;        3: (BFS F ((F D A)) ((A D) (B D F) (C E) (D F) (E B F) (F)))
;;        3: BFS returned (A D F)
;;      2: BFS returned (A D F)
;;    1: BFS returned (A D F)
;;  0: SHORTEST-PATH returned (A D F)
;;(A D F)



;5.8
;Recursion infinita
;(shortest-path 'a 'c '((a b) (b a) (c a b)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 bfs-improved (end queue visto net)
;;;	 Algoritmo busqueda en anchura con busqueda en grafo
;;;
;;;   INPUT:        end:  nodo final
;;;                 queue: Lista que contiene la lista con el nodo inicial
;;;                 visto: lista donde se guardan los nodos visitados
;;;                 net: grafo
;;;
;;;   OUTPUT: lista sin sublistas encadenadas con todos los atomos de lst
;;;
(defun bfs-improved (end queue visto net) ;;Se le pasan 3 argumentos, el final, la cola con el nodo inicial, y el grafo
  (if (null queue) nil ;Si la cola esta vacia no tendriamos donde empezar por tanto devuelve nil
    (let ((path (car queue)))  ;coge la primera lista de la cola (path)
      (let ((node (car path)))  ;coge el nodo inicial de path
        (if (eql node end) (reverse path) ;Comprueba si es el nodo final, si es devuelve la ruta del nodo inicial a el, por eso el reverse
          (when (null (member node visto)) (bfs-improved end (append  ;Si no, llamada recursiva, pasandole el final,
                (cdr queue)
                (new-paths path node net)) (cons node visto);La union del resto de la cola (puede estar vacia) y la expansion de ese nodo
              net)))))));Y el grafo

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	 shortest-path-improved (end queue net)
;;;	 Busqueda de camino mas corto sin repeticiones
;;;
;;;   INPUT:        end: nodo final
;;;                 queue: Lista que contiene la lista con el nodo inicial
;;;                 net: grafo
;;;
;;;   OUTPUT: el camino o nil si no lo encuentra
;;;
(defun shortest-path-improved (end queue net)
  (bfs-improved end queue '() net))

;(shortest-path-improved 'a '((c)) '((a b) (b a) (c a b))) ;(C A)

;5.7
;(setf grafo '((C A G) (A B C D E) (B A D E F) (D A B G H) (E A B G H) (F B H) (G C D E H) (H D E F G)))
;(shortest-path 'F 'C grafo)

;;(shortest-path 'F 'C grafo)
;;  0: (SHORTEST-PATH F C
;                    ((C A G) (A B C D E) (B A D E F) (D A B G H) (E A B G H)
;                     (F B H) (G C D E H) (H D E F G)))
;   1: (BFS C ((F))
;            ((C A G) (A B C D E) (B A D E F) (D A B G H) (E A B G H) (F B H)
;             (G C D E H) (H D E F G)))
;      2: (NEW-PATHS (F) F
;                    ((C A G) (A B C D E) (B A D E F) (D A B G H) (E A B G H)
;                     (F B H) (G C D E H) (H D E F G)))
;      2: NEW-PATHS returned ((B F) (H F))
;      2: (BFS C ((B F) (H F))
;               ((C A G) (A B C D E) (B A D E F) (D A B G H) (E A B G H) (F B H)
;                (G C D E H) (H D E F G)))
;         3: (NEW-PATHS (B F) B
;                       ((C A G) (A B C D E) (B A D E F) (D A B G H) (E A B G H)
;                        (F B H) (G C D E H) (H D E F G)))
;         3: NEW-PATHS returned ((A B F) (D B F) (E B F) (F B F))
;         3: (BFS C ((H F) (A B F) (D B F) (E B F) (F B F))
;                 ((C A G) (A B C D E) (B A D E F) (D A B G H) (E A B G H)
;                  (F B H) (G C D E H) (H D E F G)))
;           4: (NEW-PATHS (H F) H
;                         ((C A G) (A B C D E) (B A D E F) (D A B G H)
;                          (E A B G H) (F B H) (G C D E H) (H D E F G)))
;           4: NEW-PATHS returned ((D H F) (E H F) (F H F) (G H F))
;           4: (BFS C
;                   ((A B F) (D B F) (E B F) (F B F) (D H F) (E H F) (F H F)
;                    (G H F))
;                   ((C A G) (A B C D E) (B A D E F) (D A B G H) (E A B G H)
;                    (F B H) (G C D E H) (H D E F G)))
;             5: (NEW-PATHS (A B F) A
;                           ((C A G) (A B C D E) (B A D E F) (D A B G H)
;                            (E A B G H) (F B H) (G C D E H) (H D E F G)))
;             5: NEW-PATHS returned ((B A B F) (C A B F) (D A B F) (E A B F))
;             5: (BFS C
;                     ((D B F) (E B F) (F B F) (D H F) (E H F) (F H F) (G H F)
;                      (B A B F) (C A B F) (D A B F) (E A B F))
;                     ((C A G) (A B C D E) (B A D E F) (D A B G H) (E A B G H)
;                      (F B H) (G C D E H) (H D E F G)))
;               6: (NEW-PATHS (D B F) D
;                             ((C A G) (A B C D E) (B A D E F) (D A B G H)
;                              (E A B G H) (F B H) (G C D E H) (H D E F G)))
;               6: NEW-PATHS returned ((A D B F) (B D B F) (G D B F) (H D B F))
;               6: (BFS C
;                       ((E B F) (F B F) (D H F) (E H F) (F H F) (G H F)
;                        (B A B F) (C A B F) (D A B F) (E A B F) (A D B F)
;                        (B D B F) (G D B F) (H D B F))
;                       ((C A G) (A B C D E) (B A D E F) (D A B G H) (E A B G H)
;                        (F B H) (G C D E H) (H D E F G)))
;                 7: (NEW-PATHS (E B F) E
;                               ((C A G) (A B C D E) (B A D E F) (D A B G H)
;                                (E A B G H) (F B H) (G C D E H) (H D E F G)))
;                 7: NEW-PATHS returned ((A E B F) (B E B F) (G E B F) (H E B F))
;                 7: (BFS C
;                         ((F B F) (D H F) (E H F) (F H F) (G H F) (B A B F)
;                          (C A B F) (D A B F) (E A B F) (A D B F) (B D B F)
;                          (G D B F) (H D B F) (A E B F) (B E B F) (G E B F)
;                          (H E B F))
;                         ((C A G) (A B C D E) (B A D E F) (D A B G H)
;                          (E A B G H) (F B H) (G C D E H) (H D E F G)))
;                   8: (NEW-PATHS (F B F) F
;                                 ((C A G) (A B C D E) (B A D E F) (D A B G H)
;                                  (E A B G H) (F B H) (G C D E H) (H D E F G)))
;                   8: NEW-PATHS returned ((B F B F) (H F B F))
;                   8: (BFS C
;                           ((D H F) (E H F) (F H F) (G H F) (B A B F) (C A B F)
;                            (D A B F) (E A B F) (A D B F) (B D B F) (G D B F)
;                            (H D B F) (A E B F) (B E B F) (G E B F) (H E B F)
;                            (B F B F) (H F B F))
;                           ((C A G) (A B C D E) (B A D E F) (D A B G H)
;                            (E A B G H) (F B H) (G C D E H) (H D E F G)))
;                     9: (NEW-PATHS (D H F) D
;                                   ((C A G) (A B C D E) (B A D E F) (D A B G H)
;                                    (E A B G H) (F B H) (G C D E H) (H D E F G)))
;                     9: NEW-PATHS returned
;                          ((A D H F) (B D H F) (G D H F) (H D H F))
;                     9: (BFS C
;                             ((E H F) (F H F) (G H F) (B A B F) (C A B F)
;                              (D A B F) (E A B F) (A D B F) (B D B F) (G D B F)
;                              (H D B F) (A E B F) (B E B F) (G E B F) (H E B F)
;                              (B F B F) (H F B F) (A D H F) (B D H F) (G D H F)
;                              (H D H F))
;                             ((C A G) (A B C D E) (B A D E F) (D A B G H)
;                              (E A B G H) (F B H) (G C D E H) (H D E F G)))
;                       10: (NEW-PATHS (E H F) E
;                                      ((C A G) (A B C D E) (B A D E F)
;                                       (D A B G H) (E A B G H) (F B H)
;                                       (G C D E H) (H D E F G)))
;                       10: NEW-PATHS returned
;                             ((A E H F) (B E H F) (G E H F) (H E H F))
;                       10: (BFS C
;                                ((F H F) (G H F) (B A B F) (C A B F) (D A B F)
;                                 (E A B F) (A D B F) (B D B F) (G D B F)
;                                 (H D B F) (A E B F) (B E B F) (G E B F)
;                                 (H E B F) (B F B F) (H F B F) (A D H F)
;                                 (B D H F) (G D H F) (H D H F) (A E H F)
;                                 (B E H F) (G E H F) (H E H F))
;                                ((C A G) (A B C D E) (B A D E F) (D A B G H)
;                                 (E A B G H) (F B H) (G C D E H) (H D E F G)))
;                         11: (NEW-PATHS (F H F) F
;                                        ((C A G) (A B C D E) (B A D E F)
;                                         (D A B G H) (E A B G H) (F B H)
;                                         (G C D E H) (H D E F G)))
;                         11: NEW-PATHS returned ((B F H F) (H F H F))
;                         11: (BFS C
;                                  ((G H F) (B A B F) (C A B F) (D A B F)
;                                   (E A B F) (A D B F) (B D B F) (G D B F)
;                                   (H D B F) (A E B F) (B E B F) (G E B F)
;                                   (H E B F) (B F B F) (H F B F) (A D H F)
;                                   (B D H F) (G D H F) (H D H F) (A E H F)
;                                   (B E H F) (G E H F) (H E H F) (B F H F)
;                                   (H F H F))
;                                  ((C A G) (A B C D E) (B A D E F) (D A B G H)
;                                   (E A B G H) (F B H) (G C D E H) (H D E F G)))
;                           12: (NEW-PATHS (G H F) G
;                                          ((C A G) (A B C D E) (B A D E F)
;                                           (D A B G H) (E A B G H) (F B H)
;                                           (G C D E H) (H D E F G)))
;                           12: NEW-PATHS returned
;                                 ((C G H F) (D G H F) (E G H F) (H G H F))
;                           12: (BFS C
;                                    ((B A B F) (C A B F) (D A B F) (E A B F)
;                                     (A D B F) (B D B F) (G D B F) (H D B F)
;                                     (A E B F) (B E B F) (G E B F) (H E B F)
;                                     (B F B F) (H F B F) (A D H F) (B D H F)
;                                     (G D H F) (H D H F) (A E H F) (B E H F)
;                                     (G E H F) (H E H F) (B F H F) (H F H F)
;                                     (C G H F) (D G H F) (E G H F) (H G H F))
;                                    ((C A G) (A B C D E) (B A D E F) (D A B G H)
;                                     (E A B G H) (F B H) (G C D E H)
;                                     (H D E F G)))
;                             13: (NEW-PATHS (B A B F) B
;                                            ((C A G) (A B C D E) (B A D E F)
;                                             (D A B G H) (E A B G H) (F B H)
;                                             (G C D E H) (H D E F G)))
;                             13: NEW-PATHS returned
;                                   ((A B A B F) (D B A B F) (E B A B F)
;                                    (F B A B F))
;                             13: (BFS C
;                                      ((C A B F) (D A B F) (E A B F) (A D B F)
;                                       (B D B F) (G D B F) (H D B F) (A E B F)
;                                       (B E B F) (G E B F) (H E B F) (B F B F)
;                                       (H F B F) (A D H F) (B D H F) (G D H F)
;                                       (H D H F) (A E H F) (B E H F) (G E H F)
;                                       (H E H F) (B F H F) (H F H F) (C G H F)
;                                       (D G H F) (E G H F) (H G H F) (A B A B F)
;                                       (D B A B F) (E B A B F) (F B A B F))
;                                      ((C A G) (A B C D E) (B A D E F)
;                                       (D A B G H) (E A B G H) (F B H)
;                                       (G C D E H) (H D E F G)))
;                             13: BFS returned (F B A C)
;                           12: BFS returned (F B A C)
;                         11: BFS returned (F B A C)
;                       10: BFS returned (F B A C)
;                     9: BFS returned (F B A C)
;                   8: BFS returned (F B A C)
;                 7: BFS returned (F B A C)
;               6: BFS returned (F B A C)
;             5: BFS returned (F B A C)
;           4: BFS returned (F B A C)
;         3: BFS returned (F B A C)
;       2: BFS returned (F B A C)
;     1: BFS returned (F B A C)
;   0: SHORTEST-PATH returned (F B A C)
; (F B A C)