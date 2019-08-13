;A01700309
;Rodolfo Martínez Guevara

#lang racket

(define (bst-has? list value)
    ;Receives parameters and calls aux function
   (search list value))

;Calls aux recursive function to search in the tree
(define (search list value)
  ;Checks if the node matches the value, returns true if it does
  (if (eq? list.first value)
    #t
    ;Validates if the tree still has elements. If it does not, then returns false
    (if (null? list)
      #f
      ;Moves to the left if the value we are searching is smaller then the
      ;current node, to the right if bigger. Repeats process.
      (if (< list.first value)
        search(list.right value)
        (search(list.left value))))))

;(bst-has? '(4(2(1 3) 5(6)))) '3)
