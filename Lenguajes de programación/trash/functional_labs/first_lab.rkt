#lang racket

;; Lab 1
;; By Victor Hugo Torres Rivera - A01701017

;; triangle-area: number number -> number
;; Purpose: Calculate the area of any triangle given the base and height.
;; Example: (triangle-are 13 4) should produce 26
(define (triangle-area base height)
  (/ (* base height) 2))

;; a: number -> number
;; Purpose: Calculate 2 times n plus ten.
;; Example: (a 10) should produce 30
(define (a n)
  (+ (* 2 n) 10))

;; b: number -> number
;; Purpose: Calculate (1/2)*n2 + 20 which is the same as n + 20
;; Example: (b 20) should produce 40
(define (b n)
  (+ (* (/ 1 2) (* 2 n)) 20))

;; c: number -> number
;; Purpose: Calculate 2 - (1/n)
;; Example: (c 1) should produce 1
(define (c n)
  (- 2 (/ 1 n)))

;; solutions: number number number -> number or string
;; Purpose: Find how many possible solutions does a quadratic equation has
;; given a b and c.
;; Example: (solutions 1 0 -1) should produce 2
(define (solutions a b c)
  (cond
    [(> (* b b) (* 4 (* a c))) 2]
    [(= (* b b) (* 4 (* a c))) 1]
    [(< (* b b) (* 4 (* a c))) "No Solution"]))
