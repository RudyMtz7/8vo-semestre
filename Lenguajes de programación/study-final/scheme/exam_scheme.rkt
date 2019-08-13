(define (bst-has-h? tree value)
  (if (list? tree)
    (bst-has? tree value)
    (cond
      [(= value tree) #t]
      [else #f])))

(define (bst-has? forest value)
  (if (null forest) #f
    (or (bst-has-h? (first forest) value)
    (bst-has? (rest forest) value))))


;;(8(5(2)(7))(11(9)(61)))
