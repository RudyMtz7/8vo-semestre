;;Rodolfo Martínez Guevara
;;A01700309

(define (deep-all-x? forest number)
    (if (null? forest)
      #t
      (and (deep-all-x-aux (first forest) number)
        (deep-all-x? (rest forest) number))))


;;Aux function, finds if ALL elements of list are x
(define (deep-all-x-aux tree number)
  (if (list? tree)
    (deep-all-x? tree number)
    (cond
      [(= number tree) #t]
      [else #f])))

(define (deep-reverse forest)
  (deep-reverse-aux forest '()))

;; Aux function to reverse elements in list
(define (deep-reverse-aux list result)
  (if (null? list)
    result
    (if (list? (first list))
      (deep-reverse-aux (rest list) (cons (deep-reverse-aux (first list) '()) result))
      (deep-reverse-aux (rest list) (cons (first list) result)))))

(define (flatten deeplist)
  (flatten-aux deeplist '()))

;;Aux function to transform deeplist into flatlist
(define (flatten-aux deeplist flatlist)
  (if (null? deeplist)
    flatlist
    (if (list? (first deeplist))
      (cons (first (flatten-aux (first deeplist) '()))
        (flatten (append-list (rest (first deeplist)) (rest deeplist))))
      (cons (first deeplist) (flatten-aux (rest deeplist) '())))))


;;Append two ,ists
(define (append-list listA listB)
  (cond
    [(empty? listA) listB]
    [else (append-list (all-but-last listA '())
      (cons (last-element listA) listB))]))

;;Return a lists last element
(define (last-element list)
  (cond
    [(empty? (rest list)) (first list)]
    [else (last-element (rest list))]))

;;Returns the least without it's last element
(define (all-but-last list result_list)
  (cond
    [(empty? (rest list)) (invert result_list)]
    [else (all-but-last (rest list) (cons (first list) result_list))]))

;; Invert elements in list
(define (invert list)
  (invert-aux list '()))

;;Aux function to invert list
(define (invert-aux list result_list)
    (cond
      [(empty? list) result_list]
      [else (invert-aux (rest list) (cons (first list) result_list))]))

;;Return the depth of a tree
(define (count-levels deeplist)
  (if (empty? deeplist)
    0
    (if (empty? (rest deeplist))
      1
      (+ 1 (count-aux(rest deeplist))))))

(define (count-aux deeplist)
  (if (empty? deeplist)
    0
    (max (count-levels(first deeplist)) (count-aux(rest deeplist)))))


;;Returns the max number of children from a single node of the tree
(define (count-max-arity list)
  (if (null? list)
      0
      (max (arity (car list))
         (count-max-arity (cdr list)))))

(define (arity list)
 (if (list? list)
     (max (- (length list) 1) (count-max-arity (children list)))
     0))

(define (children list)
  (cdr list))
