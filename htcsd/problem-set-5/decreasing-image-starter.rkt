#lang htdp/bsl
(require 2htdp/image)

;; decreasing-image-starter.rkt

;  PROBLEM:
;  
;  Design a function called decreasing-image that consumes a Natural n
;  and produces an image of all the numbers from n to 0 side by side. 
;  
;  So (decreasing-image 3) should produce (text "3 2 1 0" 22 "black")


;; ====================
;; CONSTANTS
;; ====================

(define FS 22) ; font size
(define FC "black") ; font color


;; ====================
;; FUNCTIONS
;; ====================

;; Signature: Natural -> Image
;; Purpose statement: The function consumes a Natural number and returns
;;                    an image of the text "n n-1 ... 0".
;; Stub: (define (decreasing-image n) 0)

;; Examples/Tests:
(check-expect (decreasing-image 0) (text "0" FS FC)) ; zero case
(check-expect (decreasing-image 5) (text "5 4 3 2 1 0" FS FC)) ; recursive case

;; Template: <use template from Natural>
#;
(define (fn-for-natural n)
  (cond [(zero? n) (...)]
        [else
         (... n
         fn-for-natural (sub1 n))]))

;; Definition:
(define (decreasing-image n)
  (cond [(zero? n) (text (number->string n) FS FC)]
        [else
         (beside
          (text (string-append (number->string n) " ") FS FC)
          (decreasing-image (sub1 n)))]))
