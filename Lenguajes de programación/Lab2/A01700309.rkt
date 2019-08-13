#lang racket

;;A01700309
;;Rodolfo Martínez Guevara

;Exercise 1
(define (power-tail a b)
  (let power-tail-1 [(b b) (result 1)]
    (if (= b 0)
        result
        (power-tail-1 (- b 1) (* result a)))))

(define (power-head a b)
  (cond ((or (= a 1) (= b 0)) 1)
  ; If a = 1 or b = 0 returns 1 and ends recursion.
        (else (* a (power-head a (- b 1))))))
        ;Any other scenario calls recursive function and uses b and counter.

;Exercise 2
(define (third list)
  ;Returns third element in list.
  (car (cdr (cdr list))))

;Exercise 3
(define (just-two? list)
  (cond
    ;Returns false if list != to two elements
    [(empty? (rest list)) #f]
    [(empty? (rest(rest list))) #t]
    [else #f]))

;Exercise 4
(define (how-many-x? list x)
  (how-many-x-1 list x 0))

;Secondary function
(define (how-many-x-1 list x counter)
  (cond
    [(empty? list) counter]
    [(= (first list) x) (how-many-x-1 (rest list) x (+ 1 counter))]
    ;; Calls recursive function to add each x
    [else (how-many-x-1 (rest list) x counter)]))

;Exercise 5
(define (all-x? list x)
  (cond
    [(empty? list) #t]
    [(not ((first list) x)) #f]
    [else (all-x? (rest list) x)]))
    ;Returns true only if every element in the list matches 'x'

;Exercise 6
(define (get list x)
  (cond
    [(= x 1) (first list)]
    ;Reads list recursively until matching the position given in 'x'
    [else (get (rest list) (- x 1))]))

;Exercise 7
(define (difference listA listB)
  (difference-1 listA listB '()))

;Aux function for difference
(define (difference-1 listA listB result)
  (cond
    [(empty? listA) result]
    [(contains (first listA) listB)
      (difference-1 (rest listA) listB result)]
    ;Returns new list without elements in listA that match listB
    [else (difference-1 (rest listA) listB (cons (first listA) result))]))

;Aux function to check if elements match in both lists
(define (contains number list)
  (cond
    [(empty? list) #f]
    [(= number (first list)) #t]
    [else (contains number (rest list))]))

;Exercise 8
(define (append listA listB)
  (cond
    [(empty? listA) listB]
    [else (append (content listA '()) (cons (final listA) listB))]))

;Aux function for the last element in the list
(define (final list)
  (cond
    [(empty? (rest list)) (first list)]
    [else (final (rest list))]))

;Aux function for the elements in the list, except the final
(define (content list result_list)
  (cond
    [(empty? (rest list)) (invert result_list)]
    [else (content (rest list) (cons (first list) result_list))]))


;Exercise 9
(define (invert list)
  (invert-1 list '()))

;Aux function to invert
(define (invert-1 list result_list)
    (cond
      [(empty? list) result_list]
      [else (invert-1 (rest list) (cons (first list) result_list))]))

;Exercise 10
(define (sign list)
  (sign-1 list '()))

;Aux function to find the sign of the element
(define (sign-1 list result_list)
  (cond
    [(empty? list) result_list]
    [(> 0 (final list)) (sign-1 (content list '()) (cons -1 result_list))]
    [(< 0 (final list)) (sign-1 (content list '()) (cons 1 result_list))]
    [else (sign-1 (content list '()) (cons 0 result_list))]))

;Exercise 11
(define (negatives list)
  (negatives-1 list '()))

;Aux function for negatives
(define (negatives-1 list result_list)
  (cond
    [(empty? list) result_list]
    [else (cond
      [(<= 0 (final list)) (negatives-1 (content list '()) (cons(- 0 (final list)) result_list))]
      [else (negatives-1 (content list '()) (cons (final list) result_list))])]))
