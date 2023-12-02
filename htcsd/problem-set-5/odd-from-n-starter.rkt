#lang htdp/bsl
;; odd-from-n-starter.rkt


;  PROBLEM:
;  
; Design a function called odd-from-n that consumes a natural number n,
; and produces a list of all the odd numbers from n down to 1. 
; 
; Note that there is a primitive function, odd?, that produces true if
; a natural number is odd.

;; Signature: Natural -> ListOfOdd   ; no need to define ListOfOdd
;; Purpose statement: The function consumes a Natural number and returns
;;                    a list of all all odd natural number between n and 1.
;; Stub: (define (odd-from-n n) empty)

;; Examples/Tests:
(check-expect (odd-from-n 0) empty) ; zero case
(check-expect (odd-from-n 10)
              (cons 9
                    (cons 7
                          (cons 5
                                (cons 3
                                      (cons 1 empty)))))) ; recursive case

;; Template: <use template from Natural>
#;
(define (fn-for-natural n)
  (cond [(zero? n) (...)]
        [else
         (... n
         fn-for-natural (sub1 n))]))

;; Definition:
(define (odd-from-n n)
  (cond [(zero? n) empty]
        [else
         (if (odd? n)
             (cons n (odd-from-n (sub1 n)))
             (odd-from-n (sub1 n)))]))
