#lang htdp/bsl
;; double-starter.rkt

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
; Design a function that consumes a list of numbers and doubles every number 
; in the list. Call it double-all.
; 


;; Signature: ListOfNumber -> ListOfNumber
;; Purpose statement: The function consumes a list of numbers, multiplies
;;                    each one by 2, then returns a a new list of numbers.
;; Stub: (define (double-all lon) empty)

;; Examples/Tests:
; empty list case
(check-expect (double-all empty) empty)
; single element case
(check-expect (double-all (cons 2 empty))
              (cons 4 empty))
; multi element case
(check-expect (double-all(cons 16 (cons 2 empty)))
              (cons 32 (cons 4 empty)))

;; Template: <use template from ListOfNumber> 

;; Definition:
(define (double-all lon)
  (cond [(empty? lon) empty]
        [else
         (cons (* (first lon) 2) (double-all (rest lon)))]))

