#lang racket

;;A01700309
;;Rodolfo Martínez Guevara


;;Function for triangle area which receives base and height
(define (triangle-area base height)
  (/ (* base height)2))

;;Function a: n2 + 10
(define (a n)
  (+ (* 2 n)10))

;;Function b: (1/2)*n2 + 20
(define (b n)
  (* (+ (* 2 n) 20) 0.5))

;;Function c: 2-(1/n)
(define (c n)
  (- 2 (/ 1 n)))

;;Function Solutions:
;; Returns number of posible solutions for
;; a quadratic equation
;; 2 solutions if b*b > 4*a*c
;; 1 solution if b*b = 4*a*c
;; 0 solutions if b*b < 4*a*c

(define (solutions a b c)
  (cond
    [(> (* b b) (* 4(* a c))) 2]
    [(= (* b b) (* 4(* a c))) 1]
    [(< (* b b) (* 4(* a c))) 0]
    ))