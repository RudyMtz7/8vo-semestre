#lang racket

;; Lab 3
;; By Victor Hugo Torres Rivera - A01701017

;; deep-all-x?: list number -> boolean
;; Purpose: To know if all the elements of the deep lists are x.
;; Example: (deep-all-x? '(2 (2 2) 2(2 (2 2) 2)) 2) should return #t
(define (deep-all-x? forest number)
    (if (null? forest)
      #t
      (and (all-x-helper (first forest) number)
        (deep-all-x? (rest forest) number))))

;; all-x-helper list number -> boolean
;; Purpose: help deep-all-x? to find if all elements of a deep list are x
(define (all-x-helper tree number)
  (if (list? tree)
    (deep-all-x? tree number)
    (cond
      [(= number tree) #t]
      [else #f])))

;; deep-reverse: depplist -> deeplist
;; Purpose: Reverse all the element of the list even if they are lists.
;; Example: (deep-reverse '(a(b(c d)) e(f g))) should return ((g f) e((d c) b) a)
(define (deep-reverse forest)
  (reverse-helper forest '()))


;; reverse-helper: list list -> list
;; Purpose: Help deep-reverse to achieve its goal
(define (reverse-helper list result)
  (if (null? list)
    result
    (if (list? (first list))
      (reverse-helper (rest list) (cons (reverse-helper (first list) '()) result))
      (reverse-helper (rest list) (cons (first list) result)))))

;; flatten: list -> list
;; Purpose: Convert a deeplist into a flat list
;; Example: (flatten '(a (b (c d)) e (f g))) should return (a b c d e f g)
(define (flatten deeplist)
  (flatten-helper deeplist '()))

(define (flatten-helper deeplist flatlist)
  (if (null? deeplist)
    flatlist
    (if (list? (first deeplist))
      (cons (first (flatten-helper (first deeplist) '()))
        (flatten (append-list (rest (first deeplist)) (rest deeplist))))
      (cons (first deeplist) (flatten-helper (rest deeplist) '())))))


;; append-list: list list -> list
;; Purpose: append one list nex to other.
;; Example: (append-list '(a b c d) '(e f g))  should return (a b c d e f g)
(define (append-list list_one list_two)
  (cond
    [(empty? list_one) list_two]
    [else (append-list (all-but-last list_one '())
      (cons (last-element list_one) list_two))]))

;; last-element: list -> number
;; Purpose: Get the last element of any list.
;; Example (last-element '(a b c d)) should return d
(define (last-element list)
  (cond
    [(empty? (rest list)) (first list)]
    [else (last-element (rest list))]))

;; all-but-last: list list-> list
;; Purpose: Delete the last element of a list.
;; Example: (all-but-last '(a b c d)) should return '(a b c)
(define (all-but-last list result_list)
  (cond
    [(empty? (rest list)) (invert result_list)]
    [else (all-but-last (rest list) (cons (first list) result_list))]))

;; invert: list -> list
;; Purpose: Invert the order of all the elements of a list.
;; Example: (invert '(a b c d)) should return '(d c b a)
(define (invert list)
  (invert-helper list '()))

;; invert-helper: list list -> list
;; Purpose: help invert to achieve it's goal.
;; Example: (invert-helper '(a b c d) '()) should return '(d c b a)
(define (invert-helper list result_list)
    (cond
      [(empty? list) result_list]
      [else (invert-helper (rest list) (cons (first list) result_list))]))

;; count-levels: deeplist -> number
;; Purpose: Count the max depth of a tree
;; Example: (count-levels '(a (b (c) (d))(e (f) (g)))) should return 3
(define (count-levels deeplist)
  (if (empty? deeplist)
    0
    (if (empty? (rest deeplist))
      1
      (+ 1 (count-helper(rest deeplist))))))

(define (count-helper deeplist)
  (if (empty? deeplist)
    0
    (max (count-levels(first deeplist)) (count-helper(rest deeplist)))))


;; count-max-arity: deeplist -> number
;; Purpose: count the max number of children a single node of the tree has
;; Example: (count-max-arity '(a (b (c)(d)) (e (f)(g)(h)(i)))) should return 4
(define (count-max-arity deeplist)
  (if (null? deeplist)
    0
    (max (count-arity (first deeplist) 0) (count-max-arity (rest deeplist)))))

(define (count-arity list number)
  (if (empty? list)
    (count-arity (rest list) (+ number 1))
    number))

;; Test
(deep-all-x? '(2 (2 2) 2(2 (2 2) 2)) 2)
(deep-reverse '(a(b(c d)) e(f g)))
(flatten '(a (b (c d)) e (f g)))
(count-levels '(a (b (c) (d))(e (f) (g))))
(count-max-arity '(a (b (c)(d)) (e (f)(g)(h)(i))))
