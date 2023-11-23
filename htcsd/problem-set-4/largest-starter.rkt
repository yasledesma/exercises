#lang htdp/bsl
;; largest-starter.rkt

;; =================
;; Data definitions:

; 
; Remember the data definition for a list of numbers we designed in Lecture 5f:
; (if this data definition does not look familiar, please review the lecture)
; 


;; ListOfNumber is one of:
;;  - empty
;;  - (cons Number ListOfNumber)
;; interp. a list of numbers
(define LON1 empty)
(define LON2 (cons 60 (cons 42 empty)))
#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;; Template rules used:
;;  - one of: 2 cases
;;      - atomic distinct: empty
;;      - compound: (cons Number ListOfNumber)
;;  - self-reference: (rest lon) is ListOfNumber

;; =================
;; Functions:

; 
; PROBLEM:
; 
; Design a function that consumes a list of numbers and produces the largest number 
; in the list. You may assume that all numbers in the list are greater than 0. If
; the list is empty, produce 0.
; 


;; Signature: ListOfNumber -> Number
;; Purpose statement: The function consumes a list of numbers and returns
;;                    the largest one in the list.
;; Stub: (define (largest lon) 0)

;; Examples/Tests:
; empty list case
(check-expect (largest empty) 0)
; single element case
(check-expect (largest (cons 5 empty)) 5)
; multi element case
(check-expect (largest (cons 1 (cons 5 empty))) 5)

;; Template: <use template from ListOfNumber> 

;; Definition:
(define (largest lon)
  (cond [(empty? lon) 0]
        [else
         (if (>= (first lon) (largest (rest lon)))
             (first lon)
             (largest (rest lon)))]))

;; Fucking linear search, I know

