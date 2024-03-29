#lang htdp/bsl
;; letter-grade-starter.rkt

; 
; PROBLEM:
; 
; As part of designing a system to keep track of student grades, you are asked
; to design a data definition to represent the letter grade in a course,
; which is one of A, B or C.
;   

;; 1) Type: Grade is one of:
;;          - "A"
;;          - "B"
;;          - "C"

;; 2) Interpretation: The letter given as a grade in a course.

;; 3) Examples:
               (define GA "A")

;; 4) Template:
               (define (fn-for-grade g)
                 (cond [(= g "A") "A"]
                       [(= g "B") "B"]
                       [(= g "C") "C"]))

;; 5) Template rules:
;;    - One of: 3 cases
;;              - atomic distinct "A"
;;              - atomic distinct "B"
;;              - atomic distinct "C"
