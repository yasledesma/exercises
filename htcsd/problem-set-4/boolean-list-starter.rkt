#lang htdp/bsl
;; boolean-list-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; Design a data definition to represent a list of booleans. Call it ListOfBoolean. 
; 


;; Type: ListOfBoolean is one of:
;;           - empty
;;           - (cons Boolean ListOfBoolean)
;; Interpretation: A list of boolean values.
(define LOB1 empty)
(define LOB2 (cons true empty))
(define LOB3 (cons false (cons true empty)))

#;
(define (fn-for-lob lob)
  (cond [(empty? lob) (...)]
        [else
         (... (first lob)
              (fn-for-lob (rest lob)))]))

;; Template rules:
;;  - one of: 2 cases
;;      - atomic distinct: empty
;;      - compound: (cons Boolean ListOfBoolean)
;;  - self-reference: (rest lob) is ListOfBoolean


;; =================
;; Functions:

; 
; PROBLEM B:
; 
; Design a function that consumes a list of boolean values and produces true 
; if every value in the list is true. If the list is empty, your function 
; should also produce true. Call it all-true?
; 


;; Signature: ListOfBoolean -> Boolean
;; Purpose statement: The function consumes a list of boolean and returns
;;                    "true" if all of its elements are true.
;;                    It returns "false" otherwise.
;; Stub: (define (all-true? lob) false)

;; Examples/Tests:
; empty list case
(check-expect (all-true? empty) true)
; single element case
(check-expect (all-true? (cons true empty)) true)
; multi element case
(check-expect (all-true? (cons false (cons true empty))) false)

;; Template: <use template from ListOfBoolean> 

;; Definition:
(define (all-true? lob)
  (cond [(empty? lob) true]
        [else
         (if (first lob)
             (all-true? (rest lob))
             false)]))
