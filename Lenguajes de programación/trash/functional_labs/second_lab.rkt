#lang racket

;; Lab 2
;; By Victor Hugo Torres Rivera - A01701017

;; power-head: number number -> number
;; Purpose: Use head recursion to calculate x^n.
;; Example: (power-head  4 3) should return 64
(define (power-head x n)
  (cond
    [(< n 1) 1]
    [else (* x (power-head x (- n 1)))]))

;; power-tail: number number -> number
;; Purpose: Use tail recursion to calculate x^n.
;; Example: (power-tail 4 3) should return 64
(define (power-tail x n)
  (power-tail-helper x n 1))

;; power-tail-recursion: number number number -> number
;; Purpose: Help 'power-tail' making the recursion with extra variable.
;; Example: (power-tail-helper 4 3 0) should return 64
(define (power-tail-helper x n result)
  (cond
    [(< n 1) result]
    [else (power-tail-helper x (- n 1) (* result x))]))

;; function-third: list -> number
;; Purpose: Return the third element of a list o any lenght.
;; Example: (third (cons 1(cons 2 (cons 3 (cons 4 empty))))) should return 3
(define (function-third list)
  (car (cdr (cdr list))))

;; just-two?: list -> boolean
;; Purpose: Return true if the list only has two element and false if not.
;; Example: (just-two? (cons 1 (cons 4 empty))) should return #t
(define (just-two? list)
  (cond
    [(empty? (rest list)) #f]
    [(empty? (rest(rest list))) #t]
    [else #f]))

;; how-many-x?: list  number -> number
;; Purpose: Counts the number of elements in a list that are equals to x.
;; Example:
;;  (define list (cons 1(cons 2 (cons 3 (cons 4 (cons 3 empty))))))
;;  (how-many-x? list 3) should return 2
(define (how-many-x? list x)
  (count-x-helper list x 0))

;; count-x-helper: list number number -> number
;; Purpose: Recursive function that helps 'how-many-x?' to achieve its purpose.
;; Example:
;;  (define list (cons 1(cons 2 (cons 3 (cons 4 (cons 3 empty))))))
;;  (count-x-helper list 3 0) should return 2
(define (count-x-helper list x counter)
  (cond
    [(empty? list) counter]
    [(= (first list) x) (count-x-helper (rest list) x (+ 1 counter))]
    [else (count-x-helper (rest list) x counter)]))

;; all-x?: list number -> boolean
;; Purpose: Returns true if all the elements in the list are equals to x.
;; Example: (all-x? (cons 2 (cons 2 (cons 2 empty)))) should return #t
(define (all-x? list x)
  (cond
    [(empty? list) #t]
    [(not (= (first list) x)) #f]
    [else (all-x? (rest list) x)]))

;; get: list number -> number
;; Purpose: To know the value stored in the nth position.
;; Example: (get (cons 1(cons 2 (cons 3 (cons 6 empty)))) 4) should return 6
(define (get list n)
  (cond
    [(= n 1) (first list)]
    [else (get (rest list) (- n 1))]))

;; difference: list list -> list
;; Purpose Compare two lists to find the element that aren't in both.
;; Example: (difference '(12 44 55 77 66 1 2 3 4) '(1 2 3))
;; should return '(4 66 77 55 44 12)
(define (difference list_one list_two)
  (difference-helper list_one list_two '()))

;; difference-helper: list list list -> list
;; Purpose: Help difference to achieve its goal.
;; Example: (difference-heleper '(12 44 55 77 66 1 2 3 4) '(1 2 3) '())
;; should return '(4 66 77 55 44 12)
(define (difference-helper list_one list_two result_list)
  (cond
    [(empty? list_one) result_list]
    [(is-in? (first list_one) list_two)
      (difference-helper (rest list_one) list_two result_list)]
    [else (difference-helper (rest list_one) list_two (cons (first list_one) result_list))]))

;; is-in?: number list -> boolean
;; Purpose: To know if a number is part of a list.
;; Example: (is-in? '(12 44 55 77 66 1 2 3 4) 1) should return #t
(define (is-in? number list)
  (cond
    [(empty? list) #f]
    [(= number (first list)) #t]
    [else (is-in? number (rest list))]))

;; append-list: list list -> list
;; Purpose: append one list nex to other.
;; Example: (append-list '(a b c d) '(e f g))  should return (a b c d e f g)
(define (append-list list_one list_two)
  (cond
    [(empty? list_one) list_two]
    [else (append-list (all-but-last list_one '()) (cons (last-element list_one) list_two))]))

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

;; sign: list -> list
;; Purpose: Create a list with a 1 for each positive number and a -1 for the negatives.
;; Example: (sign '(2 -4 -6)) should return '(1 -1 -1)
(define (sign list)
  (sign-helper list '()))

;; sign-helper: list list -> list
;; Purpose: help sign to achive its goal.
;; Example: (sign-helper '(2 -4 -6) '()) should return '(1 -1 -1)
(define (sign-helper list result_list)
  (cond
    [(empty? list) result_list]
    [(> 0 (last-element list)) (sign-helper (all-but-last list '()) (cons -1 result_list))]
    [(< 0 (last-element list)) (sign-helper (all-but-last list '()) (cons 1 result_list))]
    [else (sign-helper (all-but-last list '()) (cons 0 result_list))]))

;; negatives: list -> list
;; Purpose: Change all the elements of the list to negatives.
;; Example: (negatives '(2 -4 6)) should return (-2 -4 -6)
(define (negatives list)
  (negatives-helper list '()))

;; negatives-helper: list list -> list
;; Purpose: hepls negatives to achieve its goal.
;; Example: (negatives-heleper '(2 -4 6) '()) should return (-2 -4 -6)
(define (negatives-helper list result_list)
  (cond
    [(empty? list) result_list]
    [else (cond
      [(<= 0 (last-element list)) (negatives-helper (all-but-last list '()) (cons(- 0 (last-element list)) result_list))]
      [else (negatives-helper (all-but-last list '()) (cons (last-element list) result_list))])]))
