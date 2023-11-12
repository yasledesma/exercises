#lang htdp/bsl
;; HtDD Design Quiz

;; 1) Type: Age is Natural
;; 2) Interpretation:  The age of a person in years
;; 3) Examples:
(define A0 18)
(define A1 25)

#;
;; 4) Template:
(define (fn-for-age a)
  (... a))
;; 5) Template rules:
;;    - atomic non-distinct: Natural

; Problem 1:
; 
; Consider the above data definition for the age of a person.
; 
; Design a function called teenager? that determines whether a person
; of a particular age is a teenager (i.e., between the ages of 13 and 19).

;; 2)
;; a_ Signature: Age -> Boolean
;; b_ Purpose statement: The function consumes the age of a person and tells
;;                       whether they are a teen or not.
;; c_ Stub: (define (teenager? a) false)

;; 3) Examples
;; a_ Calling (teenager? 12) should return the boolean "false".
;; b_ Calling (teenager? 13) should return the boolean "true".
;; c_ Calling (teenager? 19) should return the boolean "true".
;; d_ Calling (teenager? 20) should return the boolean "false".

#;
;; 4) Template
(define (teenager? a)
  (...a))

;; 5) Definition
(define (teenager? a)
  (if (and (< a 20) (> a 12))
      true
      false
      ))

;; 6) Testing
(check-expect (teenager? 12) false) ; as per 3)a_
(check-expect (teenager? 13) true) ; as per 3)b_
(check-expect (teenager? 19) true) ; as per 3)c_
(check-expect (teenager? 20) false) ; as per 3)d_


; Problem 2:
; 
; Design a data definition called MonthAge to represent a person's age in months.


;; 1) Type: MonthAge is Natural
;; 2) Interpretation: The age of a person expressed in months.
;; 3) Examples:
(define MA0 12)
(define MA1 154)

#;
;; 4) Template:
(define (fn-for-month-age a)
  (...a))
;; 5) Template rules:
;;    - atomic non-distinct: Natural


; Problem 3:
; 
; Design a function called months-old that takes a person's age in years 
; and yields that person's age in months.
; 

;; 2)
;; a_ Signature: Natural -> MonthAge
;; b_ Purpose statement: The function consumes the age of a person and calculate
;;                       their age in months.
;; c_ Stub: (define (months-old 12) 144)

;; 3) Examples
;; a_ Calling (months-old 12) should return the number 144.

#;
;; 4) Template
(define (months-old age)
  (...age))

;; 5) Definition
(define (months-old age)
  (* age 12))

;; 6) Testing
(check-expect (months-old 12) 144) ; as per 3)a_


; Problem 4:
; 
; Consider a video game where you need to represent the health of your character.
; The only thing that matters about their health is:
; 
;  - if they are dead (which is shockingly poor health)
;  - if they are alive then they can have 0 or more extra lives
; 
; Design a data definition called Health to represent the health of your
; character.
; 
; Design a function called increase-health that allows you to increase
; the lives of a character.  The function should only increase the lives
; of the character if the character is not dead, otherwise the character
; remains dead.


;; Data definition:
;; 1) Type: Health is one of:
;;          - "dead"
;;          -  Natural(including 0)

;; 2) Interpretation: The health status of a videogame character where
;;                             - "dead" means the character is no longer alive.
;;                             - Natural(including 0) means the character
;;                               is alive and has n lives left.

;; 3) Examples:
(define H0 "dead")
(define H1 12)

#;
;; 4) Template:
(define (fn-for-health h)
  (cond [(number? h) (...h)]
        [else (...)]))

;; 5) Template rules:
;;    - One of: 2 cases
;;              - atomic distinct: "dead"
;;              - atomic non-distinct:  Natural(including 0)

;; Function definition:
;; 2)
;; a_ Signature: Health -> Health
;; b_ Purpose statement: The function consumes the health status of a videogame
;;                       character and gives it an extra life if they are
;;                       not dead yet.
;; c_ Stub: (define (increase-health 0) 1)

;; 3) Examples
;; a_ Calling (increase-health 0) should return the number 1.
;; b_ Calling (increase-health "dead") should return the string "dead".

#;
;; 4) Template
(define (increase-health h)
  (cond [(number? h) (...h)]
        [else (...)]))

;; 5) Definition
(define (increase-health h)
  (cond [(number? h) (+ h 1)]
        [else h]))

;; 6) Testing
(check-expect (increase-health 0) 1) ; as per 3)a_
(check-expect (increase-health "dead") "dead") ; as per 3)b_