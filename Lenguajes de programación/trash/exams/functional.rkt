#lang racket

;; Quiz 3
;; By Victor Hugo Torres Rivera - A01701017

;; add-nodes: list -> number
;; Purpose: Caclculate the sum of all the nodes of atree.
;; Example: (add-nodes '(1(3)(4))) should retrun 8
(define (add-nodes list)
  (cond
    [(null? list) 0]
    [else (+ (get-node (cons (first list) '())) (add-nodes(rest list)))]))

;; get-node: list -> number
;; Get an element that is inside multimple lists.
;; Example: (get-node '((4))) should retrun 4
(define (get-node list)
  (cond
    [(list? (first list)) (get-node(first list))]
    [else (first list)]))


;; Test
(add-nodes '(100))
(add-nodes '(1 (3) (4)))
(add-nodes '(1 (2 (3) (4)) (5 (6) (7))))
(add-nodes '(1(3(6(12(40(42)))))))
(add-nodes '(100(100(1) (2))(100(3)(5))))
