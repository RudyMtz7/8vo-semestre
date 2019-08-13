;; Función para sumar listas de listas

(define (add-nodes forest)
    (if (null? forest)
      0
      (+ (add-nodes-h (first forest))
        (add-nodes (rest forest)))))

(define (add-nodes-h tree)
  (if (list? tree)
    (add-nodes tree)
   (cond
     [(null? tree) 0]
     [else tree])))


(add-nodes '(1(2(3 4 (5 6)))))
