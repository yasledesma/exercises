#lang htdp/bsl
;; rocket-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; You are designing a program to track a rocket's journey as it descends 
; 100 kilometers to Earth. You are only interested in the descent from 
; 100 kilometers to touchdown. Once the rocket has landed it is done.
; 
; Design a data definition to represent the rocket's remaining descent. 
; Call it RocketDescent.
; 

;; 1) Type: RocketDescent is one of:
;;          - Real[100 1]
;;          - "touchdown"

;; 2) Interpretation:  - Real[100 1] represents the current position
;;                       of a rocket while is descending to Earth.
;;                     - "touchdown" means the rocket has landed.

;; 3) Examples:
(define RD1 25) ; the rocket is descending.
(define RD2 "touchdown") ; the rocket has landed.

;; 4) Template:
#;
(define (fn-for-rocket-descent rs)
  (cond [(number? rs) (...rs)]
        [else (...)]))

;; 5) Template rules:
;;    - One of: 2 cases
;;              - atomic non-distinct: Real[100 1]
;;              - atomic distinct: "touchdown"

;; =================
;; Functions:

; 
; PROBLEM B:
; 
; Design a function that will output the rocket's remaining descent distance 
; in a short string that can be broadcast on Twitter. 
; When the descent is over, the message should be "The rocket has landed!".
; Call your function rocket-descent-to-msg.
; 

;; 2)
;; a_ Signature: RocketDescent -> String
;; b_ Purpose statement: The function consumes the current position
;;                       of a descending rocket and produces an informative
;;                       message.
;; c_ Stub: (define (rocket-descent-to-msg 1) "message")

;; 3) Examples
;; a_ Calling (rocket-descent-to-msg 10) should return the string "The rocket
;;    is currently at 10Km from Earth."
;; a_ Calling (rocket-descent-to-msg "touchdown") should return the string
;;    "The rocket has landed!"

;; 4) Template
#;
(define (rocket-descent-to-msg rs)
  (cond [(number? rs) (...rs)]
        [else (...rs)]))

;; 5) Definition
(define (rocket-descent-to-msg rs)
  (if (number? rs)
      (string-append "The rocket is currently at "
                     (number->string rs)
                     "Km from Earth.")
      "The rocket has landed!"))

;; 6) Testing
(check-expect
  (rocket-descent-to-msg 10)
  "The rocket is currently at 10Km from Earth.") ; as per 3)a_
(check-expect
  (rocket-descent-to-msg "touchdown")
  "The rocket has landed!") ; as per 3)b_