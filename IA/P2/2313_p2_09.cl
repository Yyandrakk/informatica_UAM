;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Problem definition
;;
(defstruct problem
  states; List of states
  initial-state; Initial state
  f-goal-test; reference to a function that determines whether; a state fulfills the goal
  f-h; reference to a function that evaluates to the ; value of the heuristic of a state
  operators); list of operators (references to functions); to generate succesors

;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;Node in search tree
;;
(defstruct node
  state; state label
  parent; parent node
  action; action that generated the current node from its parent
  (depth 0); depth in the search tree
  (g 0); cost of the path from the initial state to this node
  (h 0); value of the heuristic
  (f 0)); g + h

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;Actions
;;
(defstruct action
  name; Name of the operator that generated the action
  origin; State on which the action is applied
  final; State that results from the application of the action
  cost ); Cost of the action

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;Search strategies
;;
(defstruct strategy
  name; Name of the search strategy
  node-compare-p); boolean comparison

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DATOS
(setf *planets* '(Avalon Davion Katril Kentares Mallory Proserpina Sirtis))
(setf *planet-origin* 'Kentares)
(setf *planets-destination* '(Sirtis))
(setf *white-holes*
  '((Avalon Mallory 2) (Avalon Proserpina 12) (Davion Proserpina 14) (Davion Sirtis 1)
    (Katril Davion 2) (Katril Mallory 6) (Kentares Avalon 3) (Kentares Proserpina 10)
    (Kentares Katril 12) (Mallory Katril 6) (Mallory Proserpina 17) (Proserpina Sirtis 10)
    (Proserpina Avalon 12) (Proserpina Davion 14) (Proserpina Mallory 17) (Sirtis Davion 1) (Sirtis Proserpina 10)))

(setf *worm-holes*
  '((Avalon Kentares 4) (Avalon Mallory 7)
    (Davion Katril 1) (Davion Sirtis 8)
    (Katril Davion 1) (Katril Mallory 5) (Katril Sirtis 10)
    (Kentares Avalon 4) (Kentares Proserpina 21) (Mallory Avalon 7) (Mallory Katril 5) (Mallory Proserpina 16)
    (Proserpina Sirtis 7) (Proserpina Mallory 16) (Proserpina Kentares 21)
    (Sirtis Proserpina 7) (Sirtis Davion 8) (Sirtis Katril 10)))

(setf *sensors* '((Avalon 5) (Davion 1) (Katril 3) (Kentares 4) (Mallory 7) (Proserpina 4) (Sirtis 0)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; f-goal-test-galaxy (state planets-destination)
;;; Funcion que comprueba si es un planeta destino
;;;
;;; INPUT: state: Planeta actual
;;; planets-destination: Planetas destino
;;;
;;; OUTPUT: T si esta en la lista, nil en caso contrario
;;;
;;; Ejemplos
; (f-goal-test-galaxy 'Sirtis *planets-destination*) ;-> T (o equivalente)
; (f-goal-test-galaxy 'Avalon *planets-destination*) ;-> NIL
; (f-goal-test-galaxy 'Urano *planets-destination*) ;-> NIL
(defun f-goal-test-galaxy (state planets-destination)
  (when (and planets-destination (atom state))
    (not (null (member state planets-destination)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; f-h-galaxy (state sensors)
;;; Funcion que devuelve la heuristica de un planeta
;;;
;;; INPUT: state: Planeta
;;; sensors: lista de heuristicas al destino
;;;
;;; OUTPUT: valor de la heuristica si tiene, NIL si no
;;;
;;; Ejemplos
; (f-h-galaxy 'Sirtis *sensors*) ;-> 0
; (f-h-galaxy 'Avalon *sensors*) ;-> 5
(defun f-h-galaxy (state sensors)
  (when (and (atom state) sensors)
    (second (assoc state sensors))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; navigate-worm-hole (state worm-holes)
;;; Devuelve una lista de acciones posibles desde el estado
;;; actual
;;;
;;; INPUT: state: Planeta actual
;;; worm-holes: Lista de costes entre pares de planetas
;;;
;;; OUTPUT: lista de estructuras de accion o NIL
;;;
;;; Ejemplos
; (navigate-worm-hole 'Katril *worm-holes*) ;->
;    (#S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN KATRIL :FINAL DAVION :COST 1)
;    #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN KATRIL :FINAL MALLORY :COST 5)
;    #S(ACTION :NAME NAVIGATE-WORM-HOLE :ORIGIN KATRIL :FINAL SIRTIS :COST 10))
(defun navigate-worm-hole (state worm-holes)
  (when (and worm-holes (atom state))
    (mapcan #'(lambda (x) (when (eql state (first x))
                            (list (make-action :name 'navigate-worm-hole :origin state :final (second x) :cost (third x))))) worm-holes)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; navigate-white-hole (state white-holes)
;;; Devuelve una lista de acciones posibles desde el estado
;;; actual
;;;
;;; INPUT: state: Planeta actual
;;; white-holes: Lista de costes entre pares de planetas
;;;
;;; OUTPUT: lista de estructuras de accion o NIL
;;;
;;; Ejemplos
; (navigate-white-hole 'Urano *white-holes*) ;-> NIL
(defun navigate-white-hole (state white-holes)
  (when (and white-holes (atom state))
    (mapcan #'(lambda (x) (when (eql state (first x))
                            (list (make-action :name 'navigate-white-hole :origin state :final (second x) :cost (third x))))) white-holes)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defun node-f-<= (node-1 node-2)
;;; Compara dos nodos a partir de su funcion de evaluacion
;;;
;;; INPUT: node-1, node-2
;;;
;;; OUTPUT: T si el primero es mayor, NIL en caso contrario
;;;
;;; Ejemplos
; (setf node-00 (make-node :state 'Proserpina :depth 12 :g 10 :f 20) )
; (setf node-aux01
; (make-node :state 'Proserpina :depth 13 :g 10 :f 20) )
; (setf node-aux02
; (make-node :state 'Proserpina :depth 12 :g 5 :f 10) )
; (node-f-<= node-00 node-aux01) ;T
; (node-f-<= node-00 node-aux02) ;NIL
; (node-f-<= node-aux01 node-00) ;NIL
; (node-f-<= node-aux02 node-00) ;T
(defun node-f-<= (node-1 node-2)
  (or (< (node-f node-1) (node-f node-2)) (and (=(node-f node-1)(node-f node-2)) (<= (node-depth node-1)(node-depth node-2)))))

; Estrategia a estrella
(setf *A-star*
  (make-strategy
   :name 'A-star
   :node-compare-p 'node-f-<=))

; Estrategia coste uniforme
(setf *uniform-cost*
  (make-strategy
   :name 'uniform-cost
   :node-compare-p 'node-g-<=))
(defun node-g-<= (node-1 node-2)
  (<= (node-g node-1)
      (node-g node-2)))

; Problema tipo
(setf *galaxy-M35*
  (make-problem
   :states *planets*
   :initial-state *planet-origin*
   :f-goal-test #'(lambda (state) (f-goal-test-galaxy state *planets-destination*))
   :f-h #'(lambda (state) (f-h-galaxy state *sensors*))
   :operators (list #'(lambda (state) (navigate-white-hole state *white-holes*))  #'(lambda (state) (navigate-worm-hole state *worm-holes*))  )))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; expand-node (node problem)
;;; Expande un nodo.
;;;
;;; INPUT: node: Nodo a expandir.
;;;       problem: Problema que contiene los demas nodos visitables.
;;;
;;; OUTPUT: Lista de nodos expandidos.
;;;
;;; Ejemplos
; (expand-node node-00 *galaxy-M35*)
(defun expand-node (node problem)
  (mapcar #'(lambda (action) (make-node :state (action-final action)
                                        :parent node
                                        :action action
                                        :depth (+ (node-depth node) 1)
                                        :g (+ (node-g node) (action-cost action))
                                        :h (funcall (problem-f-h problem) (action-final action))
                                        :f (+ (+ (node-g node) (action-cost action))
                                              (if (null (funcall (problem-f-h problem) (action-final action)))
                                                  0
                                                (funcall (problem-f-h problem) (action-final action))
                                                ))) )
    (append (funcall (first (problem-operators problem)) (node-state node)) (funcall (second (problem-operators problem)) (node-state node)))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; insert-nodes-strategy (nodes lst-nodes strategy)
;;; Inserta una lista de nodos en otra segun la estrategia.
;;;
;;; INPUT: nodes: Lista a insertar.
;;;        lst-nodes: Lista en la que insertar, TIENE que estar ordenada.
;;;        strategy: Estrategia de comparacion de nodos.
;;;
;;; OUTPUT: Lista ordenada.
;;;
;;; Ejemplos
; (setf lst-nodes-00 (expand-node node-00 *galaxy-M35*))
; (setf node-01 (make-node :state 'Avalon :depth 0 :g 0 :f 0) )
; (setf node-02 (make-node :state 'Kentares :depth 2 :g 50 :f 50) )
; (print(insert-nodes-strategy (list node-00 node-01 node-02) lst-nodes-00 *uniform-cost*))
(defun insert-nodes-strategy (nodes lst-nodes strategy)
  (sort (append nodes lst-nodes) (strategy-node-compare-p strategy))) ; no hace falta copy-list al hacer sort sobre el resultado de append


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; graph-search (problem strategy)
;;; Realiza la busqueda en grafo para el problema dado y de acuerdo a la
;;; estrategia proporcionada.
;;;
;;; INPUT: problem: problema sobre el que evaluar.
;;;        strategy: estrategia que seguir en la insercion y expansion.
;;;
;;; OUTPUT: Nodo objetivo o nil.
;;;
;;; Ejemplos
;
(defun graph-search (problem strategy)
  (graph-search-base
   problem
   strategy
   (list (make-node
          :state (problem-initial-state problem)
          :depth 0
          :g 0
          :f 0))
   (list )
   (problem-f-goal-test problem)
   ))

(defun graph-search-base (problem strategy open-nodes closed-nodes goal-test)
  (cond
   ; si no quedan nodos por expandir retornamos
   ((null open-nodes) nil)

   ; si al expandir el primer nodo abierto encontramos la solucion, devolvemos ese nodo
   ((funcall goal-test (node-state (first open-nodes))) (first open-nodes))

   ; si el primer nodo abierto no esta en la lista de cerrados, o esta con un valor menor,
   ; lo expandimos y agregamos a la lista de cerrados
   ((or
     (not (member (first open-nodes) closed-nodes))
     (funcall (strategy-node-compare-p strategy) (first open-nodes) (first (member (first open-nodes) closed-nodes))))
    (graph-search-base problem
                       strategy
                       (insert-nodes-strategy  (expand-node (first open-nodes) problem) (rest open-nodes) strategy)
                       (cons (first open-nodes) closed-nodes)
                       goal-test))

   ; en cualquier otro caso, seguimos la exploracion sobre el resto de la lista de abiertos
   (t (graph-search-base problem strategy (rest open-nodes) closed-nodes goal-test))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; a-star-search (problem)
;;; Realiza la busqueda A* para el problema dado.
;;;
;;; INPUT: problem: problema sobre el que evaluar.
;;;
;;; OUTPUT: Nodo objetivo o nil.
;;;
;;; Ejemplos
; (a-star-search *galaxy-M35*)
; #S(NODE :STATE SIRTIS
;         :PARENT
;         #S(NODE :STATE ...
(defun a-star-search (problem)
  (when problem
    (graph-search problem *A-star*)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; tree-path (node)
;;; Muestra la secuencia de nodos de un camino.
;;;
;;; INPUT: node: nodo final, debe tener los nodos padre encadenados.
;;;
;;; OUTPUT: Lista de node-states (etiquetas) que llevaron a node.
;;;
;;; Ejemplos
; (tree-path nil) ;-> NIL
; (tree-path #S(NODE:STATE MALLORY ...)) ;-> (KENTARES PROSERPINA MALLORY)
(defun tree-path (node)
  (when node
    (tree-path-base node () )))

(defun tree-path-base (node path)
  (if (and node (node-parent node))
      (tree-path-base (node-parent node) (cons (node-state node) path)) ; lo inserta al principio (orden inverso)
    (cons (node-state node) path))) ; solucion final


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; action-sequence (node)
;;; Muestra la secuencia de acciones de un camino.
;;;
;;; INPUT: node: nodo final, debe tener las acciones encadenadas.
;;;
;;; OUTPUT: Lista de estructuras action que llevaron a node.
;;;
;;; Ejemplos
; (action-sequence (a-star-search *galaxy-M35*))
; (#S(ACTION :NAME NAVIGATE-WHITE-HOLE :ORIGIN KENTARES :FINAL AVALON :COST 3) ...
(defun action-sequence (node)
  (when node
    (action-sequence-base node () )))

(defun action-sequence-base (node path)
  (if (and node (node-action node)) ; la accion puede ser nula
      (action-sequence-base (node-parent node) (cons (node-action node) path))
    path))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; depth-first-node-compare-p (node-1 node-2)
;;; Devuelve la comparacion para hacer busqueda por profundidad.
;;;
;;; INPUT: node1, node-2: Nodos a comparar
;;;
;;; OUTPUT: T si node-1 > node-2
;;;
;;; Ejemplos
; (tree-path (graph-search *galaxy-M35* *depth-first*))
(setf *depth-first*
  (make-strategy
   :name 'depth-first
   :node-compare-p 'depth-first-node-compare-p))

(defun depth-first-node-compare-p (node-1 node-2)
  (> (node-depth node-1) (node-depth node-2)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; breadth-first-node-compare-p (node-1 node-2)
;;; Devuelve la comparacion para hacer busqueda por anchura.
;;;
;;; INPUT: node1, node-2: Nodos a comparar
;;;
;;; OUTPUT: T si node-1 > node-2
;;;
;;; Ejemplos
; (tree-path (graph-search *galaxy-M35* *breadth-first*))
(setf *breadth-first*
  (make-strategy
   :name 'breadth-first
   :node-compare-p 'breadth-first-node-compare-p))

(defun breadth-first-node-compare-p (node-1 node-2)
  (< (node-depth node-1) (node-depth node-2)))
